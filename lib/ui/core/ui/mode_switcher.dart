import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/models/light_state.dart';

/// Pill-shaped tab bar with a sliding highlight.
class ModeSwitcher extends StatelessWidget {
  const ModeSwitcher({super.key, required this.value, required this.onChanged});

  final LightMode value;
  final ValueChanged<LightMode> onChanged;

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
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(28)),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth / _items.length;
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                left: w * index,
                top: 0,
                bottom: 0,
                width: w,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF34343F),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 2))],
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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            if (mode == value) return;
                            HapticFeedback.selectionClick();
                            onChanged(mode);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: 18, color: mode == value ? scheme.onSurface : scheme.onSurfaceVariant),
                              const SizedBox(width: 8),
                              Text(
                                label,
                                style: text.labelLarge?.copyWith(
                                  color: mode == value ? scheme.onSurface : scheme.onSurfaceVariant,
                                ),
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
