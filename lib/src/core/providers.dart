import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/bluetooth_repository.dart';
import '../repositories/light_repository.dart';
import '../services/beacon_service.dart';
import '../services/ble_service.dart';
import '../services/preferences_service.dart';

part 'providers.g.dart';

/// Dependency graph. Services wrap platform APIs; repositories own app data
/// and are what view models depend on. Tests override the repositories.

/// Overridden in main() with the loaded instance.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden');

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) => PreferencesService(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
BeaconService beaconService(Ref ref) => BeaconService();

@Riverpod(keepAlive: true)
BleService bleService(Ref ref) => BleService();

@Riverpod(keepAlive: true)
BluetoothRepository bluetoothRepository(Ref ref) {
  final repo = BluetoothRepository(ble: ref.watch(bleServiceProvider), beacon: ref.watch(beaconServiceProvider));
  ref.onDispose(repo.dispose);
  return repo;
}

@Riverpod(keepAlive: true)
LightRepository lightRepository(Ref ref) {
  final repo = LightRepository(
    beacon: ref.watch(beaconServiceProvider),
    ble: ref.watch(bleServiceProvider),
    prefs: ref.watch(preferencesServiceProvider),
  );
  ref.onDispose(repo.dispose);
  return repo;
}
