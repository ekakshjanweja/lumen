import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/color_preset.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/theme/theme.dart';
import '../view_models/control_view_model.dart';
import '../view_models/presets_view_model.dart';
import 'preset_swatch.dart';

/// All colour presets: pick one, save the current colour, or delete saved ones.
class PresetsSheet extends ConsumerStatefulWidget {
  const PresetsSheet({super.key, this.startSaving = false});

  /// Opens with the name field ready, for the quick save button.
  final bool startSaving;

  static Future<void> show(BuildContext context, {bool startSaving = false}) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => PresetsSheet(startSaving: startSaving),
  );

  @override
  ConsumerState<PresetsSheet> createState() => _PresetsSheetState();
}

class _PresetsSheetState extends ConsumerState<PresetsSheet> {
  late bool _saving = widget.startSaving;
  bool _editing = false;
  final _name = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_saving) _suggestName();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  (int, int) get _current {
    final light = ref.read(controlViewModelProvider).light;
    return (light.hue, light.saturation);
  }

  void _suggestName() {
    final (hue, saturation) = _current;
    _name.text = colorName(hue, saturation);
    _name.selection = TextSelection(baseOffset: 0, extentOffset: _name.text.length);
  }

  Future<void> _save() async {
    final (hue, saturation) = _current;
    HapticFeedback.mediumImpact();
    await ref.read(presetsViewModelProvider.notifier).save(_name.text, hue: hue, saturation: saturation);
    if (mounted) setState(() => _saving = false);
  }

  void _pick(ColorPreset p) {
    ref.read(controlViewModelProvider.notifier).setColor(p.hue, p.saturation);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(presetsViewModelProvider.select((s) => s.saved));
    final (hue, saturation) = ref.watch(controlViewModelProvider.select((s) => (s.light.hue, s.light.saturation)));
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final editing = _editing && saved.isNotEmpty;
    bool selected(ColorPreset p) => p.hue == hue && p.saturation == saturation;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Color presets', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  ),
                  if (saved.isNotEmpty)
                    TextButton(
                      style: TextButton.styleFrom(minimumSize: const Size(64, 40)),
                      onPressed: () => setState(() => _editing = !editing),
                      child: Text(editing ? 'Done' : 'Edit'),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SaveCard(
                color: HSVColor.fromAHSV(1, hue.toDouble(), saturation / 100, 1).toColor(),
                caption: colorName(hue, saturation),
                saving: _saving,
                name: _name,
                onStart: () => setState(() {
                  _saving = true;
                  _editing = false;
                  _suggestName();
                }),
                onCancel: () => setState(() => _saving = false),
                onSave: _save,
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                children: [
                  _SectionTitle('Saved'),
                  if (saved.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Colors you save show up here and in the quick row.',
                        style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    )
                  else
                    _PresetGrid(
                      presets: saved.reversed.toList(),
                      selected: selected,
                      editing: editing,
                      onTap: _pick,
                      onDelete: (p) {
                        HapticFeedback.mediumImpact();
                        ref.read(presetsViewModelProvider.notifier).delete(p.id);
                      },
                    ),
                  const SizedBox(height: 18),
                  _SectionTitle('Built-in'),
                  _PresetGrid(presets: builtInPresets, selected: selected, editing: false, onTap: _pick),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The current colour, with a button that turns into a name field to save it.
class _SaveCard extends StatelessWidget {
  const _SaveCard({
    required this.color,
    required this.caption,
    required this.saving,
    required this.name,
    required this.onStart,
    required this.onCancel,
    required this.onSave,
  });

  final Color color;
  final String caption;
  final bool saving;
  final TextEditingController name;
  final VoidCallback onStart;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final dot = AnimatedContainer(
      duration: Motion.medium,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 16)],
      ),
    );

    return AnimatedContainer(
      duration: Motion.medium,
      curve: Motion.emphasized,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: saving ? color.withValues(alpha: 0.10) : AppTheme.glass,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: saving ? color.withValues(alpha: 0.5) : AppTheme.glassBorder),
      ),
      child: AnimatedSize(
        duration: Motion.medium,
        curve: Motion.emphasized,
        alignment: Alignment.topCenter,
        child: saving
            ? Row(
                children: [
                  dot,
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: name,
                      autofocus: true,
                      maxLength: 24,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => onSave(),
                      style: text.titleMedium,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        counterText: '',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  IconButton(tooltip: 'Cancel', onPressed: onCancel, icon: const Icon(Icons.close_rounded)),
                  const SizedBox(width: 4),
                  FilledButton(
                    style: FilledButton.styleFrom(minimumSize: const Size(80, 44)),
                    onPressed: onSave,
                    child: const Text('Save'),
                  ),
                ],
              )
            : Row(
                children: [
                  dot,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current color', style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant)),
                        Text(caption, style: text.titleMedium),
                      ],
                    ),
                  ),
                  FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
                    onPressed: onStart,
                    icon: const Icon(Icons.bookmark_add_rounded, size: 20),
                    label: const Text('Save'),
                  ),
                ],
              ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 0, 12),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, letterSpacing: 1.2),
      ),
    );
  }
}

class _PresetGrid extends StatelessWidget {
  const _PresetGrid({
    required this.presets,
    required this.selected,
    required this.editing,
    required this.onTap,
    this.onDelete,
  });

  final List<ColorPreset> presets;
  final bool Function(ColorPreset) selected;
  final bool editing;
  final ValueChanged<ColorPreset> onTap;
  final ValueChanged<ColorPreset>? onDelete;

  @override
  Widget build(BuildContext context) {
    final reduced = Motion.reduced(context);
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      mainAxisSpacing: 14,
      crossAxisSpacing: 8,
      childAspectRatio: 0.82,
      children: [
        for (final (i, p) in presets.indexed)
          KeyedSubtree(
            key: ValueKey(p.id),
            child: _PresetTile(
              preset: p,
              selected: selected(p),
              editing: editing,
              onTap: () => editing ? onDelete?.call(p) : onTap(p),
            ),
          ).animateIf(!reduced, i),
      ],
    );
  }
}

extension on Widget {
  Widget animateIf(bool enabled, int i) => !enabled
      ? this
      : animate(delay: (18 * i).ms)
            .fadeIn(duration: Motion.medium)
            .scaleXY(begin: 0.85, end: 1, duration: Motion.slow, curve: Motion.spring);
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({required this.preset, required this.selected, required this.editing, required this.onTap});

  final ColorPreset preset;
  final bool selected;
  final bool editing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    Widget swatch = Stack(
      clipBehavior: Clip.none,
      children: [
        PresetSwatch(preset: preset, size: 56, selected: selected && !editing, onTap: onTap),
        Positioned(
          top: -4,
          right: -4,
          child: IgnorePointer(
            child: AnimatedScale(
              scale: editing ? 1 : 0,
              duration: Motion.medium,
              curve: Motion.spring,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: scheme.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: scheme.surfaceContainerHigh, width: 2),
                ),
                child: Icon(Icons.close_rounded, size: 14, color: scheme.onError),
              ),
            ),
          ),
        ),
      ],
    );
    if (editing && !Motion.reduced(context)) {
      swatch = swatch
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .rotate(begin: -0.008, end: 0.008, duration: 180.ms);
    }

    return Semantics(
      label: editing ? 'Delete ${preset.name}' : null,
      child: Column(
        children: [
          swatch,
          const SizedBox(height: 8),
          Text(
            preset.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.labelMedium?.copyWith(color: selected ? scheme.onSurface : scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
