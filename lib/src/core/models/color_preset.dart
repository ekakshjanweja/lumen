import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_preset.freezed.dart';

/// A named colour the user can apply in one tap.
@freezed
abstract class ColorPreset with _$ColorPreset {
  const factory ColorPreset({
    required String id,
    required String name,

    /// 0-359
    required int hue,

    /// 0-100
    required int saturation,

    /// Shipped with the app, so it cannot be deleted.
    @Default(false) bool builtIn,
  }) = _ColorPreset;
}

/// Presets every user starts with.
const builtInPresets = [
  ColorPreset(id: 'red', name: 'Red', hue: 0, saturation: 100, builtIn: true),
  ColorPreset(id: 'sunset', name: 'Sunset', hue: 18, saturation: 95, builtIn: true),
  ColorPreset(id: 'amber', name: 'Amber', hue: 38, saturation: 100, builtIn: true),
  ColorPreset(id: 'lime', name: 'Lime', hue: 90, saturation: 85, builtIn: true),
  ColorPreset(id: 'green', name: 'Green', hue: 125, saturation: 100, builtIn: true),
  ColorPreset(id: 'mint', name: 'Mint', hue: 160, saturation: 55, builtIn: true),
  ColorPreset(id: 'cyan', name: 'Cyan', hue: 188, saturation: 100, builtIn: true),
  ColorPreset(id: 'sky', name: 'Sky', hue: 205, saturation: 60, builtIn: true),
  ColorPreset(id: 'blue', name: 'Blue', hue: 228, saturation: 100, builtIn: true),
  ColorPreset(id: 'violet', name: 'Violet', hue: 268, saturation: 90, builtIn: true),
  ColorPreset(id: 'magenta', name: 'Magenta', hue: 305, saturation: 100, builtIn: true),
  ColorPreset(id: 'rose', name: 'Rose', hue: 335, saturation: 60, builtIn: true),
];
