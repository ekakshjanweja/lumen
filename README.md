# Lumen

Controls LTF_MWRGB / LYD_MWRGB lights (the "LEDLYD" app's lights) on Android and iOS.
The wire formats are in `lib/data/services/protocol/` (frame and beacon codecs).

## Architecture

Follows the [Flutter app architecture guide](https://docs.flutter.dev/app-architecture/guide):
MVVM in the UI layer, repositories and services in the data layer, with Riverpod for
dependency injection and view-model state.

```
lib/
  main.dart, app.dart     bootstrap, lifecycle, MaterialApp
  config/providers.dart   dependency graph (services -> repositories)
  domain/models/          pure models: LightState, PairedLight, Effect, ...
  data/
    services/             platform wrappers: BLE (flutter_blue_plus), the native
                          broadcaster (method channel), SharedPreferences, wire codecs
    repositories/         sources of truth: BluetoothRepository, LightRepository
  ui/
    core/                 theme and shared widgets
    gate/                 picks the top-level screen
    search/               finds the light by making it blink
    control/              colors, white, effects
      view_models/        Riverpod Notifiers: immutable state + intent methods
      widgets/            views: read state, call view-model methods
```

Dependencies only point downwards: views -> view models -> repositories -> services.
Views never touch repositories, and view models never touch Bluetooth APIs.

## Two kinds of light

- **Channel lights** never appear in a scan. The app broadcasts the light's state on its
  channel/group (factory default: channel 100, all groups). Android sends it as
  manufacturer data (`MainActivity.kt`), iOS as an iBeacon (`AppDelegate.swift`).
  These lights cannot send anything back, so there is no battery or state readback.
- **Connected lights** advertise a name and are driven over GATT (service FFF0).

## Commands

```sh
flutter test                       # codecs + view models (fake repositories in test/testing)
flutter build apk --release
flutter build ios --release        # needs a signing team set in Xcode
```
