# Lumen

A fast, good-looking remote for Bluetooth LED video lights that normally use the **LEDLYD**
app. Find your light in a few taps, then set white, colour, brightness and effects from a
single screen. Runs on Android and iOS, works offline and has no accounts.

<p align="center">
  <img src="docs/screenshots/search.jpg" width="19%" alt="Finding the light" />
  <img src="docs/screenshots/white.jpg" width="19%" alt="White light" />
  <img src="docs/screenshots/color.jpg" width="19%" alt="Colour picker" />
  <img src="docs/screenshots/effects.jpg" width="19%" alt="Effects" />
  <img src="docs/screenshots/presets.jpg" width="19%" alt="Colour presets" />
</p>

> Lumen is an independent project. It is not made by, or affiliated with, the makers of the
> LEDLYD app or the lights.

## What it does

- **Finds your light without any setup codes.** Lumen makes the light blink and asks if you
  saw it. If the light was moved off its factory channel, Lumen checks every channel and
  group until you tell it the light turned red.
- **White:** colour temperature from 2500 K to 9900 K, with Tungsten, Neutral, Daylight and
  Cloudy presets.
- **Colour:** a colour pad for hue and saturation, a row of quick presets, and a presets
  sheet with 12 built-in colours. Save your own colours by name and delete them again.
- **Effects:** all 24 effects built into the light:
  - **Ambient:** TV, Candle, Flame 1–2, Romantic
  - **Emergency:** Police, Ambulance, Fire truck
  - **Flash & strobe:** Flash 1–2, Strobe 1–3
  - **Party:** Chase 1–3, Fireworks 1–3, Club 1–2, Music, Wave 1–2
- **Brightness and power:** a large brightness slider. Tap the light on screen to switch the
  real one on or off.
- **Live preview:** the on-screen light glows in the colour you picked and plays a soft
  preview of the selected effect.
- **Remembers everything:** your light, its last setting and your saved colours are kept on
  the phone, and the light is set back the way you left it when you open the app.

## Compatible lights

Lumen speaks the same Bluetooth protocol as the LEDLYD app (Android package
`uni.UNI6FB700B`). **If your light works with LEDLYD, it should work with Lumen.** Those
lights come in two kinds, and Lumen handles both:

| Kind | How to recognise it | How Lumen controls it | Status |
|---|---|---|---|
| **Broadcast lights** | Never show up in a Bluetooth scan, and there is nothing to "connect" to. Small handheld/pocket RGB lights with a screen and **M / + / − / ▶** buttons. | Broadcasts the light's settings on its channel (1–100) and group (A–F or all). Factory default is channel 100, all groups. | ✅ Tested on hardware: white, colour, brightness, power and all effects. |
| **Connected lights** | Show up in a Bluetooth scan as `LTF_MWRGB`, `LYD_MWRGB`, `Bough_Systems` or `LYDBough_Systems`. | Connects to the light and sends commands directly. The light reports its settings back. | ⚠️ Built from the protocol but not yet tested on a real light. |

Not compatible: lights that use a different app, such as Philips Hue, Govee, Nanoleaf,
Aputure Sidus or Godox.

## Getting started

1. Switch the light on and keep it close to your phone.
2. Open Lumen and allow Bluetooth access ("Nearby devices" on Android).
3. Tap **Search**. Lumen makes your light blink.
   - **Blinking?** Tap **Yes**. You're done.
   - **Not blinking?** Tap **No**. Lumen checks every channel and group, which can take a
     few minutes. Watch the light and tap **It turned red** as soon as it does. Lumen then
     flashes the last few candidates red and blue until you confirm the right one.
4. Connected lights show up under **Found nearby** on the search screen. Tap one to connect.

To set up a different light later, tap the radar button in the top right.

## Good to know

- **Broadcast lights can't send anything back.** Battery level and the light's current
  setting can't be shown. Lumen shows what it last sent.
- **Lumen only controls the light while it's open.** It stops broadcasting when it goes to
  the background, and iOS doesn't allow background broadcasting anyway.
