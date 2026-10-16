import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A large, full-width slider. With [gradient] it draws a colour track and a
/// ring thumb (temperature, hue); otherwise it fills from the left (brightness).
class TrackSlider extends StatelessWidget {
  const TrackSlider({
    super.key,
    required this.label,
    required this.valueText,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.icon,
    this.gradient,
    this.fillColor,
    this.thumbColor,
    this.step = 1,
  });

  final String label;
  final String valueText;
  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;
  final IconData? icon;
  final Gradient? gradient;
  final Color? fillColor;
  final Color? thumbColor;

  static const height = 64.0;

  double get _t => ((value - min) / (max - min)).clamp(0.0, 1.0);

  void _set(double dx, double width) {
    final t = (dx / width).clamp(0.0, 1.0);
    final v = ((min + t * (max - min)) / step).round() * step;
    if (v != value) onChanged(v.clamp(min, max));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final hasGradient = gradient != null;
    final labelColor = scheme.onSurface;

    return Semantics(
      slider: true,
      label: label,
      value: valueText,
      onIncrease: () => onChanged((value + step * 5).clamp(min, max)),
      onDecrease: () => onChanged((value - step * 5).clamp(min, max)),
      child: _withHeader(
        context,
        LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (d) {
                HapticFeedback.selectionClick();
                _set(d.localPosition.dx, w);
              },
              onHorizontalDragUpdate: (d) => _set(d.localPosition.dx, w),
              onTapUp: (d) {
                HapticFeedback.selectionClick();
                _set(d.localPosition.dx, w);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: hasGradient ? 48 : height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: gradient,
                            color: hasGradient ? null : scheme.surfaceContainerHighest,
                          ),
                        ),
                      ),
                      if (!hasGradient)
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: w * _t,
                          child: ColoredBox(color: fillColor ?? scheme.primary),
                        ),
                      if (hasGradient)
                        Positioned(
                          left: (w - 28) * _t + 4,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            width: 20,
                            decoration: BoxDecoration(
                              color: thumbColor ?? Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 6)],
                            ),
                          ),
                        ),
                      if (!hasGradient)
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                if (icon != null) ...[
                                  Icon(icon, size: 20, color: _onFill(labelColor, 0.1)),
                                  const SizedBox(width: 10),
                                ],
                                Text(label, style: text.titleSmall?.copyWith(color: _onFill(labelColor, 0.25))),
                                const Spacer(),
                                Text(
                                  valueText,
                                  style: text.titleSmall?.copyWith(
                                    color: _onFill(labelColor, 0.85),
                                    fontFeatures: const [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Colour tracks keep their label and value above the track, so the thumb
  /// never covers the numbers at either end.
  Widget _withHeader(BuildContext context, Widget track) {
    if (gradient == null) return track;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text(label, style: text.titleSmall),
              const Spacer(),
              Text(
                valueText,
                style: text.titleSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        track,
      ],
    );
  }

  /// On the fill style, text sitting on top of the bright fill flips to dark.
  Color _onFill(Color base, double at) {
    if (gradient != null || _t < at) return base;
    final fill = fillColor ?? Colors.white;
    return fill.computeLuminance() > 0.5 ? Colors.black.withValues(alpha: 0.8) : Colors.white;
  }
}
