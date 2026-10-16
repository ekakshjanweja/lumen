import '../../core/models/light_state.dart';

/// The 10-byte frame used by connectable (GATT) lights, and also how the app
/// stores the last state. See PROTOCOL.md.
///
/// `[mode, effect, brightness, kelvin/100, hueLo, hueHi, sat, flashmod, tnum, freq]`
abstract final class FrameCodec {
  static const nameKeywords = ['LTF_MWRGB', 'LYD_MWRGB', 'Bough_Systems'];
  static const serviceUuid = '0000fff0-0000-1000-8000-00805f9b34fb';
  static const txUuid = '0000fff3-0000-1000-8000-00805f9b34fb';
  static const rxUuid = '0000fff4-0000-1000-8000-00805f9b34fb';

  static int _code(LightMode m) => switch (m) {
    LightMode.white => 1,
    LightMode.color => 2,
    LightMode.effect => 3,
  };

  static List<int> encode(LightState s) {
    final k = (s.kelvin / 100).round().clamp(minKelvin ~/ 100, maxKelvin ~/ 100);
    final h = s.hue.clamp(0, 360);
    return [
      s.on ? _code(s.mode) : 0,
      s.effect.clamp(1, 24),
      s.brightness.clamp(0, 100),
      k,
      h & 0xff,
      h >> 8,
      s.saturation.clamp(0, 100),
      s.flashmod & 0xff,
      s.tnum & 0xff,
      s.freq & 0xff,
    ];
  }

  /// Reads a state report on top of [previous]. Returns null if [b] is not a
  /// state report. An "off" report keeps the previous mode, since the light
  /// does not say which mode it will resume in.
  static LightState? decode(List<int> b, {LightState previous = const LightState()}) {
    if (b.length < 10) return null;
    final LightMode? reported = switch (b[0]) {
      0 => null,
      1 => LightMode.white,
      2 => LightMode.color,
      3 || 5 => LightMode.effect,
      _ => previous.mode,
    };
    final k = b[3] * 100;
    return LightState(
      on: b[0] != 0,
      mode: reported ?? previous.mode,
      effect: b[1].clamp(1, 24),
      brightness: b[2].clamp(0, 100),
      kelvin: k >= minKelvin && k <= maxKelvin ? k : previous.kelvin,
      hue: (b[4] | (b[5] << 8)).clamp(0, 360),
      saturation: b[6].clamp(0, 100),
      flashmod: b[7],
      tnum: b[8],
      freq: b[9],
    );
  }
}
