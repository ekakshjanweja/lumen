import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

/// A full-width colour track with a pill thumb, e.g. colour temperature.
/// Taps glide to the new value; drags follow the finger exactly.
class TrackSlider extends StatefulWidget {
  const TrackSlider({
    super.key,
    required this.label,
    required this.format,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.gradient,
    this.thumbColor,
    this.step = 1,
  });

  final String label;

  /// How a value reads on screen and to screen readers, e.g. "72%".
  final String Function(double value) format;
  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;
  final Gradient gradient;
  final Color? thumbColor;

  @override
  State<TrackSlider> createState() => _TrackSliderState();
}

class _TrackSliderState extends State<TrackSlider> {
  bool _dragging = false;

  double get _t => ((widget.value - widget.min) / (widget.max - widget.min)).clamp(0.0, 1.0);

  void _set(double dx, double width) {
    final w = widget;
    final t = (dx / width).clamp(0.0, 1.0);
    final v = ((w.min + t * (w.max - w.min)) / w.step).round() * w.step;
    if (v != w.value) w.onChanged(v.clamp(w.min, w.max));
  }

  void _dragState(bool dragging) {
    if (dragging != _dragging) setState(() => _dragging = dragging);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget;
    final track = LayoutBuilder(
      builder: (context, c) {
        final width = c.maxWidth;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (d) {
            HapticFeedback.selectionClick();
            _dragState(true);
            _set(d.localPosition.dx, width);
          },
          onHorizontalDragUpdate: (d) => _set(d.localPosition.dx, width),
          onHorizontalDragEnd: (_) => _dragState(false),
          onHorizontalDragCancel: () => _dragState(false),
          onTapUp: (d) {
            HapticFeedback.selectionClick();
            _set(d.localPosition.dx, width);
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: _t),
            duration: _dragging ? Duration.zero : Motion.medium,
            curve: Motion.emphasized,
            builder: (context, t, _) => AnimatedScale(
              scale: _dragging ? 1.015 : 1,
              duration: Motion.medium,
              curve: Motion.spring,
              child: _track(width, t),
            ),
          ),
        );
      },
    );

    final up = (w.value + w.step * 5).clamp(w.min, w.max);
    final down = (w.value - w.step * 5).clamp(w.min, w.max);
    return Semantics(
      slider: true,
      label: w.label,
      value: w.format(w.value),
      increasedValue: w.format(up),
      decreasedValue: w.format(down),
      onIncrease: () => w.onChanged(up),
      onDecrease: () => w.onChanged(down),
      child: _withHeader(context, track),
    );
  }

  Widget _track(double width, double t) {
    const thumbWidth = 22.0;
    return SizedBox(
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: widget.gradient, borderRadius: BorderRadius.circular(25)),
            ),
          ),
          Positioned(
            left: 5 + (width - thumbWidth - 10) * t,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedContainer(
                duration: Motion.medium,
                curve: Motion.spring,
                width: thumbWidth,
                height: _dragging ? 60 : 40,
                decoration: BoxDecoration(
                  color: widget.thumbColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.white, width: 3.5),
                  boxShadow: const [BoxShadow(color: Color(0x73000000), blurRadius: 10, offset: Offset(0, 2))],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Colour tracks keep their label and value above the track, so the thumb
  /// never covers the numbers at either end.
  Widget _withHeader(BuildContext context, Widget track) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text(widget.label, style: text.titleSmall),
              const Spacer(),
              Text(
                widget.format(widget.value),
                style: text.titleSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        track,
      ],
    );
  }
}
