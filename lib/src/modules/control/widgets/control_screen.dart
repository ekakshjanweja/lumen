import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/light_connection.dart';
import '../../../core/models/light_state.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/ambient_background.dart';
import '../../../core/widgets/light_orb.dart';
import '../../../core/widgets/mode_switcher.dart';
import '../../../core/widgets/pressable.dart';
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
    final reduced = Motion.reduced(context);

    final sections = <Widget>[
      _Header(state: state, onSearch: () => _confirmSearch(context, vm)),
      const SizedBox(height: 12),
      Center(
        child: LightOrb(light: s, onToggle: vm.togglePower),
      ),
      const SizedBox(height: 4),
      _Readout(light: s),
      const SizedBox(height: 28),
      TrackSlider(
        label: 'Brightness',
        icon: Icons.brightness_6_rounded,
        format: (v) => '${v.round()}%',
        value: s.brightness.toDouble(),
        min: 1,
        max: 100,
        fillColor: s.on ? Color.lerp(s.previewColor, Colors.white, 0.12) : scheme.surfaceContainerHighest,
        onChanged: (v) => vm.setBrightness(v.round()),
      ),
      const SizedBox(height: 14),
      ModeSwitcher(value: s.mode, onChanged: vm.setMode, tint: s.on ? s.previewColor : scheme.outline),
      const SizedBox(height: 26),
      _ModePanel(mode: s.mode),
      if (state.status == LinkStatus.reconnecting) ...[
        const SizedBox(height: 20),
        Text(
          'Lost connection. Reconnecting…',
          textAlign: TextAlign.center,
          style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    ];

    return Scaffold(
      body: AmbientBackground(
        color: s.previewColor,
        level: s.on ? 0.35 + 0.65 * s.brightness / 100 : 0,
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 40 + MediaQuery.paddingOf(context).bottom),
            children: reduced
                ? sections
                : sections
                      .animate(interval: 45.ms)
                      .fadeIn(duration: Motion.slow, curve: Motion.emphasized)
                      .moveY(begin: 18, end: 0, duration: Motion.slow, curve: Motion.emphasized),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmSearch(BuildContext context, ControlViewModel vm) async {
    final ok = await showModalBottomSheet<bool>(context: context, builder: (context) => const _SearchAgainSheet());
    if (ok == true) await vm.findLightAgain();
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state, required this.onSearch});

  final ControlState state;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.name, style: text.headlineSmall),
              if (state.showsLinkStatus) ...[const SizedBox(height: 2), _LinkStatus(state.status)],
            ],
          ),
        ),
        Tooltip(
          message: 'Find light again',
          child: Pressable(
            onTap: onSearch,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.glass,
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Icon(Icons.radar_rounded, size: 22, color: scheme.onSurface),
            ),
          ),
        ),
      ],
    );
  }
}

/// Big brightness number with a caption, both animating as they change.
class _Readout extends StatelessWidget {
  const _Readout({required this.light});

  final LightState light;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final big = text.displaySmall!.copyWith(fontFeatures: const [FontFeature.tabularFigures()], height: 1.1);

    return Column(
      children: [
        AnimatedSwitcher(
          duration: Motion.medium,
          transitionBuilder: (child, a) => FadeTransition(
            opacity: a,
            child: ScaleTransition(scale: Tween(begin: 0.9, end: 1.0).animate(a), child: child),
          ),
          child: light.on
              ? TweenAnimationBuilder<double>(
                  key: const ValueKey('on'),
                  tween: Tween(end: light.brightness.toDouble()),
                  duration: Motion.medium,
                  curve: Motion.emphasized,
                  builder: (context, v, _) => Text('${v.round()}%', style: big),
                )
              : Text(
                  'Off',
                  key: const ValueKey('off'),
                  style: big.copyWith(color: scheme.onSurfaceVariant),
                ),
        ),
        const SizedBox(height: 2),
        AnimatedSwitcher(
          duration: Motion.medium,
          transitionBuilder: (child, a) => FadeTransition(
            opacity: a,
            child: SlideTransition(
              position: Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(a),
              child: child,
            ),
          ),
          child: Text(
            light.on ? light.caption : 'Tap the light to turn it on',
            // Kelvin changes on every drag step, so only mode or colour changes animate.
            key: ValueKey((light.on, light.mode, light.mode == LightMode.white ? null : light.caption)),
            style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

/// Swaps panels with a slide in the direction of the chosen tab, and eases
/// the page height to the new panel.
class _ModePanel extends StatefulWidget {
  const _ModePanel({required this.mode});

  final LightMode mode;

  @override
  State<_ModePanel> createState() => _ModePanelState();
}

class _ModePanelState extends State<_ModePanel> {
  int _direction = 1;

  @override
  void didUpdateWidget(_ModePanel old) {
    super.didUpdateWidget(old);
    if (old.mode != widget.mode) _direction = widget.mode.index > old.mode.index ? 1 : -1;
  }

  @override
  Widget build(BuildContext context) {
    final current = ValueKey(widget.mode);
    return AnimatedSize(
      duration: Motion.slow,
      curve: Motion.emphasized,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: Motion.medium,
        switchInCurve: Motion.emphasized,
        switchOutCurve: Curves.easeIn,
        layoutBuilder: (current, previous) => Stack(alignment: Alignment.topCenter, children: [...previous, ?current]),
        transitionBuilder: (child, animation) {
          final incoming = child.key == current;
          final from = Offset(0.12 * _direction * (incoming ? 1 : -1), 0);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(begin: from, end: Offset.zero).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: current,
          child: switch (widget.mode) {
            LightMode.white => const WhitePanel(),
            LightMode.color => const ColorPanel(),
            LightMode.effect => const EffectsPanel(),
          },
        ),
      ),
    );
  }
}

class _SearchAgainSheet extends StatelessWidget {
  const _SearchAgainSheet();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.radar_rounded, size: 40, color: scheme.primary),
            const SizedBox(height: 16),
            Text('Find your light again?', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              'Use this if your light stopped responding, or to set up a different one.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Search again')),
            const SizedBox(height: 4),
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ],
        ),
      ),
    );
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
    Widget dot = AnimatedContainer(
      duration: Motion.medium,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: connected ? const Color(0xFF4ADE80) : const Color(0xFFFBBF24),
        shape: BoxShape.circle,
      ),
    );
    if (!connected && !Motion.reduced(context)) {
      dot = dot.animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: 0.3, duration: 700.ms);
    }
    return Row(
      children: [
        dot,
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
