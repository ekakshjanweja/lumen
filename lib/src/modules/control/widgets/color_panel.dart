import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/color_wheel.dart';
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
        const SizedBox(height: 28),
        Row(
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
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: selected ? Colors.white : Colors.transparent, width: 3),
            boxShadow: [BoxShadow(color: color.withValues(alpha: selected ? 0.7 : 0.0), blurRadius: 12)],
          ),
        ),
      ),
    );
  }
}
