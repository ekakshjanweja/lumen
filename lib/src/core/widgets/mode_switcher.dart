import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/light_state.dart';
import '../theme/theme.dart';

/// Pill-shaped tab bar whose highlight springs to the selected mode and picks
/// up the light's colour.
class ModeSwitcher extends StatelessWidget {
  const ModeSwitcher({super.key, required this.value, required this.onChanged, required this.tint});

  final LightMode value;
  final ValueChanged<LightMode> onChanged;
  final Color tint;

  static const _items = [
    (LightMode.white, 'White', Icons.wb_sunny_rounded),
    (LightMode.color, 'Color', Icons.palette_rounded),
    (LightMode.effect, 'Effects', Icons.auto_awesome_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final index = _items.indexWhere((i) => i.$1 == value);

    return Container(
      height: 58,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme.glass,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: AppTheme.glassBorder),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth / _items.length;
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 450),
                curve: Motion.spring,
                left: w * index,
                top: 0,
                bottom: 0,
                width: w,
                child: AnimatedContainer(
                  duration: Motion.medium,
                  decoration: BoxDecoration(
                    color: Color.lerp(scheme.surfaceContainerHighest, tint, 0.16),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: tint.withValues(alpha: 0.28)),
                    boxShadow: [BoxShadow(color: tint.withValues(alpha: 0.16), blurRadius: 18)],
                  ),
                ),
              ),
              Row(
                children: [
                  for (final (mode, label, icon) in _items)
                    Expanded(
                      child: Semantics(
                        button: true,
                        selected: mode == value,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (mode == value) return;
                            HapticFeedback.selectionClick();
                            onChanged(mode);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedScale(
                                scale: mode == value ? 1.12 : 1,
                                duration: Motion.medium,
                                curve: Motion.spring,
                                child: Icon(
                                  icon,
                                  size: 18,
                                  color: mode == value ? scheme.onSurface : scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedDefaultTextStyle(
                                duration: Motion.fast,
                                style: text.labelLarge!.copyWith(
                                  color: mode == value ? scheme.onSurface : scheme.onSurfaceVariant,
                                ),
                                child: Text(label),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
