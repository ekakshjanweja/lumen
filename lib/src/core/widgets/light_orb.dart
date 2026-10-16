import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/light_state.dart';
import '../theme/effect_preview.dart';
import '../theme/light_colors.dart';
import '../theme/theme.dart';
import 'loop_clock.dart';
import 'pressable.dart';

/// The on-screen light. It glows in the light's colour, breathes gently,
/// plays a preview of the selected effect, and toggles power when tapped.
class LightOrb extends StatefulWidget {
  const LightOrb({super.key, required this.light, required this.onToggle, this.size = 236});

  final LightState light;
  final VoidCallback onToggle;
  final double size;

  @override
  State<LightOrb> createState() => _LightOrbState();
}

class _LightOrbState extends State<LightOrb> with TickerProviderStateMixin {
  late final _clock = LoopClock(this);
  late final _ripple = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _clock.running = !Motion.reduced(context);
  }

  @override
  void dispose() {
    _clock.dispose();
    _ripple.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.mediumImpact();
    if (!Motion.reduced(context)) _ripple.forward(from: 0);
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.light;
    final lit = s.on ? 0.35 + 0.65 * s.brightness / 100 : 0.0;
    final effect = s.mode == LightMode.effect ? s.effect : null;
    final reduced = Motion.reduced(context);

    return Semantics(
      button: true,
      toggled: s.on,
      label: 'Light power',
      child: Pressable(
        onTap: _toggle,
        haptic: false,
        scale: 0.94,
        child: SizedBox.square(
          dimension: widget.size,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: lit),
            duration: Motion.slow,
            curve: Motion.emphasized,
            builder: (context, lit, child) => TweenAnimationBuilder<Color?>(
              tween: ColorTween(end: s.previewColor),
              duration: Motion.medium,
              builder: (context, color, child) => CustomPaint(
                painter: _OrbPainter(
                  clock: _clock,
                  ripple: _ripple,
                  color: color!,
                  lit: lit,
                  effect: effect,
                  still: reduced,
                ),
                child: child,
              ),
              child: child,
            ),
            child: Center(
              child: _PowerIcon(on: s.on, color: s.previewColor, effect: effect != null),
            ),
          ),
        ),
      ),
    );
  }
}

class _PowerIcon extends StatelessWidget {
  const _PowerIcon({required this.on, required this.color, required this.effect});

  final bool on;
  final Color color;
  final bool effect;

  @override
  Widget build(BuildContext context) {
    final dark = on && !effect && color.computeLuminance() > 0.45;
    return AnimatedSwitcher(
      duration: Motion.medium,
      child: Icon(
        Icons.power_settings_new_rounded,
        key: ValueKey((on, dark)),
        size: 30,
        color: dark ? Colors.black.withValues(alpha: 0.55) : Colors.white.withValues(alpha: on ? 0.9 : 0.45),
        shadows: dark || !on ? null : const [Shadow(color: Color(0x66000000), blurRadius: 12)],
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({
    required this.clock,
    required this.ripple,
    required this.color,
    required this.lit,
    required this.effect,
    required this.still,
  }) : super(repaint: Listenable.merge([clock, ripple]));

  final LoopClock clock;
  final Animation<double> ripple;
  final Color color;
  final double lit;
  final int? effect;
  final bool still;

  static const _offColor = Color(0xFF1B1B22);

  @override
  void paint(Canvas canvas, Size size) {
    final t = still ? 0.4 : clock.value;
    final f = effect != null ? effectFrame(effect!, t) : steadyFrame(color, t);
    final c = size.center(Offset.zero);
    final breathe = effect == null && !still ? 1 + 0.014 * math.sin(t * 1.6) : 1.0;
    final r = size.shortestSide / 2 * 0.84 * breathe;
    final level = lit * f.level;
    final body = Rect.fromCircle(center: c, radius: r);

    // Glow spilling onto the page.
    if (level > 0.01) {
      final glow = Rect.fromCircle(center: c, radius: r * 2.2);
      canvas.drawCircle(
        c,
        r * 2.2,
        Paint()
          ..shader = RadialGradient(
            colors: [
              f.a.withValues(alpha: 0.55 * level),
              f.a.withValues(alpha: 0.16 * level),
              f.a.withValues(alpha: 0),
            ],
            stops: const [0.3, 0.55, 1],
          ).createShader(glow),
      );
    }

    // Body: lit from the top left, deeper towards the rim.
    final mix = lit == 0 ? 0.0 : 0.22 + 0.78 * level;
    final a = Color.lerp(_offColor, f.a, mix)!;
    final b = Color.lerp(_offColor, f.b, mix)!;
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          radius: 1.15,
          colors: [Color.lerp(a, Colors.white, 0.42 * level)!, a, Color.lerp(b, Colors.black, 0.3)!],
          stops: const [0, 0.5, 1],
        ).createShader(body),
    );

    // Slowly turning sheen in the partner colour gives the light some life.
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(f.spin * 2 * math.pi);
    canvas.translate(-c.dx, -c.dy);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = SweepGradient(
          colors: [
            b.withValues(alpha: 0),
            b.withValues(alpha: 0.6 * level),
            b.withValues(alpha: 0),
            a.withValues(alpha: 0),
            b.withValues(alpha: 0.35 * level),
            b.withValues(alpha: 0),
          ],
          stops: const [0, 0.17, 0.36, 0.55, 0.76, 1],
        ).createShader(body),
    );
    canvas.restore();

    // Glassy highlight and rim.
    final highlight = Rect.fromCenter(center: c.translate(0, -r * 0.48), width: r * 1.15, height: r * 0.72);
    canvas.drawOval(
      highlight,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.10 + 0.14 * level),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(highlight),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Colors.white.withValues(alpha: 0.06 + 0.1 * (1 - level)),
    );

    // Ripple after a tap.
    final v = ripple.value;
    if (v > 0 && v < 1) {
      final ease = Curves.easeOutCubic.transform(v);
      canvas.drawCircle(
        c,
        r * (1 + 0.5 * ease),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5 * (1 - v) + 0.5
          ..color = (lit > 0 ? f.a : Colors.white).withValues(alpha: 0.55 * (1 - v)),
      );
    }
  }

  @override
  bool shouldRepaint(_OrbPainter old) =>
      old.color != color || old.lit != lit || old.effect != effect || old.still != still;
}
