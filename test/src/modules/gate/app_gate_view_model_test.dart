import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/src/core/models/bluetooth_status.dart';
import 'package:lumen/src/core/models/light_connection.dart';
import 'package:lumen/src/core/models/paired_light.dart';
import 'package:lumen/src/modules/gate/view_models/app_gate_view_model.dart';

import '../../../testing/fakes.dart';

void main() {
  AppScreen screenFor(FakeBluetoothRepository bt, [FakeLightRepository? lights]) =>
      makeContainer(bluetooth: bt, lights: lights).read(appGateViewModelProvider).screen;

  test('waits for Bluetooth to report its state', () {
    expect(screenFor(FakeBluetoothRepository(adapter: AdapterStatus.unknown)), AppScreen.splash);
  });

  test('asks to turn Bluetooth on', () {
    expect(screenFor(FakeBluetoothRepository(adapter: AdapterStatus.off)), AppScreen.bluetoothOff);
  });

  test('first run goes to search', () {
    expect(screenFor(FakeBluetoothRepository()), AppScreen.search);
  });

  test('a paired light goes straight to controls and gets permission requested', () async {
    final bt = FakeBluetoothRepository()..grantPermission = false;
    final lights = FakeLightRepository()
      ..connection = const LightConnection(PairedLight.factoryDefault, LinkStatus.connected);
    final c = makeContainer(bluetooth: bt, lights: lights);
    c.listen(appGateViewModelProvider, (_, _) {});

    expect(c.read(appGateViewModelProvider).screen, AppScreen.control);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(c.read(appGateViewModelProvider).screen, AppScreen.permission);
  });

  test('pairing switches from search to controls', () async {
    final lights = FakeLightRepository();
    final c = makeContainer(lights: lights);
    c.listen(appGateViewModelProvider, (_, _) {});

    await lights.pairChannel(PairedLight.factoryDefault);
    await Future<void>.delayed(Duration.zero);

    expect(c.read(appGateViewModelProvider).screen, AppScreen.control);
  });

  test('iOS-style denied Bluetooth sends the user to settings', () {
    final c = makeContainer(bluetooth: FakeBluetoothRepository(adapter: AdapterStatus.unauthorized));
    final state = c.read(appGateViewModelProvider);
    expect(state.screen, AppScreen.permission);
    expect(state.needsSettings, isTrue);
  });
}
