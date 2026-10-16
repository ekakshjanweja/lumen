import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers.dart';
import 'core/theme/theme.dart';
import 'modules/gate/widgets/app_gate.dart';

class LumenApp extends ConsumerStatefulWidget {
  const LumenApp({super.key});

  @override
  ConsumerState<LumenApp> createState() => _LumenAppState();
}

class _LumenAppState extends ConsumerState<LumenApp> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onPause: () => ref.read(lightRepositoryProvider).pause(),
      onResume: () async {
        // The user may have just granted the permission in system settings.
        await ref.read(bluetoothRepositoryProvider).recheckPermission();
        ref.read(lightRepositoryProvider).resume();
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      // Draw behind transparent system bars so the ambient glow reaches the edges.
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarContrastEnforced: false,
        ),
        child: child!,
      ),
      home: const AppGate(),
    );
  }
}
