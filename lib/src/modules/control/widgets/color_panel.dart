import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/color_wheel.dart';
import '../../../core/widgets/pressable.dart';
import '../view_models/control_view_model.dart';

class ColorPanel extends ConsumerWidget {
  const ColorPanel({super.key});

  static const swatches = [0, 25, 50, 120, 180, 220, 270, 310];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (hue, saturation) = ref.watch(controlViewModelProvider.select((s) => (s.light.hue, s.light.saturation)));
    final vm = ref.read(controlViewModelProvider.notifier);
    return Column(
      children: [
        const SizedBox(height: 8),
        ColorWheel(hue: hue, saturation: saturation, onChanged: vm.setColor),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.glass,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final h in swatches)
                _Swatch(
                  color: HSVColor.fromAHSV(1, h.toDouble(), 1, 1).toColor(),
                  selected: hue == h && saturation == 100,
                  onTap: () => vm.setColor(h, 100),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color, required this.selected, required this.onTap});

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Color preset',
      child: Pressable(
        onTap: onTap,
        scale: 0.85,
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.spring,
          width: 34,
          height: 34,
          padding: EdgeInsets.all(selected ? 4 : 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: selected ? Colors.white : Colors.transparent, width: 2),
            boxShadow: [BoxShadow(color: color.withValues(alpha: selected ? 0.8 : 0.0), blurRadius: 14)],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
