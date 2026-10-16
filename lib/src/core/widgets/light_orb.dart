import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The light preview: glows in the light's colour, scaled by brightness.
/// Tapping it toggles power.
class LightOrb extends StatelessWidget {
  const LightOrb({
    super.key,
    required this.color,
    required this.brightness,
    required this.on,
    required this.onToggle,
    required this.caption,
  });

  final Color color;
  final int brightness;
  final bool on;
  final VoidCallback onToggle;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final level = on ? 0.25 + 0.75 * brightness / 100 : 0.0;
    final core = Color.lerp(const Color(0xFF1C1C22), color, on ? 0.35 + 0.65 * brightness / 100 : 0)!;
    final ink = core.computeLuminance() > 0.18 ? Colors.black87 : Colors.white;
    const duration = Duration(milliseconds: 220);

    return Semantics(
      button: true,
      toggled: on,
      label: 'Light power',
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          onToggle();
        },
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          width: 196,
          height: 196,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Color.lerp(core, Colors.white, on ? 0.35 : 0)!, core],
              stops: const [0, 1],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.55 * level),
                blurRadius: 80 * level + 1,
                spreadRadius: 18 * level,
              ),
            ],
            border: Border.all(color: Colors.white.withValues(alpha: on ? 0.0 : 0.08), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.power_settings_new_rounded, color: ink.withValues(alpha: 0.7), size: 26),
              const SizedBox(height: 6),
              Text(
                on ? '$brightness%' : 'Off',
                style: text.displaySmall?.copyWith(
                  color: ink,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 2),
              Text(caption, style: text.labelMedium?.copyWith(color: ink.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ),
    );
  }
}
