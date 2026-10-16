import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/core/providers.dart';
import 'src/services/preset_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),
      presetBoxProvider.overrideWithValue(await Hive.openBox<Map>(PresetStore.boxName)),
    ],
  );
  await container.read(lightRepositoryProvider).restore();

  runApp(UncontrolledProviderScope(container: container, child: const LumenApp()));
}
