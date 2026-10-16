import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

/// A colour pad: hue runs left to right, saturation fades to white towards
/// the bottom. It stretches to whatever space it is given. The thumb lifts
/// while dragging and glides when the colour is set elsewhere.
class ColorField extends StatefulWidget {
  const ColorField({super.key, required this.hue, required this.saturation, required this.onChanged});

  final int hue; // 0-359
  final int saturation; // 0-100
  final void Function(int hue, int saturation) onChanged;

  @override
  State<ColorField> createState() => _ColorFieldState();
}

class _ColorFieldState extends State<ColorField> {
  static const _radius = 28.0;
  static const _thumb = 38.0;

  bool _dragging = false;

  void _update(Offset p, Size size) {
    final x = (p.dx / size.width).clamp(0.0, 1.0);
    final y = (p.dy / size.height).clamp(0.0, 1.0);
    widget.onChanged((x * 359).round(), ((1 - y) * 100).round());
  }

  void _drag(bool on) {
    if (on != _dragging) setState(() => _dragging = on);
  }

  @override
  Widget build(BuildContext context) {
    final hue = widget.hue;
    final saturation = widget.saturation;
    final current = HSVColor.fromAHSV(1, hue % 360.0, saturation / 100, 1).toColor();
    String describe(int h, int s) => 'Hue $h degrees, saturation $s percent';

    return Semantics(
      label: 'Color picker',
      value: describe(hue, saturation),
      increasedValue: describe((hue + 10) % 360, saturation),
      decreasedValue: describe((hue + 350) % 360, saturation),
      onIncrease: () => widget.onChanged((hue + 10) % 360, saturation),
      onDecrease: () => widget.onChanged((hue + 350) % 360, saturation),
      child: LayoutBuilder(
        builder: (context, c) {
          final size = c.biggest;
          final at = Offset(size.width * (hue % 360) / 359, size.height * (1 - saturation / 100));
          return GestureDetector(
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: Motion.medium,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_radius),
                      boxShadow: [BoxShadow(color: current.withValues(alpha: 0.28), blurRadius: 40)],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_radius),
                      child: const CustomPaint(painter: _FieldPainter()),
                    ),
                  ),
                ),
                TweenAnimationBuilder<Offset>(
                  tween: Tween(end: at),
                  duration: _dragging ? Duration.zero : const Duration(milliseconds: 420),
                  curve: Motion.emphasized,
                  builder: (context, p, child) => Positioned(
                    // Keep the whole thumb inside the pad near its edges.
                    left: p.dx.clamp(_thumb / 2, size.width - _thumb / 2) - _thumb / 2,
                    top: p.dy.clamp(_thumb / 2, size.height - _thumb / 2) - _thumb / 2,
                    child: child!,
                  ),
                  child: AnimatedScale(
                    scale: _dragging ? 1.3 : 1,
                    duration: Motion.medium,
                    curve: Motion.spring,
                    child: Container(
                      width: _thumb,
                      height: _thumb,
                      decoration: BoxDecoration(
                        color: current,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 14, offset: Offset(0, 3))],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FieldPainter extends CustomPainter {
  const _FieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          colors: [for (var h = 0; h <= 360; h += 30) HSVColor.fromAHSV(1, h % 360.0, 1, 1).toColor()],
        ).createShader(rect),
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00FFFFFF), Colors.white],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_FieldPainter old) => false;
}
