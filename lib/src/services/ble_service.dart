import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../core/models/bluetooth_status.dart';
import '../core/models/light_connection.dart';
import 'protocol/frame_codec.dart';

/// Thin wrapper over flutter_blue_plus for scanning and GATT connections.
class BleService {
  BleService() {
    FlutterBluePlus.setLogLevel(LogLevel.none);
  }

  Stream<AdapterStatus> get adapterStatus => FlutterBluePlus.adapterState.map(
    (s) => switch (s) {
      BluetoothAdapterState.on => AdapterStatus.on,
      BluetoothAdapterState.unauthorized => AdapterStatus.unauthorized,
      BluetoothAdapterState.unavailable => AdapterStatus.unavailable,
      BluetoothAdapterState.unknown || BluetoothAdapterState.turningOn => AdapterStatus.unknown,
      _ => AdapterStatus.off,
    },
  );

  /// Only Android lets apps switch Bluetooth on.
  bool get canTurnOn => Platform.isAndroid;

  Future<bool> turnOn() async {
    if (!canTurnOn) return false;
    try {
      await FlutterBluePlus.turnOn();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Scans for lights that advertise themselves, strongest first. The stream
  /// ends when the scan times out; cancelling it stops the scan.
  Stream<List<FoundLight>> scanLights({Duration timeout = const Duration(seconds: 15)}) {
    StreamSubscription<List<ScanResult>>? results;
    late final StreamController<List<FoundLight>> out;
    out = StreamController(
      onListen: () async {
        results = FlutterBluePlus.onScanResults.listen((rs) {
          out.add(
            [
              for (final r in rs)
                if (FrameCodec.nameKeywords.any(_nameOf(r).contains))
                  FoundLight(r.device.remoteId.str, _nameOf(r), r.rssi),
            ]..sort((a, b) => b.rssi.compareTo(a.rssi)),
          );
        });
        try {
          await FlutterBluePlus.startScan(
            timeout: timeout,
            continuousUpdates: true,
            removeIfGone: const Duration(seconds: 6),
          );
          await FlutterBluePlus.isScanning.where((s) => !s).first;
        } catch (e) {
          if (!out.isClosed) out.addError(e);
        }
        await results?.cancel();
        if (!out.isClosed) await out.close();
      },
      onCancel: () async {
        await results?.cancel();
        await FlutterBluePlus.stopScan();
      },
    );
    return out.stream;
  }

  static String _nameOf(ScanResult r) =>
      r.advertisementData.advName.isNotEmpty ? r.advertisementData.advName : r.device.platformName;

  /// Connects to a light by id and prepares its characteristics.
  Future<GattLink> connect(String id, {Duration timeout = const Duration(seconds: 12)}) async {
    final device = BluetoothDevice.fromId(id);
    await FlutterBluePlus.stopScan();
    try {
      await device.connect(license: License.nonprofit, timeout: timeout, mtu: null);
      final services = await device.discoverServices();
      final svc = services.firstWhere(
        (s) => s.uuid == Guid(FrameCodec.serviceUuid),
        orElse: () => throw StateError('Not a supported light'),
      );
      final tx = svc.characteristics.firstWhere((c) => c.uuid == Guid(FrameCodec.txUuid));
      final rx = svc.characteristics.where((c) => c.uuid == Guid(FrameCodec.rxUuid)).firstOrNull;
      if (rx != null && (rx.properties.notify || rx.properties.indicate)) await rx.setNotifyValue(true);
      return GattLink._(device, tx, rx);
    } catch (_) {
      await device.disconnect().catchError((_) {});
      rethrow;
    }
  }
}

/// An open connection to a light.
class GattLink {
  GattLink._(this._device, this._tx, this._rx);

  final BluetoothDevice _device;
  final BluetoothCharacteristic _tx;
  final BluetoothCharacteristic? _rx;

  /// State reports pushed by the light (and replies to [requestState]).
  Stream<List<int>> get reports => _rx?.onValueReceived ?? const Stream.empty();

  /// Completes when the connection drops.
  Future<void> get disconnected =>
      _device.connectionState.firstWhere((s) => s == BluetoothConnectionState.disconnected);

  Future<void> write(List<int> frame) => _tx.write(frame, withoutResponse: _tx.properties.writeWithoutResponse);

  /// Asks the light for its current state; the reply arrives on [reports].
  Future<void> requestState() async {
    if (_rx?.properties.read ?? false) await _rx!.read().catchError((_) => <int>[]);
  }

  Future<void> close() => _device.disconnect().catchError((_) {});
}
