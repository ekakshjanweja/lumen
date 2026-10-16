import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

/// A tall pill that fills from the bottom, like the iOS flashlight control.
///
/// Drags move the level relative to where they started, so touching it never
/// makes the light jump. Pulling past either end stretches the pill and it
/// springs back on release. Taps glide to the tapped level.
class LevelSlider extends StatefulWidget {
  const LevelSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.color,
    required this.on,
    this.width = 84,
    this.height = 300,
    this.label = 'Brightness',
  });

  /// 0-100, where 0 is off.
  final int value;
  final ValueChanged<int> onChanged;

  /// Fill colour, usually a pale version of the light's colour.
  final Color color;
  final bool on;
  final double width;
  final double height;
  final String label;

  @override
  State<LevelSlider> createState() => _LevelSliderState();
}

class _LevelSliderState extends State<LevelSlider> with SingleTickerProviderStateMixin {
  static const _spring = SpringDescription(mass: 1, stiffness: 420, damping: 26);

  /// How far past an end the pill can stretch, in points.
  static const _maxStretch = 26.0;

  /// Signed overscroll in points: positive past the top, negative past the bottom.
  late final _stretch = AnimationController.unbounded(vsync: this);

  bool _held = false;
  bool _dragging = false;

  /// Unclamped level while dragging, so overscroll can be measured.
  double _raw = 0;

  @override
  void dispose() {
    _stretch.dispose();
    super.dispose();
  }

  void _emit(double level) {
    final next = level.clamp(0, 100).round();
    final prev = widget.value;
    if (next == prev) return;
    if (next == 0 || next == 100) {
      HapticFeedback.lightImpact();
    } else if (next ~/ 10 != prev ~/ 10) {
      HapticFeedback.selectionClick();
    }
    widget.onChanged(next);
  }

  void _dragStart(DragStartDetails _) {
    _stretch.stop();
    _raw = widget.value.toDouble();
    setState(() => _dragging = true);
  }

  void _dragUpdate(DragUpdateDetails d) {
    _raw -= d.delta.dy / widget.height * 100;
    _emit(_raw);
    final over = _raw > 100 ? _raw - 100 : (_raw < 0 ? _raw : 0.0);
    _stretch.value = _rubber(over / 100 * widget.height);
  }

  void _dragEnd(DragEndDetails d) {
    setState(() {
      _dragging = false;
      _held = false;
    });
    final v = -(d.primaryVelocity ?? 0) * 0.05;
    _stretch.animateWith(SpringSimulation(_spring, _stretch.value, 0, v));
  }

  /// Resistance that grows the further it's pulled, like iOS overscroll.
  double _rubber(double over) {
    final sign = over.sign;
    final x = over.abs();
    return sign * _maxStretch * (1 - 1 / (x / (_maxStretch * 1.6) + 1));
  }

  void _tapAt(Offset local) {
    HapticFeedback.selectionClick();
    _emit((1 - local.dy / widget.height) * 100);
  }

  void _hold(bool held) {
    if (held != _held) setState(() => _held = held);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget;
    final scheme = Theme.of(context).colorScheme;
    final level = w.on ? w.value / 100 : 0.0;
    final up = (w.value + 10).clamp(0, 100);
    final down = (w.value - 10).clamp(0, 100);
    String describe(int v) => v == 0 ? 'Off' : '$v%';

    return Semantics(
      slider: true,
      label: w.label,
      value: describe(w.on ? w.value : 0),
      increasedValue: describe(up),
      decreasedValue: describe(down),
      onIncrease: () => w.onChanged(up),
      onDecrease: () => w.onChanged(down),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _hold(true),
        onTapUp: (d) {
          _hold(false);
          _tapAt(d.localPosition);
        },
        onTapCancel: () => _hold(false),
        onVerticalDragDown: (_) => _hold(true),
        onVerticalDragStart: _dragStart,
        onVerticalDragUpdate: _dragUpdate,
        onVerticalDragEnd: _dragEnd,
        onVerticalDragCancel: () => _dragEnd(DragEndDetails()),
        child: AnimatedScale(
          scale: _held ? 1.04 : 1,
          duration: Motion.medium,
          curve: Motion.spring,
          child: AnimatedBuilder(
            animation: _stretch,
            builder: (context, child) {
              final s = _stretch.value;
              // Grow in the pulled direction, and thin out a little as it does.
              return Transform(
                alignment: s >= 0 ? Alignment.bottomCenter : Alignment.topCenter,
                transform: Matrix4.diagonal3Values(1 - s.abs() / w.height * 0.6, 1 + s.abs() / w.height, 1),
                child: child,
              );
            },
            child: SizedBox(
              width: w.width,
              height: w.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(w.width * 0.36),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const ColoredBox(color: Color(0x2EFFFFFF)),
                    TweenAnimationBuilder<double>(
                      tween: Tween(end: level),
                      duration: _dragging ? Duration.zero : Motion.medium,
                      curve: Motion.emphasized,
                      builder: (context, t, _) => Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: t,
                          widthFactor: 1,
                          child: AnimatedContainer(duration: Motion.medium, color: w.on ? w.color : scheme.outline),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 0.78),
                      child: _Icon(on: w.on, covered: level > 0.16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({required this.on, required this.covered});

  final bool on;

  /// Whether the fill has reached the icon, which then turns dark.
  final bool covered;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Motion.fast,
      transitionBuilder: (child, a) => ScaleTransition(
        scale: a,
        child: FadeTransition(opacity: a, child: child),
      ),
      child: Icon(
        on ? Icons.flashlight_on_rounded : Icons.flashlight_off_rounded,
        key: ValueKey((on, covered)),
        size: 28,
        color: covered ? Colors.black.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.9),
      ),
    );
  }
}
