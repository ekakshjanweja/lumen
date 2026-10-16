import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/models/effect.dart';
import '../../domain/models/light_state.dart';

/// Presentation helpers: how a light state looks and reads on screen.
extension LightStateLook on LightState {
  /// Approximate colour the light is emitting, for previews.
  Color get previewColor => switch (mode) {
    LightMode.white => kelvinToColor(kelvin),
    LightMode.color => HSVColor.fromAHSV(1, hue % 360.0, saturation / 100, 1).toColor(),
    LightMode.effect => effectColor(effect),
  };

  /// Short description, e.g. "5600K", "Cyan", "Police".
  String get caption => switch (mode) {
    LightMode.white => '${kelvin}K',
    LightMode.color => colorName(hue, saturation),
    LightMode.effect => effectById(effect).name,
  };
}

/// Blackbody approximation (Tanner Helland), good enough for UI tinting.
Color kelvinToColor(int kelvin) {
  final t = kelvin / 100.0;
  double r, g, b;
  if (t <= 66) {
    r = 255;
    g = 99.4708025861 * math.log(t) - 161.1195681661;
    b = t <= 19 ? 0 : 138.5177312231 * math.log(t - 10) - 305.0447927307;
  } else {
    r = 329.698727446 * math.pow(t - 60, -0.1332047592);
    g = 288.1221695283 * math.pow(t - 60, -0.0755148492);
    b = 255;
  }
  int c(double v) => v.clamp(0, 255).round();
  return Color.fromARGB(255, c(r), c(g), c(b));
}

Color effectColor(int id) => switch (id) {
  3 => const Color(0xFF7FA8FF),
  4 || 5 || 6 => const Color(0xFFFF9A3C),
  7 => const Color(0xFF4D7CFF),
  8 || 9 => const Color(0xFFFF4D4D),
  21 => const Color(0xFFFF6FA8),
  >= 13 => const Color(0xFFB07CFF),
  _ => const Color(0xFFF2F4FF),
};

String colorName(int hue, int saturation) {
  if (saturation < 15) return 'White';
  const names = [
    (15, 'Red'),
    (40, 'Orange'),
    (65, 'Yellow'),
    (150, 'Green'),
    (195, 'Cyan'),
    (255, 'Blue'),
    (290, 'Purple'),
    (335, 'Pink'),
    (361, 'Red'),
  ];
  final name = names.firstWhere((n) => hue < n.$1).$2;
  return saturation < 60 ? 'Pastel ${name.toLowerCase()}' : name;
}
