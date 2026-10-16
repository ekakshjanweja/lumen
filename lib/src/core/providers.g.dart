// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dependency graph. Services wrap platform APIs; repositories own app data
/// and are what view models depend on. Tests override the repositories.
/// Overridden in main() with the loaded instance.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Dependency graph. Services wrap platform APIs; repositories own app data
/// and are what view models depend on. Tests override the repositories.
/// Overridden in main() with the loaded instance.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Dependency graph. Services wrap platform APIs; repositories own app data
  /// and are what view models depend on. Tests override the repositories.
  /// Overridden in main() with the loaded instance.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'70ef90bd70df9f89260fca9b542d9f8d25d8e3cb';

@ProviderFor(preferencesService)
final preferencesServiceProvider = PreferencesServiceProvider._();

final class PreferencesServiceProvider
    extends
        $FunctionalProvider<
          PreferencesService,
          PreferencesService,
          PreferencesService
        >
    with $Provider<PreferencesService> {
  PreferencesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesServiceHash();

  @$internal
  @override
  $ProviderElement<PreferencesService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PreferencesService create(Ref ref) {
    return preferencesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesService>(value),
    );
  }
}

String _$preferencesServiceHash() =>
    r'673258843f04de47988ecb5b99eda69ce30903a9';

@ProviderFor(beaconService)
final beaconServiceProvider = BeaconServiceProvider._();

final class BeaconServiceProvider
    extends $FunctionalProvider<BeaconService, BeaconService, BeaconService>
    with $Provider<BeaconService> {
  BeaconServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'beaconServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$beaconServiceHash();

  @$internal
  @override
  $ProviderElement<BeaconService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BeaconService create(Ref ref) {
    return beaconService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BeaconService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BeaconService>(value),
    );
  }
}

String _$beaconServiceHash() => r'a6aa9139dbaaaeb8935eed072c589280e4e4a24f';

@ProviderFor(bleService)
final bleServiceProvider = BleServiceProvider._();

final class BleServiceProvider
    extends $FunctionalProvider<BleService, BleService, BleService>
    with $Provider<BleService> {
  BleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleServiceHash();

  @$internal
  @override
  $ProviderElement<BleService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BleService create(Ref ref) {
    return bleService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BleService>(value),
    );
  }
}

String _$bleServiceHash() => r'c91254eb79630a1297315b1b63a69934cf996a22';

@ProviderFor(bluetoothRepository)
final bluetoothRepositoryProvider = BluetoothRepositoryProvider._();

final class BluetoothRepositoryProvider
    extends
        $FunctionalProvider<
          BluetoothRepository,
          BluetoothRepository,
          BluetoothRepository
        >
    with $Provider<BluetoothRepository> {
  BluetoothRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bluetoothRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bluetoothRepositoryHash();

  @$internal
  @override
  $ProviderElement<BluetoothRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BluetoothRepository create(Ref ref) {
    return bluetoothRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BluetoothRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BluetoothRepository>(value),
    );
  }
}

String _$bluetoothRepositoryHash() =>
    r'e1122f4c79696a533e4b808e55630869d8535302';

@ProviderFor(lightRepository)
final lightRepositoryProvider = LightRepositoryProvider._();

final class LightRepositoryProvider
    extends
        $FunctionalProvider<LightRepository, LightRepository, LightRepository>
    with $Provider<LightRepository> {
  LightRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lightRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lightRepositoryHash();

  @$internal
  @override
  $ProviderElement<LightRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LightRepository create(Ref ref) {
    return lightRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LightRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LightRepository>(value),
    );
  }
}

String _$lightRepositoryHash() => r'c5f0af11ede2719b9d6e2cc3acd4660b13436b7e';
