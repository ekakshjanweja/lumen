import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/light_connection.dart';
import '../../../core/models/light_state.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/widgets/light_orb.dart';
import '../../../core/widgets/mode_switcher.dart';
import '../../../core/widgets/track_slider.dart';
import '../view_models/control_view_model.dart';
import 'color_panel.dart';
import 'effects_panel.dart';
import 'white_panel.dart';

class ControlScreen extends ConsumerWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controlViewModelProvider);
    final vm = ref.read(controlViewModelProvider.notifier);
    final s = state.light;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final level = s.on ? 0.3 + 0.7 * s.brightness / 100 : 0.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.7),
                  radius: 1.1,
                  colors: [
                    s.previewColor.withValues(alpha: 0.28 * level),
                    scheme.surface.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.name,
                            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
                          ),
                          const SizedBox(height: 2),
                          if (state.showsLinkStatus)
                            _LinkStatus(state.status)
                          else
                            Text(
                              s.on ? 'On · ${s.caption}' : 'Off',
                              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      style: IconButton.styleFrom(
                        backgroundColor: scheme.surfaceContainerHighest,
                        foregroundColor: scheme.onSurface,
                      ),
                      tooltip: 'Find light again',
                      icon: const Icon(Icons.radar_rounded),
                      onPressed: () => _confirmSearch(context, vm),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Center(
                  child: LightOrb(
                    color: s.previewColor,
                    brightness: s.brightness,
                    on: s.on,
                    caption: s.caption,
                    onToggle: vm.togglePower,
                  ),
                ),
                const SizedBox(height: 36),
                TrackSlider(
                  label: 'Brightness',
                  icon: Icons.brightness_6_rounded,
                  valueText: '${s.brightness}%',
                  value: s.brightness.toDouble(),
                  min: 1,
                  max: 100,
                  fillColor: Color.lerp(s.previewColor, Colors.white, 0.15),
                  onChanged: (v) => vm.setBrightness(v.round()),
                ),
                const SizedBox(height: 16),
                ModeSwitcher(value: s.mode, onChanged: vm.setMode),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: KeyedSubtree(
                    key: ValueKey(s.mode),
                    child: switch (s.mode) {
                      LightMode.white => const WhitePanel(),
                      LightMode.color => const ColorPanel(),
                      LightMode.effect => const EffectsPanel(),
                    },
                  ),
                ),
                if (state.status == LinkStatus.reconnecting) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Lost connection. Reconnecting…',
                    textAlign: TextAlign.center,
                    style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSearch(BuildContext context, ControlViewModel vm) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find your light again?'),
        content: const Text('Use this if your light stopped responding, or to set up a different one.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Search')),
        ],
      ),
    );
    if (ok == true) await vm.findLightAgain();
  }
}

class _LinkStatus extends StatelessWidget {
  const _LinkStatus(this.status);
  final LinkStatus status;

  @override
  Widget build(BuildContext context) {
    final connected = status == LinkStatus.connected;
    final label = switch (status) {
      LinkStatus.connected => 'Connected',
      LinkStatus.connecting => 'Connecting…',
      LinkStatus.reconnecting => 'Reconnecting…',
    };
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: connected ? const Color(0xFF4ADE80) : const Color(0xFFFBBF24),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
