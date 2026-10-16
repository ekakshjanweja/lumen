import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/bluetooth_repository.dart';
import '../data/repositories/light_repository.dart';
import '../data/services/beacon_service.dart';
import '../data/services/ble_service.dart';
import '../data/services/preferences_service.dart';

/// Dependency graph. Services wrap platform APIs; repositories own app data
/// and are what view models depend on. Tests override the repositories.

/// Overridden in main() with the loaded instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final preferencesServiceProvider = Provider((ref) => PreferencesService(ref.watch(sharedPreferencesProvider)));
final beaconServiceProvider = Provider((ref) => BeaconService());
final bleServiceProvider = Provider((ref) => BleService());

final bluetoothRepositoryProvider = Provider((ref) {
  final repo = BluetoothRepository(ble: ref.watch(bleServiceProvider), beacon: ref.watch(beaconServiceProvider));
  ref.onDispose(repo.dispose);
  return repo;
});

final lightRepositoryProvider = Provider((ref) {
  final repo = LightRepository(
    beacon: ref.watch(beaconServiceProvider),
    ble: ref.watch(bleServiceProvider),
    prefs: ref.watch(preferencesServiceProvider),
  );
  ref.onDispose(repo.dispose);
  return repo;
});
