import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'loop_clock.dart';

/// Soft pools of the light's colour drifting behind the page.
class AmbientBackground extends StatefulWidget {
  const AmbientBackground({super.key, required this.color, required this.level, required this.child});

  final Color color;

  /// 0 (off) to 1 (full brightness).
  final double level;
  final Widget child;

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground> with SingleTickerProviderStateMixin {
  late final _clock = LoopClock(this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _clock.running = !Motion.reduced(context);
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: widget.level),
      duration: Motion.slow,
      curve: Motion.emphasized,
      builder: (context, level, child) => TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: widget.color),
        duration: const Duration(milliseconds: 700),
        builder: (context, color, child) => CustomPaint(painter: _AmbientPainter(_clock, color!, level), child: child),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _AmbientPainter extends CustomPainter {
  _AmbientPainter(this.clock, this.color, this.level) : super(repaint: clock);

  final LoopClock clock;
  final Color color;
  final double level;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppTheme.background);
    if (level <= 0.01) return;

    final t = clock.value;
    final hsv = HSVColor.fromColor(color);
    Color shifted(double by) => hsv.saturation < 0.12 ? color : hsv.withHue((hsv.hue + by) % 360).toColor();

    // Each blob drifts on its own slow loop: (colour, strength, radius, centre path).
    final blobs = [
      (color, 0.30, 0.95, Offset(0.5 + 0.12 * math.sin(t * 0.21), 0.18 + 0.05 * math.cos(t * 0.17))),
      (shifted(32), 0.16, 0.75, Offset(0.15 + 0.1 * math.cos(t * 0.13), 0.42 + 0.08 * math.sin(t * 0.19))),
      (shifted(-32), 0.13, 0.8, Offset(0.88 + 0.08 * math.sin(t * 0.15 + 2), 0.55 + 0.1 * math.cos(t * 0.11))),
    ];
    for (final (c, strength, radius, at) in blobs) {
      final center = Offset(at.dx * size.width, at.dy * size.height);
      final r = size.width * radius;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              c.withValues(alpha: strength * level),
              c.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: r)),
      );
    }
  }

  @override
  bool shouldRepaint(_AmbientPainter old) => old.color != color || old.level != level;
}
