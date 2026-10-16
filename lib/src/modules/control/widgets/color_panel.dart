import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/color_preset.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/color_field.dart';
import '../../../core/widgets/pressable.dart';
import '../view_models/control_view_model.dart';
import '../view_models/presets_view_model.dart';
import 'preset_swatch.dart';
import 'presets_sheet.dart';

/// Colour pad filling the space it's given, with a row of quick presets.
class ColorPanel extends ConsumerWidget {
  const ColorPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (hue, saturation) = ref.watch(controlViewModelProvider.select((s) => (s.light.hue, s.light.saturation)));
    final presets = ref.watch(presetsViewModelProvider.select((s) => s.all));
    final vm = ref.read(controlViewModelProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: ColorField(hue: hue, saturation: saturation, onChanged: vm.setColor),
        ),
        const SizedBox(height: 14),
        _QuickPresets(
          presets: presets,
          isSelected: (p) => p.hue == hue && p.saturation == saturation,
          onPick: (p) => vm.setColor(p.hue, p.saturation),
          onOpen: ({bool save = false}) => PresetsSheet.show(context, startSaving: save),
        ),
      ],
    );
  }
}

/// "Presets" button, as many swatches as fit, and a quick save button.
class _QuickPresets extends StatelessWidget {
  const _QuickPresets({required this.presets, required this.isSelected, required this.onPick, required this.onOpen});

  final List<ColorPreset> presets;
  final bool Function(ColorPreset) isSelected;
  final ValueChanged<ColorPreset> onPick;
  final void Function({bool save}) onOpen;

  static const _swatch = 36.0;
  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppTheme.glass,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'All presets',
            child: Pressable(
              onTap: onOpen,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Icon(Icons.grid_view_rounded, size: 18, color: scheme.onSurface),
                    const SizedBox(width: 8),
                    Text('Presets', style: text.labelLarge),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: LayoutBuilder(
              builder: (context, c) {
                final fit = ((c.maxWidth + _gap) / (_swatch + _gap)).floor().clamp(0, presets.length);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final p in presets.take(fit))
                      PresetSwatch(preset: p, size: _swatch, selected: isSelected(p), onTap: () => onPick(p)),
                  ],
                );
              },
            ),
          ),
          Semantics(
            button: true,
            label: 'Save this color',
            child: Pressable(
              onTap: () => onOpen(save: true),
              scale: 0.85,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(shape: BoxShape.circle, color: scheme.surfaceContainerHighest),
                child: Icon(Icons.add_rounded, color: scheme.onSurface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
