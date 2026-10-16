import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/core/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance())],
  );
  await container.read(lightRepositoryProvider).restore();

  runApp(UncontrolledProviderScope(container: container, child: const LumenApp()));
}
