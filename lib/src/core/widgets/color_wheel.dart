import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

/// Hue around the edge, saturation from centre (white) to edge (pure colour).
/// The thumb lifts while dragging and glides when the colour is set elsewhere.
class ColorWheel extends StatefulWidget {
  const ColorWheel({super.key, required this.hue, required this.saturation, required this.onChanged});

  final int hue; // 0-360
  final int saturation; // 0-100
  final void Function(int hue, int saturation) onChanged;

  @override
  State<ColorWheel> createState() => _ColorWheelState();
}

class _ColorWheelState extends State<ColorWheel> {
  bool _dragging = false;

  void _update(Offset p, double size) {
    final v = p - Offset(size / 2, size / 2);
    final sat = (v.distance / (size / 2)).clamp(0.0, 1.0);
    final h = (math.atan2(v.dy, v.dx) * 180 / math.pi + 360) % 360;
    widget.onChanged(h.round() % 360, (sat * 100).round());
  }

  void _drag(bool on) {
    if (on != _dragging) setState(() => _dragging = on);
  }

  @override
  Widget build(BuildContext context) {
    final hue = widget.hue;
    final saturation = widget.saturation;
    return LayoutBuilder(
      builder: (context, c) {
        final size = math.min(c.maxWidth, 300.0);
        final r = size / 2;
        final a = hue * math.pi / 180;
        final thumb = Offset(r + math.cos(a) * r * saturation / 100, r + math.sin(a) * r * saturation / 100);
        final current = HSVColor.fromAHSV(1, hue % 360.0, saturation / 100, 1).toColor();
        String describe(int h) => 'Hue $h degrees, saturation $saturation percent';

        return Semantics(
          label: 'Color wheel',
          value: describe(hue),
          increasedValue: describe((hue + 10) % 360),
          decreasedValue: describe((hue + 350) % 360),
          onIncrease: () => widget.onChanged((hue + 10) % 360, saturation),
          onDecrease: () => widget.onChanged((hue + 350) % 360, saturation),
          child: Center(
            child: GestureDetector(
              onPanStart: (d) {
                HapticFeedback.selectionClick();
                _drag(true);
                _update(d.localPosition, size);
              },
              onPanUpdate: (d) => _update(d.localPosition, size),
              onPanEnd: (_) => _drag(false),
              onPanCancel: () => _drag(false),
              onTapDown: (d) {
                HapticFeedback.selectionClick();
                _update(d.localPosition, size);
              },
              child: SizedBox.square(
                dimension: size,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: Motion.medium,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: current.withValues(alpha: 0.3), blurRadius: 48, spreadRadius: 2),
                          ],
                        ),
                        child: const CustomPaint(painter: _WheelPainter()),
                      ),
                    ),
                    TweenAnimationBuilder<Offset>(
                      tween: Tween(end: thumb),
                      duration: _dragging ? Duration.zero : const Duration(milliseconds: 420),
                      curve: Motion.emphasized,
                      builder: (context, at, child) => Positioned(left: at.dx - 20, top: at.dy - 20, child: child!),
                      child: AnimatedScale(
                        scale: _dragging ? 1.3 : 1,
                        duration: Motion.medium,
                        curve: Motion.spring,
                        child: AnimatedContainer(
                          duration: Motion.fast,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: current,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: const [
                              BoxShadow(color: Color(0x80000000), blurRadius: 14, offset: Offset(0, 3)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WheelPainter extends CustomPainter {
  const _WheelPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.shortestSide / 2;
    final hues = Paint()
      ..shader = SweepGradient(
        colors: [for (var h = 0; h <= 360; h += 30) HSVColor.fromAHSV(1, h % 360.0, 1, 1).toColor()],
      ).createShader(rect);
    final whites = Paint()..shader = const RadialGradient(colors: [Colors.white, Color(0x00FFFFFF)]).createShader(rect);
    canvas.drawCircle(center, radius, hues);
    canvas.drawCircle(center, radius, whites);
    canvas.drawCircle(
      center,
      radius - 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white.withValues(alpha: 0.18),
    );
  }

  @override
  bool shouldRepaint(_WheelPainter old) => false;
}
