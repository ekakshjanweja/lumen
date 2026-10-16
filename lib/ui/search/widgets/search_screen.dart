import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/message_screen.dart';
import '../view_models/search_view_model.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  static const _red = Color(0xFFFF5A5A);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchViewModelProvider);
    final vm = ref.read(searchViewModelProvider.notifier);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final (Color glow, String title, String body, List<Widget> actions) = switch (state.step) {
      SearchStep.intro => (
        scheme.primary,
        'Find your light',
        'Switch your light on and keep it close to your phone.',
        [_primary('Search', vm.search)],
      ),
      SearchStep.blinking => (
        Colors.white,
        'Is your light blinking?',
        'Lumen is making it blink right now.',
        [_primary('Yes, it\'s blinking', vm.confirmBlinking), _secondary('No', vm.rejectBlinking)],
      ),
      SearchStep.sweeping => (
        _red,
        'Still looking…',
        'Watch your light and tap the button the moment it turns red.',
        [_primary('It turned red', vm.turnedRed, color: _red)],
      ),
      SearchStep.confirming => (
        const Color(0xFF6E7BFF),
        'Is it flashing red and blue?',
        'Checking ${state.candidate + 1} of ${state.candidateCount}',
        [_primary('Yes', vm.confirmCandidate), _secondary('No', vm.rejectCandidate)],
      ),
      SearchStep.notFound => (
        scheme.outline,
        'Couldn\'t find your light',
        'Make sure it\'s switched on and charged, and close any other app that controls it.',
        [_primary('Try again', vm.restart)],
      ),
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: PulseRings(active: state.step != SearchStep.notFound, color: glow, size: 220),
              ),
              const SizedBox(height: 36),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Column(
                  key: ValueKey(state.step),
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: text.headlineMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (state.step == SearchStep.sweeping) ...[
                const SizedBox(height: 28),
                LinearProgressIndicator(
                  value: state.progress,
                  color: _red,
                  backgroundColor: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
              const Spacer(),
              if (state.step == SearchStep.intro && state.nearby.isNotEmpty) ...[
                Text('Found nearby', style: text.labelLarge?.copyWith(color: scheme.onSurfaceVariant)),
                const SizedBox(height: 8),
                for (final light in state.nearby.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      tileColor: scheme.surfaceContainer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      leading: const Icon(Icons.light_rounded),
                      title: Text(light.name),
                      trailing: state.connectingId == light.id
                          ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.chevron_right_rounded),
                      onTap: state.connectingId == null ? () => vm.connectNearby(light) : null,
                    ),
                  ),
                const SizedBox(height: 8),
              ],
              ...actions,
            ],
          ),
        ),
      ),
    );
  }

  Widget _primary(String label, VoidCallback onPressed, {Color? color}) => FilledButton(
    onPressed: () {
      HapticFeedback.mediumImpact();
      onPressed();
    },
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(60),
      backgroundColor: color,
      foregroundColor: color == null ? null : Colors.white,
      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    ),
    child: Text(label),
  );

  Widget _secondary(String label, VoidCallback onPressed) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(minimumSize: const Size.fromHeight(52)),
      child: Text(label),
    ),
  );
}
