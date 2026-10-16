import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/providers.dart';
import '../../../data/repositories/light_repository.dart';
import '../../../domain/models/light_connection.dart';
import '../../../domain/models/light_state.dart';
import '../../../domain/models/paired_light.dart';

@immutable
class ControlState {
  const ControlState(this.light, this.connection);

  final LightState light;
  final LightConnection connection;

  String get name => switch (connection.light) {
    ConnectedLight(:final name) => name,
    _ => 'My light',
  };

  /// Channel lights cannot report a link status, so none is shown for them.
  bool get showsLinkStatus => connection.light is ConnectedLight;
  LinkStatus get status => connection.status;

  @override
  bool operator ==(Object other) => other is ControlState && other.light == light && other.connection == connection;

  @override
  int get hashCode => Object.hash(light, connection);
}

/// Everything the control screen can do to the light.
class ControlViewModel extends Notifier<ControlState> {
  late LightRepository _lights;

  @override
  ControlState build() {
    _lights = ref.watch(lightRepositoryProvider);
    final subs = [_lights.stateChanges.listen((s) => _emit()), _lights.connectionChanges.listen((c) => _emit())];
    ref.onDispose(() {
      for (final s in subs) {
        s.cancel();
      }
    });
    return ControlState(_lights.state, _lights.connection);
  }

  void _emit() {
    if (ref.mounted) state = ControlState(_lights.state, _lights.connection);
  }

  void _apply(LightState Function(LightState s) change) {
    _lights.apply(change(_lights.state));
    _emit();
  }

  void togglePower() => _apply((s) => s.copyWith(on: !s.on));

  void setBrightness(int value) => _apply((s) => s.copyWith(brightness: value.clamp(1, 100), on: true));

  void setMode(LightMode mode) => _apply((s) => s.copyWith(mode: mode, on: true));

  void setKelvin(int kelvin) => _apply((s) => s.copyWith(kelvin: kelvin.clamp(minKelvin, maxKelvin), on: true));

  void setColor(int hue, int saturation) =>
      _apply((s) => s.copyWith(hue: hue % 360, saturation: saturation.clamp(0, 100), on: true));

  void selectEffect(int id) => _apply((s) => s.copyWith(effect: id, mode: LightMode.effect, on: true));

  /// Unpairs and returns to the search screen.
  Future<void> findLightAgain() => _lights.forget();
}

final controlViewModelProvider = NotifierProvider<ControlViewModel, ControlState>(ControlViewModel.new);
