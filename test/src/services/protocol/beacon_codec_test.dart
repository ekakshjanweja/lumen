import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/src/services/protocol/beacon_codec.dart';
import 'package:lumen/src/core/models/light_state.dart';
import 'package:lumen/src/core/models/paired_light.dart';

String hex(List<int> b) => b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();

void main() {
  test('matches a packet captured from the stock app', () {
    // Seen over the air: channel 100, group A, 5600K at 69%.
    const s = LightState(mode: LightMode.white, kelvin: 5600, brightness: 69);
    expect(hex(BeaconCodec.encode(const ChannelLight(100, 0), s)), '0215faa500001111abcd0123be89000000640000700045');
  });

  test('colour and effect packing', () {
    final color = BeaconCodec.encode(
      const ChannelLight(1, 2),
      const LightState(mode: LightMode.color, hue: 300, saturation: 80, brightness: 50),
    );
    expect(color.sublist(18), [0x80 | 80, 2, 0x01, 0x2c, 50]);
    final fx = BeaconCodec.encode(
      const ChannelLight(1, 0),
      const LightState(mode: LightMode.effect, effect: 7, on: false),
    );
    expect(fx.sublist(18), [0, 7 << 3, 0, 0, 0]);
  });

  test('all groups only touches the group bits', () {
    // Regression: 255 here turned white and effect commands into garbage on hardware.
    final white = BeaconCodec.encode(PairedLight.factoryDefault, const LightState(kelvin: 5600, brightness: 80));
    expect(white.sublist(18), [0x00, 0x07, 0x70, 0x00, 80]);
    final fx = BeaconCodec.encode(PairedLight.factoryDefault, const LightState(mode: LightMode.effect, effect: 10));
    expect(fx[19] >> 3, 10);
  });
}
