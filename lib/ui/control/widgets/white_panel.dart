import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/light_state.dart';
import '../../core/light_colors.dart';
import '../../core/ui/track_slider.dart';
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
          valueText: '${kelvin}K',
          value: kelvin.toDouble(),
          min: minKelvin.toDouble(),
          max: maxKelvin.toDouble(),
          step: 100,
          gradient: LinearGradient(colors: [for (var k = minKelvin; k <= maxKelvin; k += 1850) kelvinToColor(k)]),
          thumbColor: kelvinToColor(kelvin),
          onChanged: (v) => vm.setKelvin(v.round()),
        ),
        const SizedBox(height: 16),
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
    return Material(
      color: scheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: selected ? color : Colors.transparent, width: 1.5),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 8)],
                ),
              ),
              const SizedBox(height: 10),
              Text(title, style: text.labelMedium),
              Text(subtitle, style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
