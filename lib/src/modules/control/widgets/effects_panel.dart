import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Effect;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/effect.dart';
import '../../../core/models/light_state.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/pressable.dart';
import '../view_models/control_view_model.dart';

class EffectsPanel extends ConsumerWidget {
  const EffectsPanel({super.key});

  static const icons = {
    1: Icons.flash_on_rounded,
    2: Icons.bolt_rounded,
    3: Icons.tv_rounded,
    4: Icons.local_fire_department_outlined,
    5: Icons.local_fire_department_rounded,
    6: Icons.whatshot_rounded,
    7: Icons.local_police_rounded,
    8: Icons.emergency_rounded,
    9: Icons.fire_truck_rounded,
    10: Icons.flare_rounded,
    11: Icons.flare_rounded,
    12: Icons.flare_rounded,
    13: Icons.double_arrow_rounded,
    14: Icons.double_arrow_rounded,
    15: Icons.double_arrow_rounded,
    16: Icons.celebration_rounded,
    17: Icons.celebration_rounded,
    18: Icons.celebration_rounded,
    19: Icons.nightlife_rounded,
    20: Icons.nightlife_rounded,
    21: Icons.favorite_rounded,
    22: Icons.music_note_rounded,
    23: Icons.waves_rounded,
    24: Icons.waves_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      controlViewModelProvider.select((s) => s.light.mode == LightMode.effect ? s.light.effect : null),
    );
    final vm = ref.read(controlViewModelProvider.notifier);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final reduced = Motion.reduced(context);
    var order = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final group in effectGroups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 12),
            child: Text(
              group.toUpperCase(),
              style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant, letterSpacing: 1.2),
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
            children: [
              for (final e in effects.where((e) => e.group == group))
                _EffectTile(
                  effect: e,
                  icon: icons[e.id]!,
                  selected: selected == e.id,
                  onTap: () => vm.selectEffect(e.id),
                ).maybeAnimate(!reduced, order++),
            ],
          ),
          const SizedBox(height: 22),
        ],
      ],
    );
  }
}

extension on Widget {
  /// Tiles pop in one after another the first time the panel opens.
  Widget maybeAnimate(bool enabled, int order) => !enabled
      ? this
      : animate(delay: (24 * order).ms)
            .fadeIn(duration: Motion.medium, curve: Motion.emphasized)
            .scaleXY(begin: 0.88, end: 1, duration: Motion.slow, curve: Motion.spring);
}

class _EffectTile extends StatelessWidget {
  const _EffectTile({required this.effect, required this.icon, required this.selected, required this.onTap});

  final Effect effect;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tint = effectColor(effect.id);
    Widget glyph = Icon(icon, size: 26, color: selected ? tint : scheme.onSurfaceVariant);
    if (selected && !Motion.reduced(context)) {
      glyph = glyph
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1, end: 1.18, duration: 800.ms, curve: Curves.easeInOutSine);
    }

    return Semantics(
      selected: selected,
      button: true,
      child: Pressable(
        onTap: onTap,
        scale: 0.93,
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.emphasized,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppTheme.glass,
            gradient: selected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [tint.withValues(alpha: 0.34), tint.withValues(alpha: 0.08)],
                  )
                : null,
            border: Border.all(color: selected ? tint.withValues(alpha: 0.9) : AppTheme.glassBorder, width: 1.5),
            boxShadow: [BoxShadow(color: tint.withValues(alpha: selected ? 0.28 : 0), blurRadius: 22)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              glyph,
              const SizedBox(height: 10),
              AnimatedDefaultTextStyle(
                duration: Motion.fast,
                style: Theme.of(context).textTheme.labelMedium!
                    .copyWith(color: selected ? scheme.onSurface : scheme.onSurfaceVariant),
                child: Text(effect.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
