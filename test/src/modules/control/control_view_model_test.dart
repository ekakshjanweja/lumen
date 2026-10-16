import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/src/core/models/light_connection.dart';
import 'package:lumen/src/core/models/light_state.dart';
import 'package:lumen/src/core/models/paired_light.dart';
import 'package:lumen/src/modules/control/view_models/control_view_model.dart';

import '../../../testing/fakes.dart';

void main() {
  late FakeLightRepository lights;

  setUp(() {
    lights = FakeLightRepository()
      ..connection = const LightConnection(PairedLight.factoryDefault, LinkStatus.connected)
      ..state = const LightState(on: false, brightness: 40);
  });

  test('changing brightness turns the light on and clamps', () {
    final c = makeContainer(lights: lights);
    final vm = c.read(controlViewModelProvider.notifier);

    vm.setBrightness(0);

    expect(lights.applied.single, const LightState(on: true, brightness: 1));
    expect(c.read(controlViewModelProvider).light.brightness, 1);
  });

  test('level 0 turns the light off and keeps the last brightness', () {
    final c = makeContainer(lights: lights);
    c.read(controlViewModelProvider.notifier)
      ..setLevel(65)
      ..setLevel(0);

    expect(lights.applied.map((s) => (s.on, s.brightness)), [(true, 65), (false, 65)]);
  });

  test('toggle power flips on/off without touching other fields', () {
    final c = makeContainer(lights: lights);
    c.read(controlViewModelProvider.notifier)
      ..togglePower()
      ..togglePower();

    expect(lights.applied.map((s) => s.on), [true, false]);
    expect(lights.applied.last.brightness, 40);
  });

  test('picking an effect switches to effect mode', () {
    final c = makeContainer(lights: lights);
    c.read(controlViewModelProvider.notifier).selectEffect(9);

    expect(lights.state.mode, LightMode.effect);
    expect(lights.state.effect, 9);
  });

  test('colour wraps hue and clamps saturation', () {
    final c = makeContainer(lights: lights);
    c.read(controlViewModelProvider.notifier).setColor(370, 150);

    expect((lights.state.hue, lights.state.saturation), (10, 100));
  });

  test('reflects state reported by the light', () async {
    final c = makeContainer(lights: lights);
    c.listen(controlViewModelProvider, (_, _) {});

    lights.report(const LightState(mode: LightMode.color, hue: 120));
    await Future<void>.delayed(Duration.zero);

    expect(c.read(controlViewModelProvider).light.hue, 120);
  });

  test('channel lights show no link status; connected lights do', () {
    expect(makeContainer(lights: lights).read(controlViewModelProvider).showsLinkStatus, isFalse);

    lights.connection = const LightConnection(ConnectedLight('id', 'Desk'), LinkStatus.reconnecting);
    final state = makeContainer(lights: lights).read(controlViewModelProvider);
    expect(state.showsLinkStatus, isTrue);
    expect(state.name, 'Desk');
  });

  test('find light again forgets the pairing', () async {
    final c = makeContainer(lights: lights);
    await c.read(controlViewModelProvider.notifier).findLightAgain();

    expect(lights.forgotten, isTrue);
  });
}
