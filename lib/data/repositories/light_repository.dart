import 'dart:async';

import 'package:flutter/services.dart';

import '../../domain/models/bluetooth_status.dart';
import '../../domain/models/light_connection.dart';
import '../../domain/models/light_state.dart';
import '../../domain/models/paired_light.dart';
import '../services/beacon_service.dart';
import '../services/ble_service.dart';
import '../services/preferences_service.dart';
import '../services/protocol/beacon_codec.dart';
import '../services/protocol/frame_codec.dart';

/// Source of truth for the paired light and what it is showing.
///
/// Channel lights get the current state broadcast continuously; connected
/// lights get it written over GATT, and report their own state back.
class LightRepository {
  LightRepository({required this._beacon, required this._ble, required this._prefs});

  static const _gattWriteGap = Duration(milliseconds: 35);
  static const _beaconGap = Duration(milliseconds: 120);
  static const _echoHoldoff = Duration(milliseconds: 700);
  static const _retryDelay = Duration(seconds: 2);

  final BeaconService _beacon;
  final BleService _ble;
  final PreferencesService _prefs;

  final _connectionChanges = StreamController<LightConnection>.broadcast();
  final _stateChanges = StreamController<LightState>.broadcast();
  LightConnection _connection = const LightConnection.none();
  LightState _state = const LightState();

  GattLink? _link;
  StreamSubscription<List<int>>? _reports;
  StreamSubscription<AdapterStatus>? _adapter;
  bool _dirty = false;
  bool _pumping = false;
  bool _paused = false;
  bool _reconnecting = false;
  bool _disposed = false;
  DateTime _lastLocalChange = DateTime(0);
  Timer? _saveTimer;

  LightConnection get connection => _connection;
  Stream<LightConnection> get connectionChanges => _connectionChanges.stream;
  LightState get state => _state;
  Stream<LightState> get stateChanges => _stateChanges.stream;

  /// Loads the saved light and state. Commands start flowing once Bluetooth is on.
  Future<void> restore() async {
    _state = _prefs.loadState() ?? const LightState();
    switch (_prefs.loadLight()) {
      case final ChannelLight light:
        _setConnection(LightConnection(light, LinkStatus.connected));
      case final ConnectedLight light:
        _setConnection(LightConnection(light, LinkStatus.connecting));
      case null:
        break;
    }
    _adapter = _ble.adapterStatus.listen(_onAdapter);
  }

  void _onAdapter(AdapterStatus status) {
    if (status != AdapterStatus.on) return;
    switch (_connection.light) {
      case ChannelLight():
        _queueSend();
      case final ConnectedLight light when _link == null:
        _reconnectLoop(light);
      default:
        break;
    }
  }

  // ---- Pairing ----

  Future<void> pairChannel(ChannelLight light) async {
    await _closeLink();
    _setConnection(LightConnection(light, LinkStatus.connected));
    await _prefs.saveLight(light);
    _queueSend();
  }

  Future<bool> connect(FoundLight found) async {
    final light = ConnectedLight(found.id, found.name);
    await _closeLink();
    await _beacon.stop();
    _setConnection(LightConnection(light, LinkStatus.connecting));
    if (!await _open(light)) {
      _setConnection(const LightConnection.none());
      return false;
    }
    await _prefs.saveLight(light);
    return true;
  }

  Future<void> forget() async {
    await _closeLink();
    await _beacon.stop();
    _setConnection(const LightConnection.none());
    await _prefs.saveLight(null);
  }

  Future<bool> _open(ConnectedLight light) async {
    try {
      final link = await _ble.connect(light.id);
      if (_connection.light != light) {
        await link.close(); // forgotten while connecting
        return false;
      }
      _link = link;
      _reports = link.reports.listen(_onReport);
      await link.requestState();
      _setConnection(LightConnection(light, LinkStatus.connected));
      unawaited(link.disconnected.then((_) => _onDropped(link)));
      return true;
    } catch (_) {
      return false;
    }
  }

  void _onDropped(GattLink link) {
    if (_link != link) return; // closed on purpose
    _reports?.cancel();
    _link = null;
    final light = _connection.light;
    if (light is ConnectedLight) {
      _setConnection(LightConnection(light, LinkStatus.reconnecting));
      _reconnectLoop(light);
    }
  }

  Future<void> _reconnectLoop(ConnectedLight light) async {
    if (_reconnecting) return;
    _reconnecting = true;
    while (!_disposed && _connection.light == light && _link == null) {
      if (await _open(light)) {
        _queueSend();
        break;
      }
      await Future<void>.delayed(_retryDelay);
    }
    _reconnecting = false;
  }

  Future<void> _closeLink() async {
    final link = _link;
    _link = null;
    await _reports?.cancel();
    await link?.close();
  }

  // ---- Control ----

  void apply(LightState next) {
    _state = next;
    _stateChanges.add(next);
    _lastLocalChange = DateTime.now();
    _queueSend();
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), () => _prefs.saveState(_state));
  }

  void _onReport(List<int> bytes) {
    // Ignore echoes while the user is dragging, or sliders would jitter.
    if (DateTime.now().difference(_lastLocalChange) < _echoHoldoff) return;
    final next = FrameCodec.decode(bytes, previous: _state);
    if (next == null || next == _state) return;
    _state = next;
    _stateChanges.add(next);
  }

  /// Broadcasts [s] to an arbitrary channel/group while searching.
  Future<void> probe(ChannelLight target, LightState s) async {
    try {
      await _beacon.advertise(BeaconCodec.encode(target, s));
    } on PlatformException {
      // Permission or adapter problems surface through BluetoothRepository.
    }
  }

  /// Ends probing and goes back to whatever the paired light needs.
  Future<void> endProbe() async {
    if (_connection.light is ChannelLight) {
      _queueSend();
    } else {
      await _beacon.stop();
    }
  }

  /// Broadcasting runs continuously, so stop while the app is in the background.
  void pause() {
    _paused = true;
    if (_connection.light is ChannelLight) _beacon.stop();
  }

  void resume() {
    _paused = false;
    if (_connection.light is ChannelLight) _queueSend();
  }

  /// Sends the latest state, coalescing rapid changes so the light always
  /// ends on the newest value without a backlog of stale writes.
  void _queueSend() {
    _dirty = true;
    if (!_pumping) _pump();
  }

  Future<void> _pump() async {
    _pumping = true;
    while (_dirty && !_paused && !_disposed) {
      _dirty = false;
      try {
        switch (_connection.light) {
          case final ChannelLight light:
            await _beacon.advertise(BeaconCodec.encode(light, _state));
            await Future<void>.delayed(_beaconGap);
          case ConnectedLight() when _link != null:
            await _link!.write(FrameCodec.encode(_state));
            await Future<void>.delayed(_gattWriteGap);
          default:
            break;
        }
      } catch (_) {
        // A dropped link reconnects on its own; the next change resends.
      }
    }
    _pumping = false;
  }

  void _setConnection(LightConnection c) {
    if (c == _connection) return;
    _connection = c;
    _connectionChanges.add(c);
  }

  void dispose() {
    _disposed = true;
    _saveTimer?.cancel();
    _adapter?.cancel();
    _reports?.cancel();
    _connectionChanges.close();
    _stateChanges.close();
  }
}
