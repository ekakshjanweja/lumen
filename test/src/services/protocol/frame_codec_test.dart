import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/src/services/protocol/frame_codec.dart';
import 'package:lumen/src/core/models/light_state.dart';

void main() {
  test('white 5600K at 80%', () {
    const s = LightState(mode: LightMode.white, brightness: 80, kelvin: 5600, saturation: 0);
    expect(FrameCodec.encode(s), [1, 1, 80, 56, 0, 0, 0, 0, 100, 0]);
  });

  test('hue is little-endian', () {
    const s = LightState(mode: LightMode.color, brightness: 50, hue: 300, saturation: 100);
    expect(FrameCodec.encode(s).sublist(4, 7), [0x2c, 0x01, 100]);
  });

  test('off keeps the other fields', () {
    const s = LightState(on: false, mode: LightMode.color, brightness: 50, hue: 120);
    expect(FrameCodec.encode(s)[0], 0);
    expect(FrameCodec.encode(s)[2], 50);
  });

  test('values are clamped', () {
    const s = LightState(kelvin: 20000, hue: 999, brightness: 140, effect: 0);
    expect(FrameCodec.encode(s).sublist(1, 6), [1, 100, 99, 360 & 0xff, 360 >> 8]);
  });

  test('decode reads a report and keeps the mode when off', () {
    final on = FrameCodec.decode([
      3,
      7,
      42,
      32,
      10,
      0,
      90,
      1,
      100,
      5,
    ], previous: const LightState(mode: LightMode.color))!;
    expect(on.mode, LightMode.effect);
    expect(on.effect, 7);
    expect(on.kelvin, 3200);
    expect(on.freq, 5);
    final off = FrameCodec.decode([0, 7, 42, 32, 10, 0, 90, 1, 100, 5], previous: on)!;
    expect(off.on, false);
    expect(off.mode, LightMode.effect);
    expect(FrameCodec.decode([1, 2, 3]), isNull);
  });

  test('round trip preserves echoed effect params', () {
    final s = FrameCodec.decode([3, 4, 60, 56, 0, 0, 0, 2, 77, 9])!;
    expect(FrameCodec.encode(s.copyWith(brightness: 10)), [3, 4, 10, 56, 0, 0, 0, 2, 77, 9]);
  });
}
