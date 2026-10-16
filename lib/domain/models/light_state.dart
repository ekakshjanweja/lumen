import 'package:flutter/foundation.dart';

enum LightMode { white, color, effect }

const minKelvin = 2500;
const maxKelvin = 9900;

/// What the light is showing. Pure data; how it is encoded on the wire lives
/// in the data layer.
@immutable
class LightState {
  const LightState({
    this.on = true,
    this.mode = LightMode.white,
    this.effect = 1,
    this.brightness = 50,
    this.kelvin = 5600,
    this.hue = 0,
    this.saturation = 100,
    this.flashmod = 0,
    this.tnum = 100,
    this.freq = 0,
  });

  final bool on;
  final LightMode mode;
  final int effect; // 1-24
  final int brightness; // 0-100
  final int kelvin; // 2500-9900, sent in 100 K steps
  final int hue; // 0-360
  final int saturation; // 0-100

  // Effect parameters that are only ever echoed back from connected lights.
  final int flashmod;
  final int tnum;
  final int freq;

  LightState copyWith({
    bool? on,
    LightMode? mode,
    int? effect,
    int? brightness,
    int? kelvin,
    int? hue,
    int? saturation,
  }) {
    return LightState(
      on: on ?? this.on,
      mode: mode ?? this.mode,
      effect: effect ?? this.effect,
      brightness: brightness ?? this.brightness,
      kelvin: kelvin ?? this.kelvin,
      hue: hue ?? this.hue,
      saturation: saturation ?? this.saturation,
      flashmod: flashmod,
      tnum: tnum,
      freq: freq,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is LightState &&
      other.on == on &&
      other.mode == mode &&
      other.effect == effect &&
      other.brightness == brightness &&
      other.kelvin == kelvin &&
      other.hue == hue &&
      other.saturation == saturation &&
      other.flashmod == flashmod &&
      other.tnum == tnum &&
      other.freq == freq;

  @override
  int get hashCode => Object.hash(on, mode, effect, brightness, kelvin, hue, saturation, flashmod, tnum, freq);

  @override
  String toString() =>
      'LightState(on: $on, $mode, effect: $effect, brightness: $brightness, kelvin: $kelvin, hue: $hue, sat: $saturation)';
}
