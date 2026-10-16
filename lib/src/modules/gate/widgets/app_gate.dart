import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../control/widgets/control_screen.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/message_screen.dart';
import '../../search/widgets/search_screen.dart';
import '../view_models/app_gate_view_model.dart';

/// Shows the right top-level screen for the current Bluetooth and pairing state.
class AppGate extends ConsumerWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appGateViewModelProvider);
    final vm = ref.read(appGateViewModelProvider.notifier);

    final Widget screen = switch (state.screen) {
      AppScreen.splash => const Scaffold(key: ValueKey('splash')),
      AppScreen.bluetoothOff => MessageScreen(
        key: const ValueKey('bt-off'),
        icon: Icons.bluetooth_disabled_rounded,
        title: 'Bluetooth is off',
        body: state.canTurnOnBluetooth
            ? 'Lumen controls your light over Bluetooth.'
            : 'Turn on Bluetooth in Control Center to control your light.',
        action: state.canTurnOnBluetooth
            ? FilledButton(onPressed: vm.turnOnBluetooth, child: const Text('Turn on Bluetooth'))
            : null,
      ),
      AppScreen.permission => MessageScreen(
        key: const ValueKey('permission'),
        icon: Icons.bluetooth_rounded,
        title: 'Allow Bluetooth access',
        body: 'Lumen needs Bluetooth permission ("Nearby devices" on Android) to send commands to your light.',
        action: Column(
          children: [
            if (!state.needsSettings) ...[
              FilledButton(onPressed: vm.allowPermission, child: const Text('Allow')),
              const SizedBox(height: 8),
            ],
            TextButton(onPressed: vm.openSettings, child: const Text('Open settings')),
          ],
        ),
      ),
      AppScreen.search => const SearchScreen(key: ValueKey('search')),
      AppScreen.control => const ControlScreen(key: ValueKey('control')),
    };

    return AnimatedSwitcher(
      duration: Motion.slow,
      switchInCurve: Motion.emphasized,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, a) => FadeTransition(
        opacity: a,
        child: ScaleTransition(scale: Tween(begin: 0.96, end: 1.0).animate(a), child: child),
      ),
      child: screen,
    );
  }
}
