import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hue around the edge, saturation from centre (white) to edge (pure colour).
class ColorWheel extends StatelessWidget {
  const ColorWheel({super.key, required this.hue, required this.saturation, required this.onChanged});

  final int hue; // 0-360
  final int saturation; // 0-100
  final void Function(int hue, int saturation) onChanged;

  void _update(Offset p, double size) {
    final v = p - Offset(size / 2, size / 2);
    final sat = (v.distance / (size / 2)).clamp(0.0, 1.0);
    final h = (math.atan2(v.dy, v.dx) * 180 / math.pi + 360) % 360;
    onChanged(h.round() % 360, (sat * 100).round());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = math.min(c.maxWidth, 300.0);
        final r = size / 2;
        final a = hue * math.pi / 180;
        final thumb = Offset(r + math.cos(a) * r * saturation / 100, r + math.sin(a) * r * saturation / 100);
        final current = HSVColor.fromAHSV(1, hue % 360.0, saturation / 100, 1).toColor();

        return Semantics(
          label: 'Color wheel',
          value: 'Hue $hue degrees, saturation $saturation percent',
          onIncrease: () => onChanged((hue + 10) % 360, saturation),
          onDecrease: () => onChanged((hue + 350) % 360, saturation),
          child: Center(
            child: GestureDetector(
              onPanStart: (d) {
                HapticFeedback.selectionClick();
                _update(d.localPosition, size);
              },
              onPanUpdate: (d) => _update(d.localPosition, size),
              onTapDown: (d) {
                HapticFeedback.selectionClick();
                _update(d.localPosition, size);
              },
              child: SizedBox.square(
                dimension: size,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned.fill(child: CustomPaint(painter: _WheelPainter())),
                    Positioned(
                      left: thumb.dx - 18,
                      top: thumb.dy - 18,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: current,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 10, offset: Offset(0, 2))],
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
  }

  @override
  bool shouldRepaint(_WheelPainter old) => false;
}