- **One phone at a time.** If two phones broadcast different settings on the same channel,
  the light flips between them. Close the app (Lumen or LEDLYD) on the other phone.
- **One light at a time.** Lumen controls the light it was set up with. Lights that share a
  channel and group all follow it together.
- **Reduce motion is respected.** Looping animations stop when the system setting is on, and
  effect previews never flash more than 3 times a second.

## Privacy

Lumen has no accounts, analytics or ads, and makes no network requests. The Android release
build doesn't even request internet access. Everything it remembers stays on your phone.

## Requirements

- **Android 7.0 or newer**, on a phone whose Bluetooth supports advertising (almost all do).
- **iOS 15 or newer.**

## Building

Requires Flutter 3.47 or newer (Dart 3.13).

```sh
flutter pub get
flutter run                          # on a connected phone; Bluetooth doesn't work in simulators
flutter build apk --release
flutter build ios --release          # set your signing team in Xcode first
```

Generated code (`*.freezed.dart`, `*.g.dart`) is committed. After changing a model, provider
or view model, regenerate it:

```sh
dart run build_runner watch -d
```

Tests cover the wire codecs, preset storage and every view model, using fake repositories
from `test/testing/`:

```sh
flutter test
```

## How it talks to the light

- **Broadcast lights** listen for a 23-byte, iBeacon-shaped advert:
  `02 15`, then the UUID `FAA50000-1111-ABCD-0123-BE89`, then the channel as a 32-bit number,
  then major, minor and power.
  - **Major** packs the group (bits 0–2, where 7 means all groups), the effect and the
    saturation.
  - **Minor** carries the hue, or the colour temperature.
  - **Power** is the brightness, where 0 means off.

  Android sends the advert as manufacturer data (company `0xFFFF`, `MainActivity.kt`). iOS
  sends it as a real iBeacon (`AppDelegate.swift`), because iOS doesn't allow custom
  manufacturer data.
- **Connected lights** use GATT service `FFF0`. Lumen writes 10-byte frames to `FFF3`
  (mode, effect, brightness, temperature, hue, saturation and effect parameters) and reads
  the same layout back from `FFF4`.

The encoders are in `lib/src/services/protocol/`.

## Project structure

The code follows the [Flutter app architecture guide](https://docs.flutter.dev/app-architecture/guide):
MVVM in the UI layer, with services and repositories in the data layer. Riverpod handles
dependency injection and view-model state.

```
lib/
  main.dart               startup: storage, provider container, runApp
  src/
    app.dart              lifecycle, MaterialApp
    core/
      providers.dart      dependency graph (services -> repositories)
      models/             pure models: LightState, PairedLight, Effect, ColorPreset, ...
      theme/              theme, motion, light colours, effect previews
      widgets/            shared widgets: light orb, colour pad, sliders, ...
    services/             platform wrappers: BLE (flutter_blue_plus), the native
                          broadcaster (method channel), SharedPreferences, Hive
      protocol/           wire codecs (GATT frame, broadcast beacon)
    repositories/         sources of truth: BluetoothRepository, LightRepository,
                          PresetRepository
    modules/
      gate/               picks the top-level screen
      search/             finds the light by making it blink
      control/            white, colour, effects and presets
        view_models/      Riverpod notifiers: immutable state + intent methods
        widgets/          views: read state, call view-model methods
```

Dependencies only point downwards: views -> view models -> repositories -> services. Views
never touch repositories, and view models never touch Bluetooth APIs.

**Built with:**
- [freezed](https://pub.dev/packages/freezed) for immutable models and screen states
- [riverpod_generator](https://pub.dev/packages/riverpod_generator) for providers and view models
- [hive_ce](https://pub.dev/packages/hive_ce) for saved colours
- [flutter_animate](https://pub.dev/packages/flutter_animate) for entrance animations
- [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus) for scanning and connecting

## Third-party licences

- **flutter_blue_plus** is free for non-commercial use only. Shipping Lumen commercially
  needs a commercial licence from its authors, or a different BLE library.
- **Manrope** font: SIL Open Font License (`assets/fonts/Manrope-OFL.txt`).
