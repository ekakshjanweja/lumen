import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers.dart';
import '../../../repositories/bluetooth_repository.dart';
import '../../../repositories/light_repository.dart';
import '../../../core/models/bluetooth_status.dart';
import '../../../core/models/paired_light.dart';

part 'app_gate_view_model.freezed.dart';
part 'app_gate_view_model.g.dart';

enum AppScreen { splash, bluetoothOff, permission, search, control }

@freezed
abstract class AppGateState with _$AppGateState {
  const factory AppGateState(
    AppScreen screen, {
    @Default(false) bool canTurnOnBluetooth,

    /// The permission can only be granted from system settings now.
    @Default(false) bool needsSettings,
  }) = _AppGateState;
}

/// Decides which top-level screen to show.
@Riverpod(keepAlive: true)
class AppGateViewModel extends _$AppGateViewModel {
  late BluetoothRepository _bluetooth;
  late LightRepository _lights;
  bool _askedPermission = false;

  @override
  AppGateState build() {
    _bluetooth = ref.watch(bluetoothRepositoryProvider);
    _lights = ref.watch(lightRepositoryProvider);
    final subs = [_bluetooth.changes.listen((_) => _refresh()), _lights.connectionChanges.listen((_) => _refresh())];
    ref.onDispose(() {
      for (final s in subs) {
        s.cancel();
      }
    });
    scheduleMicrotask(_maybeAskPermission);
    return _compute();
  }

  void _refresh() {
    if (!ref.mounted) return;
    state = _compute();
    _maybeAskPermission();
  }

  AppGateState _compute() {
    final bt = _bluetooth.status;
    final screen = switch (bt.adapter) {
      AdapterStatus.unknown => AppScreen.splash,
      AdapterStatus.unauthorized => AppScreen.permission,
      AdapterStatus.off || AdapterStatus.unavailable => AppScreen.bluetoothOff,
      AdapterStatus.on when bt.broadcastDenied => AppScreen.permission,
      AdapterStatus.on when _lights.connection.hasLight => AppScreen.control,
      AdapterStatus.on => AppScreen.search,
    };
    return AppGateState(
      screen,
      canTurnOnBluetooth: bt.canTurnOn,
      needsSettings: bt.adapter == AdapterStatus.unauthorized,
    );
  }

  /// A restored channel light needs the broadcast permission before
  /// anything reaches it, so ask as soon as Bluetooth is on.
  void _maybeAskPermission() {
    if (_askedPermission || !ref.mounted) return;
    if (_bluetooth.status.adapter != AdapterStatus.on || _lights.connection.light is! ChannelLight) return;
    _askedPermission = true;
    _bluetooth.ensureBroadcastPermission();
  }

  Future<void> turnOnBluetooth() => _bluetooth.turnOn();

  Future<void> allowPermission() async {
    if (await _bluetooth.ensureBroadcastPermission()) _lights.resume();
  }

  Future<void> openSettings() => _bluetooth.openAppSettings();
}
