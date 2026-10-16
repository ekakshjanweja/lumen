# Lumen

Controls LTF_MWRGB / LYD_MWRGB lights (the "LEDLYD" app's lights) on Android and iOS.
The wire formats are in `lib/src/services/protocol/` (frame and beacon codecs).

## Architecture

Follows the [Flutter app architecture guide](https://docs.flutter.dev/app-architecture/guide):
MVVM in the UI layer, repositories and services in the data layer, with Riverpod for
dependency injection and view-model state.

```
lib/
  main.dart               bootstrap: preferences, provider container, runApp
  src/
    app.dart              lifecycle, MaterialApp
    core/
      providers.dart      dependency graph (services -> repositories)
      models/             pure models: LightState, PairedLight, Effect, ...
      theme/              theme and light colour helpers
      widgets/            shared widgets: orb, colour wheel, sliders, ...
    services/             platform wrappers: BLE (flutter_blue_plus), the native
                          broadcaster (method channel), SharedPreferences
      protocol/           wire codecs (GATT frame, broadcast beacon)
    repositories/         sources of truth: BluetoothRepository, LightRepository
    modules/
      gate/               picks the top-level screen
      search/             finds the light by making it blink
      control/            colors, white, effects
        view_models/      Riverpod Notifiers: immutable state + intent methods
        widgets/          views: read state, call view-model methods
```

Models and view-model states are [freezed](https://pub.dev/packages/freezed) classes;
providers and view models use [riverpod_generator](https://pub.dev/packages/riverpod_generator).
The generated `*.freezed.dart` / `*.g.dart` files are committed, so the app builds
without running the generator first.

Dependencies only point downwards: views -> view models -> repositories -> services.
Views never touch repositories, and view models never touch Bluetooth APIs.

## Design

Dark, light-first UI: the orb in the middle glows in the light's colour and plays a soft
preview of the selected effect (kept under 3 flashes a second), with ambient colour
drifting behind the page. Motion uses shared durations and curves (`Motion` in
`core/theme/theme.dart`), [flutter_animate](https://pub.dev/packages/flutter_animate) for
entrances, and all looping animation stops when the system asks for reduced motion.
The bundled font is [Manrope](https://github.com/googlefonts/manrope) (SIL OFL,
`assets/fonts/Manrope-OFL.txt`).

## Two kinds of light

- **Channel lights** never appear in a scan. The app broadcasts the light's state on its
  channel/group (factory default: channel 100, all groups). Android sends it as
  manufacturer data (`MainActivity.kt`), iOS as an iBeacon (`AppDelegate.swift`).
  These lights cannot send anything back, so there is no battery or state readback.
- **Connected lights** advertise a name and are driven over GATT (service FFF0).

## Commands

```sh
dart run build_runner watch -d     # regenerate freezed / riverpod code while editing
flutter test                       # codecs + view models (fake repositories in test/testing; tests mirror lib/src)
flutter build apk --release
flutter build ios --release        # needs a signing team set in Xcode
```
