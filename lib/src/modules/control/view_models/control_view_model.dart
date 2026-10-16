import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers.dart';
import '../../../repositories/light_repository.dart';
import '../../../core/models/light_connection.dart';
import '../../../core/models/light_state.dart';
import '../../../core/models/paired_light.dart';

part 'control_view_model.freezed.dart';
part 'control_view_model.g.dart';

@freezed
abstract class ControlState with _$ControlState {
  const ControlState._();

  const factory ControlState(LightState light, LightConnection connection) = _ControlState;

  String get name => switch (connection.light) {
    ConnectedLight(:final name) => name,
    _ => 'My light',
  };

  /// Channel lights cannot report a link status, so none is shown for them.
  bool get showsLinkStatus => connection.light is ConnectedLight;
  LinkStatus get status => connection.status;
}

/// Everything the control screen can do to the light.
@Riverpod(keepAlive: true)
class ControlViewModel extends _$ControlViewModel {
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
