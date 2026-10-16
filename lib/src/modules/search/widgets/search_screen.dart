import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/light_connection.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/ambient_background.dart';
import '../../../core/widgets/pressable.dart';
import '../view_models/search_view_model.dart';
import 'search_beacon.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  static const _red = Color(0xFFFF5A5A);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchViewModelProvider);
    final vm = ref.read(searchViewModelProvider.notifier);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final reduced = Motion.reduced(context);

    final (BeaconMode beacon, Color glow, String title, String body, List<Widget> actions) = switch (state.step) {
      SearchStep.intro => (
        BeaconMode.idle,
        scheme.primary,
        'Find your light',
        'Switch your light on and keep it close to your phone.',
        [_Primary('Search', vm.search)],
      ),
      SearchStep.blinking => (
        BeaconMode.blinking,
        Colors.white,
        'Is your light blinking?',
        'Lumen is making it blink right now, like this.',
        [_Primary('Yes, it\'s blinking', vm.confirmBlinking), _Secondary('No', vm.rejectBlinking)],
      ),
      SearchStep.sweeping => (
        BeaconMode.sweeping,
        _red,
        'Still looking…',
        'Watch your light and tap the button the moment it turns red.',
        [_Primary('It turned red', vm.turnedRed, color: _red, pulse: true)],
      ),
      SearchStep.confirming => (
        BeaconMode.alternating,
        _red,
        'Is it flashing red and blue?',
        'Checking ${state.candidate + 1} of ${state.candidateCount}',
        [_Primary('Yes', vm.confirmCandidate), _Secondary('No', vm.rejectCandidate)],
      ),
      SearchStep.notFound => (
        BeaconMode.stopped,
        scheme.outline,
        'Couldn\'t find your light',
        'Make sure it\'s switched on and charged, and close any other app that controls it.',
        [_Primary('Try again', vm.restart)],
      ),
    };

    Widget enter(Widget child, {Duration delay = Duration.zero}) => reduced
        ? child
        : child
              .animate(delay: delay)
              .fadeIn(duration: Motion.slow, curve: Motion.emphasized)
              .moveY(begin: 16, end: 0, duration: Motion.slow, curve: Motion.emphasized);

    return Scaffold(
      body: AmbientBackground(
        color: glow,
        level: state.step == SearchStep.notFound ? 0.2 : 0.55,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Center(
                  child: SearchBeacon(mode: beacon, color: glow, progress: state.progress),
                ),
                const SizedBox(height: 28),
                AnimatedSwitcher(
                  duration: Motion.medium,
                  transitionBuilder: (child, a) => FadeTransition(
                    opacity: a,
                    child: SlideTransition(
                      position: Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(a),
                      child: child,
                    ),
                  ),
                  child: Column(
                    key: ValueKey((state.step, state.candidate)),
                    children: [
                      Text(title, textAlign: TextAlign.center, style: text.headlineMedium),
                      const SizedBox(height: 10),
                      Text(
                        body,
                        textAlign: TextAlign.center,
                        style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: Motion.medium,
                  curve: Motion.emphasized,
                  child: state.step == SearchStep.sweeping
                      ? Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            '${(state.progress * 100).round()}% checked',
                            textAlign: TextAlign.center,
                            style: text.labelLarge?.copyWith(
                              color: _red,
                              fontFeatures: const [FontFeature.tabularFigures()],
                            ),
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
                const Spacer(),
                if (state.step == SearchStep.intro && state.nearby.isNotEmpty) ...[
                  Text('Found nearby', style: text.labelLarge?.copyWith(color: scheme.onSurfaceVariant)),
                  const SizedBox(height: 10),
                  for (final (i, light) in state.nearby.take(3).indexed)
                    enter(
                      _NearbyLight(
                        light: light,
                        connecting: state.connectingId == light.id,
                        onTap: state.connectingId == null ? () => vm.connectNearby(light) : null,
                      ),
                      delay: (60 * i).ms,
                    ),
                  const SizedBox(height: 8),
                ],
                // Re-keyed per step so the buttons animate in with the new question.
                KeyedSubtree(
                  key: ValueKey(state.step),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [for (final a in actions) enter(a)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NearbyLight extends StatelessWidget {
  const _NearbyLight({required this.light, required this.connecting, required this.onTap});

  final FoundLight light;
  final bool connecting;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Pressable(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.glass,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.light_rounded, color: scheme.primary),
              const SizedBox(width: 14),
              Expanded(child: Text(light.name, style: text.titleSmall)),
              AnimatedSwitcher(
                duration: Motion.fast,
                child: connecting
                    ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Primary extends StatelessWidget {
  const _Primary(this.label, this.onPressed, {this.color, this.pulse = false});

  final String label;
  final VoidCallback onPressed;
  final Color? color;

  /// Glows on and off to draw the eye, for buttons the user must hit in time.
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fill = color ?? scheme.primary;
    Widget button = Pressable(
      haptic: false,
      onTap: () {
        HapticFeedback.mediumImpact();
        onPressed();
      },
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: fill.withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 6))],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: color == null ? scheme.onPrimary : Colors.white,
          ),
        ),
      ),
    );
    if (pulse && !Motion.reduced(context)) {
      button = button
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1, end: 1.03, duration: 700.ms, curve: Curves.easeInOutSine);
    }
    return Semantics(button: true, child: button);
  }
}

class _Secondary extends StatelessWidget {
  const _Secondary(this.label, this.onPressed);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
