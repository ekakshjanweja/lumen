import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/light_state.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/track_slider.dart';
import '../view_models/control_view_model.dart';

class WhitePanel extends ConsumerWidget {
  const WhitePanel({super.key});

  static const presets = [(3200, 'Tungsten'), (4300, 'Neutral'), (5600, 'Daylight'), (6500, 'Cloudy')];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kelvin = ref.watch(controlViewModelProvider.select((s) => s.light.kelvin));
    final vm = ref.read(controlViewModelProvider.notifier);
    Widget tile(int i) {
      final (k, name) = presets[i];
      return _Preset(
        selected: kelvin == k,
        color: kelvinToColor(k),
        title: name,
        subtitle: '${k}K',
        onTap: () => vm.setKelvin(k),
      );
    }

    return Column(
      children: [
        TrackSlider(
          label: 'Temperature',
          format: (v) => '${v.round()}K',
          value: kelvin.toDouble(),
          min: minKelvin.toDouble(),
          max: maxKelvin.toDouble(),
          step: 100,
          gradient: LinearGradient(colors: [for (var k = minKelvin; k <= maxKelvin; k += 1850) kelvinToColor(k)]),
          thumbColor: kelvinToColor(kelvin),
          onChanged: (v) => vm.setKelvin(v.round()),
        ),
        const SizedBox(height: 20),
        // Presets fill the rest: a 2x2 grid of tiles, or one row on short screens.
        Expanded(
          child: LayoutBuilder(
            builder: (context, c) {
              const gap = 10.0;
              final twoRows = c.maxHeight >= 2 * 88 + gap;
              final h = twoRows ? ((c.maxHeight - gap) / 2).clamp(88.0, 112.0) : c.maxHeight.clamp(0.0, 112.0);
              Widget row(List<int> items) => SizedBox(
                height: h,
                child: Row(
                  children: [
                    for (final i in items) ...[
                      if (i != items.first) const SizedBox(width: gap),
                      Expanded(child: tile(i)),
                    ],
                  ],
                ),
              );
              return Column(
                children: twoRows
                    ? [
                        row([0, 1]),
                        const SizedBox(height: gap),
                        row([2, 3]),
                      ]
                    : [
                        row([0, 1, 2, 3]),
                      ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Preset extends StatelessWidget {
  const _Preset({
    required this.selected,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Semantics(
      button: true,
      selected: selected,
      child: Pressable(
        onTap: onTap,
        // Wide tiles read like Control Center (dot top left, labels bottom left);
        // narrow ones on short screens centre everything so names still fit.
        child: LayoutBuilder(
          builder: (context, c) {
            final compact = c.maxWidth < 110;
            final dot = AnimatedContainer(
              duration: Motion.medium,
              curve: Motion.spring,
              width: selected ? 22 : 18,
              height: selected ? 22 : 18,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: selected ? 0.9 : 0.5),
                    blurRadius: selected ? 16 : 8,
                  ),
                ],
              ),
            );
            final name = Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (compact ? text.labelMedium : text.titleSmall)?.copyWith(
                color: selected ? scheme.onSurface : null,
              ),
            );
            final kelvin = Text(
              subtitle,
              style: (compact ? text.labelSmall : text.labelMedium)?.copyWith(color: scheme.onSurfaceVariant),
            );
            return AnimatedContainer(
              duration: Motion.medium,
              curve: Motion.emphasized,
              padding: compact ? const EdgeInsets.symmetric(horizontal: 4, vertical: 12) : const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: selected ? color.withValues(alpha: 0.16) : AppTheme.glass,
                border: Border.all(color: selected ? color.withValues(alpha: 0.85) : AppTheme.glassBorder, width: 1.5),
              ),
              child: compact
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dot,
                        const SizedBox(height: 10),
                        FittedBox(fit: BoxFit.scaleDown, child: name),
                        kelvin,
                      ],
                    )
                  : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [dot, const Spacer(), name, kelvin]),
            );
          },
        ),
      ),
    );
  }
}
