import 'package:flutter/material.dart';

import '../../../core/models/color_preset.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/pressable.dart';

/// A round colour chip with a ring when selected.
class PresetSwatch extends StatelessWidget {
  const PresetSwatch({super.key, required this.preset, required this.selected, required this.onTap, this.size = 36});

  final ColorPreset preset;
  final bool selected;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = HSVColor.fromAHSV(1, preset.hue.toDouble(), preset.saturation / 100, 1).toColor();
    return Semantics(
      button: true,
      selected: selected,
      label: preset.name,
      child: Pressable(
        onTap: onTap,
        scale: 0.85,
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.spring,
          width: size,
          height: size,
          padding: EdgeInsets.all(selected ? size * 0.11 : 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: selected ? Colors.white : Colors.transparent, width: 2),
            boxShadow: [BoxShadow(color: color.withValues(alpha: selected ? 0.8 : 0), blurRadius: 14)],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
