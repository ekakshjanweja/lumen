import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/src/core/providers.dart';
import 'package:lumen/src/repositories/bluetooth_repository.dart';
import 'package:lumen/src/repositories/light_repository.dart';
import 'package:lumen/src/core/models/bluetooth_status.dart';
import 'package:lumen/src/core/models/light_connection.dart';
import 'package:lumen/src/core/models/light_state.dart';
import 'package:lumen/src/core/models/paired_light.dart';

/// In-memory light repository that records what the view models asked for.
class FakeLightRepository implements LightRepository {
  final _connectionChanges = StreamController<LightConnection>.broadcast();
  final _stateChanges = StreamController<LightState>.broadcast();

  @override
  LightConnection connection = LightConnection.none;
  @override
  LightState state = const LightState();

  final applied = <LightState>[];
  final probes = <(ChannelLight, LightState)>[];
  ChannelLight? paired;
  bool forgotten = false;
  int endProbeCalls = 0;

  void setConnection(LightConnection c) {
    connection = c;
    _connectionChanges.add(c);
  }

  /// Simulates the light reporting a new state.
  void report(LightState s) {
    state = s;
    _stateChanges.add(s);
  }

  @override
  Stream<LightConnection> get connectionChanges => _connectionChanges.stream;
  @override
  Stream<LightState> get stateChanges => _stateChanges.stream;

  @override
  void apply(LightState next) {
    state = next;
    applied.add(next);
    _stateChanges.add(next);
  }

  @override
  Future<void> pairChannel(ChannelLight light) async {
    paired = light;
    setConnection(LightConnection(light, LinkStatus.connected));
  }

  @override
  Future<bool> connect(FoundLight found) async {
    setConnection(LightConnection(ConnectedLight(found.id, found.name), LinkStatus.connected));
    return true;
  }

  @override
  Future<void> forget() async {
    forgotten = true;
    setConnection(LightConnection.none);
  }

  @override
  Future<void> probe(ChannelLight target, LightState s) async => probes.add((target, s));

  @override
  Future<void> endProbe() async => endProbeCalls++;

  @override
  Future<void> restore() async {}
  @override
  void pause() {}
  @override
  void resume() {}
  @override
  void dispose() {}
}

class FakeBluetoothRepository implements BluetoothRepository {
  FakeBluetoothRepository({AdapterStatus adapter = AdapterStatus.on}) : status = BluetoothStatus(adapter: adapter);

  final _changes = StreamController<BluetoothStatus>.broadcast();
  final nearby = StreamController<List<FoundLight>>.broadcast();
  bool grantPermission = true;

  @override
  BluetoothStatus status;

  void setStatus(BluetoothStatus s) {
    status = s;
    _changes.add(s);
  }

  @override
  Stream<BluetoothStatus> get changes => _changes.stream;

  @override
  Future<bool> ensureBroadcastPermission() async {
    setStatus(status.copyWith(broadcastDenied: !grantPermission));
    return grantPermission;
  }

  @override
  Stream<List<FoundLight>> scanLights() => nearby.stream;

  @override
  Future<bool> turnOn() async => false;
  @override
  Future<void> recheckPermission() async {}
  @override
  Future<void> openAppSettings() async {}
  @override
  void dispose() {}
}

ProviderContainer makeContainer({FakeLightRepository? lights, FakeBluetoothRepository? bluetooth}) {
  final container = ProviderContainer(
    overrides: [
      lightRepositoryProvider.overrideWithValue(lights ?? FakeLightRepository()),
      bluetoothRepositoryProvider.overrideWithValue(bluetooth ?? FakeBluetoothRepository()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}
