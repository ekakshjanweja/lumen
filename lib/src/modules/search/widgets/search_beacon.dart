import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/loop_clock.dart';

/// What the beacon in the middle of the search screen is doing.
enum BeaconMode {
  /// Gentle rings, waiting to start.
  idle,

  /// Mirrors the light: white on, off, on...
  blinking,

  /// Radar sweep with a progress ring.
  sweeping,

  /// Mirrors the light: red, blue, red...
  alternating,

  /// Still and dim.
  stopped,
}

/// Animated bulb with pulse rings, a radar sweep and a progress ring.
class SearchBeacon extends StatefulWidget {
  const SearchBeacon({super.key, required this.mode, required this.color, this.progress = 0, this.size = 260});

  final BeaconMode mode;
  final Color color;
  final double progress;
  final double size;

  @override
  State<SearchBeacon> createState() => _SearchBeaconState();
}

class _SearchBeaconState extends State<SearchBeacon> with SingleTickerProviderStateMixin {
  late final _clock = LoopClock(this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(SearchBeacon old) {
    super.didUpdateWidget(old);
    _sync();
  }

  void _sync() => _clock.running = widget.mode != BeaconMode.stopped && !Motion.reduced(context);

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: widget.progress),
        duration: Motion.medium,
        builder: (context, progress, _) => TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: widget.color),
          duration: Motion.slow,
          builder: (context, color, _) => CustomPaint(
            painter: _BeaconPainter(_clock, widget.mode, color!, progress, Motion.reduced(context)),
            child: Center(
              child: Icon(
                Icons.lightbulb_rounded,
                size: widget.size * 0.17,
                color: Colors.white.withValues(alpha: widget.mode == BeaconMode.stopped ? 0.4 : 0.92),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BeaconPainter extends CustomPainter {
  _BeaconPainter(this.clock, this.mode, this.color, this.progress, this.still) : super(repaint: clock);

  final LoopClock clock;
  final BeaconMode mode;
  final Color color;
  final double progress;
  final bool still;

  static const _blue = Color(0xFF5B6CFF);

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    final c = size.center(Offset.zero);
    final outer = size.shortestSide / 2;
    final core = outer * 0.36;

    // The bulb copies what the real light should be doing, at the same pace.
    var bulb = color;
    var glow = 1.0;
    if (!still) {
      switch (mode) {
        case BeaconMode.blinking:
          glow = _square(t, 0.6);
          bulb = Color.lerp(const Color(0xFF2A2A33), Colors.white, glow)!;
        case BeaconMode.alternating:
          bulb = Color.lerp(color, _blue, _square(t, 0.5))!;
        case BeaconMode.idle || BeaconMode.sweeping:
          glow = 0.75 + 0.25 * math.sin(t * 2.4);
        case BeaconMode.stopped:
          glow = 0.3;
      }
    } else if (mode == BeaconMode.stopped) {
      glow = 0.3;
    }

    // Pulse rings.
    if (mode != BeaconMode.stopped && !still) {
      for (final offset in const [0.0, 0.33, 0.66]) {
        final p = (t / 2.6 + offset) % 1.0;
        final r = core + (outer - core) * Curves.easeOut.transform(p);
        canvas.drawCircle(
          c,
          r,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = bulb.withValues(alpha: 0.4 * (1 - p)),
        );
      }
    }

    // Radar sweep.
    if (mode == BeaconMode.sweeping && !still) {
      final rect = Rect.fromCircle(center: c, radius: outer * 0.92);
      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.rotate(t * 2.2);
      canvas.translate(-c.dx, -c.dy);
      canvas.drawCircle(
        c,
        outer * 0.92,
        Paint()
          ..shader = SweepGradient(
            colors: [color.withValues(alpha: 0), color.withValues(alpha: 0), color.withValues(alpha: 0.32)],
            stops: const [0, 0.7, 1],
          ).createShader(rect),
      );
      canvas.restore();
    }

    // Progress ring.
    if (mode == BeaconMode.sweeping) {
      final ring = Rect.fromCircle(center: c, radius: core + 18);
      final track = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(ring, 0, 2 * math.pi, false, track..color = Colors.white.withValues(alpha: 0.08));
      canvas.drawArc(ring, -math.pi / 2, 2 * math.pi * progress, false, track..color = color);
    }

    // Bulb with its glow.
    final halo = Rect.fromCircle(center: c, radius: core * 2.2);
    canvas.drawCircle(
      c,
      core * 2.2,
      Paint()
        ..shader = RadialGradient(
          colors: [
            bulb.withValues(alpha: 0.45 * glow),
            bulb.withValues(alpha: 0),
          ],
        ).createShader(halo),
    );
    final body = Rect.fromCircle(center: c, radius: core);
    canvas.drawCircle(
      c,
      core,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          colors: [Color.lerp(bulb, Colors.white, 0.35)!, bulb, Color.lerp(bulb, Colors.black, 0.35)!],
          stops: const [0, 0.55, 1],
        ).createShader(body),
    );
  }

  /// 1 for the first [half] seconds, 0 for the next, with soft edges.
  double _square(double t, double half) {
    final phase = (t % (half * 2)) / half;
    final edge = 0.15;
    if (phase < edge) return phase / edge;
    if (phase < 1) return 1;
    if (phase < 1 + edge) return 1 - (phase - 1) / edge;
    return 0;
  }

  @override
  bool shouldRepaint(_BeaconPainter old) =>
      old.mode != mode || old.color != color || old.progress != progress || old.still != still;
}
