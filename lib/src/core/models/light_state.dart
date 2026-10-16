import 'package:freezed_annotation/freezed_annotation.dart';

part 'light_state.freezed.dart';

enum LightMode { white, color, effect }

const minKelvin = 2500;
const maxKelvin = 9900;

/// What the light is showing. Pure data; how it is encoded on the wire lives
/// in the services layer.
@freezed
abstract class LightState with _$LightState {
  const factory LightState({
    @Default(true) bool on,
    @Default(LightMode.white) LightMode mode,

    /// 1-24
    @Default(1) int effect,

    /// 0-100
    @Default(50) int brightness,

    /// 2500-9900, sent in 100 K steps
    @Default(5600) int kelvin,

    /// 0-360
    @Default(0) int hue,

    /// 0-100
    @Default(100) int saturation,

    // Effect parameters that are only ever echoed back from connected lights.
    @Default(0) int flashmod,
    @Default(100) int tnum,
    @Default(0) int freq,
  }) = _LightState;
}
