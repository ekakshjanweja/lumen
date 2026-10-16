import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/effect.dart';
import '../../../core/models/light_state.dart';
import '../../../core/theme/light_colors.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final group in effectGroups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 0, 10),
            child: Text(group, style: text.titleSmall?.copyWith(color: scheme.onSurfaceVariant)),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.2,
            children: [
              for (final e in effects.where((e) => e.group == group))
                _EffectTile(
                  effect: e,
                  icon: icons[e.id]!,
                  selected: selected == e.id,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    vm.selectEffect(e.id);
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
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
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: scheme.surfaceContainer,
          gradient: selected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [tint.withValues(alpha: 0.32), tint.withValues(alpha: 0.10)],
                )
              : null,
          border: Border.all(color: selected ? tint.withValues(alpha: 0.9) : Colors.transparent, width: 1.5),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: selected ? tint : scheme.onSurfaceVariant),
                const SizedBox(height: 8),
                Text(
                  effect.name,
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: selected ? scheme.onSurface : scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
