import 'dart:math' as math;

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

/// One frame of the on-screen light: two colours blended across the orb, how
/// bright it is (0-1), and how far its sheen has turned (in turns).
typedef OrbFrame = ({Color a, Color b, double level, double spin});

const _red = Color(0xFFFF3B3B);
const _blue = Color(0xFF3B6BFF);
const _white = Color(0xFFF4F6FF);
const _amber = Color(0xFFFFA53C);
const _flame = Color(0xFFFF6A1F);

/// A hint of what effect [id] looks like, [t] seconds in. Flashes are soft
/// and stay under 3 per second (WCAG 2.3.1): it previews the effect, it does
/// not copy the real strobe.
OrbFrame effectFrame(int id, double t) {
  final spin = t * 0.04;
  return switch (id) {
    1 || 2 => (a: _white, b: const Color(0xFFBFD0FF), level: 0.3 + 0.7 * _pulse(t, id == 1 ? 1.2 : 2), spin: spin),
    3 => (a: _hsv(205 + 30 * math.sin(t * 1.7)), b: _white, level: _flicker(t, 0.55), spin: spin),
    4 => (a: _amber, b: const Color(0xFFFFD08A), level: _flicker(t, 0.75), spin: spin),
    5 || 6 => (a: _flame, b: _amber, level: _flicker(t * (id == 5 ? 1 : 1.4), 0.6), spin: spin),
    7 => _alternate(_red, _blue, t, 1.25, spin),
    8 => _alternate(_red, _white, t, 1.25, spin),
    9 => _alternate(_red, _amber, t, 1.5, spin),
    10 || 11 || 12 => (
      a: _white,
      b: const Color(0xFFD7E0FF),
      level: 0.2 + 0.8 * math.pow(_pulse(t, 1.8 + 0.4 * (id - 10)), 3).toDouble(),
      spin: spin,
    ),
    13 || 14 || 15 => (a: _hsv(t * 90), b: _hsv(t * 90 + 140), level: 1, spin: t * (0.35 + 0.15 * (id - 13))),
    16 || 17 || 18 => _burst(t, 1.3 - 0.15 * (id - 16), spin),
    19 || 20 => (a: _hsv(t * 120), b: _hsv(t * 120 + 180), level: 0.55 + 0.45 * _pulse(t, 2), spin: t * 0.2),
    21 => (
      a: Color.lerp(const Color(0xFFFF6FA8), const Color(0xFFB05CFF), _pulse(t, 0.2))!,
      b: const Color(0xFFFF9AC6),
      level: 0.6 + 0.4 * _pulse(t, 0.35),
      spin: spin,
    ),
    22 => (a: _hsv(t * 30), b: _hsv(t * 30 + 90), level: 0.35 + 0.65 * math.exp(-5 * ((t * 2) % 1)), spin: spin),
    _ => (a: _hsv(t * 45 + id * 60), b: _hsv(t * 45 + id * 60 + 70), level: 0.8 + 0.2 * math.sin(t * 2), spin: t * 0.1),
  };
}

/// A steady colour, with a slightly warmer and cooler partner for depth.
OrbFrame steadyFrame(Color color, double t) {
  final hsv = HSVColor.fromColor(color);
  // Whites and pastels get a paler partner; shifting their hue tints them green.
  final partner = hsv.saturation < 0.55
      ? Color.lerp(color, Colors.white, 0.45)!
      : hsv.withHue((hsv.hue + 24) % 360).toColor();
  return (a: color, b: partner, level: 1, spin: t * 0.035);
}

/// 0-1-0 once per cycle, smoothly.
double _pulse(double t, double hz) => 0.5 - 0.5 * math.cos(2 * math.pi * hz * t);

/// Candle-like wobble around [floor]..1.
double _flicker(double t, double floor) {
  final n = 0.5 * math.sin(t * 7.3) + 0.3 * math.sin(t * 13.1 + 1) + 0.2 * math.sin(t * 23.7 + 2);
  return floor + (1 - floor) * (0.5 + 0.5 * n);
}

/// Two colours swapping places [hz] times per second, with a short blend.
OrbFrame _alternate(Color x, Color y, double t, double hz, double spin) {
  final s = math.sin(2 * math.pi * hz * t / 2);
  final m = (0.5 + 0.5 * (s * 3).clamp(-1.0, 1.0));
  return (a: Color.lerp(x, y, m)!, b: Color.lerp(y, x, m)!, level: 1, spin: spin);
}

/// A bright pop that fades, each one a new colour.
OrbFrame _burst(double t, double period, double spin) {
  final n = (t / period).floor();
  final phase = (t % period) / period;
  final hue = (n * 137.5) % 360;
  return (a: _hsv(hue), b: _hsv(hue + 50), level: 0.2 + 0.8 * math.exp(-3.5 * phase), spin: spin);
}

Color _hsv(double hue) => HSVColor.fromAHSV(1, hue % 360, 0.85, 1).toColor();
