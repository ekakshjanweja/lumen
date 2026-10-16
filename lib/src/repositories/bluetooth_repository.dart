import 'dart:async';

import '../core/models/bluetooth_status.dart';
import '../core/models/light_connection.dart';
import '../services/beacon_service.dart';
import '../services/ble_service.dart';

/// Source of truth for Bluetooth availability, permissions and scanning.
class BluetoothRepository {
  BluetoothRepository({required this._ble, required this._beacon}) {
    _status = BluetoothStatus(canTurnOn: _ble.canTurnOn);
    _adapterSub = _ble.adapterStatus.listen((a) => _set(_status.copyWith(adapter: a)));
  }

  final BleService _ble;
  final BeaconService _beacon;
  late final StreamSubscription<AdapterStatus> _adapterSub;
  final _changes = StreamController<BluetoothStatus>.broadcast();
  late BluetoothStatus _status;

  BluetoothStatus get status => _status;
  Stream<BluetoothStatus> get changes => _changes.stream;

  void _set(BluetoothStatus s) {
    if (s == _status) return;
    _status = s;
    _changes.add(s);
  }

  Future<bool> turnOn() => _ble.turnOn();

  /// Prompts for the broadcast permission if needed.
  Future<bool> ensureBroadcastPermission() async {
    final ok = await _beacon.ensurePermission();
    _set(_status.copyWith(broadcastDenied: !ok));
    return ok;
  }

  /// Re-checks without prompting, e.g. after returning from system settings.
  Future<void> recheckPermission() async {
    if (_status.broadcastDenied && await _beacon.hasPermission()) {
      _set(_status.copyWith(broadcastDenied: false));
    }
  }

  Future<void> openAppSettings() => _beacon.openAppSettings();

  Stream<List<FoundLight>> scanLights() => _ble.scanLights();

  void dispose() {
    _adapterSub.cancel();
    _changes.close();
  }
}
