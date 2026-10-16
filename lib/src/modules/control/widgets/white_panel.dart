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
        const SizedBox(height: 18),
        Row(
          children: [
            for (final (k, name) in presets) ...[
              Expanded(
                child: _Preset(
                  selected: kelvin == k,
                  color: kelvinToColor(k),
                  title: name,
                  subtitle: '${k}K',
                  onTap: () => vm.setKelvin(k),
                ),
              ),
              if (k != presets.last.$1) const SizedBox(width: 8),
            ],
          ],
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
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.emphasized,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selected ? color.withValues(alpha: 0.14) : AppTheme.glass,
            border: Border.all(color: selected ? color.withValues(alpha: 0.85) : AppTheme.glassBorder, width: 1.5),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Motion.medium,
                curve: Motion.spring,
                width: selected ? 22 : 16,
                height: selected ? 22 : 16,
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
              ),
              const SizedBox(height: 10),
              Text(title, style: text.labelMedium?.copyWith(color: selected ? scheme.onSurface : null)),
              Text(subtitle, style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
