import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers.dart';
import '../../../repositories/bluetooth_repository.dart';
import '../../../repositories/light_repository.dart';
import '../../../core/models/light_connection.dart';
import '../../../core/models/light_state.dart';
import '../../../core/models/paired_light.dart';

part 'search_view_model.freezed.dart';
part 'search_view_model.g.dart';

enum SearchStep { intro, blinking, sweeping, confirming, notFound }

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStep.intro) SearchStep step,

    /// 0-1 through the channel sweep.
    @Default(0) double progress,

    /// Which of [candidateCount] possible matches is being flashed.
    @Default(0) int candidate,
    @Default(0) int candidateCount,

    /// Lights that do show up in a Bluetooth scan.
    @Default([]) List<FoundLight> nearby,
    String? connectingId,
  }) = _SearchState;
}

/// Finds the light by making it react, since channel lights never show up
/// in a Bluetooth scan:
/// 1. blink the factory-default channel and ask the user to confirm;
/// 2. otherwise sweep every channel and group, turning the light red;
/// 3. narrow down by flashing the last few candidates one at a time.
@riverpod
class SearchViewModel extends _$SearchViewModel {
  static const blinkInterval = Duration(milliseconds: 600);
  static const sweepInterval = Duration(milliseconds: 400);
  static const flashInterval = Duration(milliseconds: 500);

  /// How many recent sweep steps could have caused the change, allowing
  /// for ~2.5 s of reaction time.
  static const reactionWindow = 7;

  static const _white = LightState(mode: LightMode.white, kelvin: 5600, brightness: 100);
  static const _off = LightState(on: false, brightness: 100);
  static const _red = LightState(mode: LightMode.color, hue: 0, saturation: 100, brightness: 100);
  static const _blue = LightState(mode: LightMode.color, hue: 230, saturation: 100, brightness: 100);

  /// Common channels first; groups A-F only after "all groups" everywhere.
  static final List<ChannelLight> sweepOrder = () {
    const likely = [100, 80, 50, 33, 15, 10, 6, 2, 1];
    final channels = {...likely, for (var c = 1; c <= channelCount; c++) c};
    return [
      for (final c in channels) ...[ChannelLight(c, allGroups), ChannelLight(c, 0)],
      for (final c in channels)
        for (var g = 1; g < groupCount; g++) ChannelLight(c, g),
    ]..remove(PairedLight.factoryDefault);
  }();

  late LightRepository _lights;
  late BluetoothRepository _bluetooth;
  Timer? _timer;
  int _tick = 0;
  int _sweepIndex = 0;
  List<ChannelLight> _candidates = const [];
  bool _paired = false;

  @override
  SearchState build() {
    _lights = ref.watch(lightRepositoryProvider);
    _bluetooth = ref.watch(bluetoothRepositoryProvider);
    final scan = _bluetooth.scanLights().listen(
      (found) => ref.mounted ? state = state.copyWith(nearby: found) : null,
      onError: (Object _) {},
    );
    ref.onDispose(() {
      _timer?.cancel();
      scan.cancel();
      if (!_paired) _lights.endProbe();
    });
    return const SearchState();
  }

  Future<void> search() async {
    if (!await _bluetooth.ensureBroadcastPermission()) return;
    _tick = 0;
    state = state.copyWith(step: SearchStep.blinking);
    _every(blinkInterval, () => _lights.probe(PairedLight.factoryDefault, (_tick++).isEven ? _white : _off));
  }

  Future<void> confirmBlinking() => _pair(PairedLight.factoryDefault);

  void rejectBlinking() => _sweep();

  void turnedRed() {
    final start = (_sweepIndex - reactionWindow).clamp(0, _sweepIndex);
    _candidates = sweepOrder.sublist(start, _sweepIndex).reversed.toList();
    if (_candidates.isEmpty) return;
    _flash(0);
  }

  Future<void> confirmCandidate() => _pair(_candidates[state.candidate]);

  void rejectCandidate() {
    final next = state.candidate + 1;
    next < _candidates.length ? _flash(next) : _sweep(); // carry on from where we stopped
  }

  void restart() {
    _timer?.cancel();
    _sweepIndex = 0;
    state = state.copyWith(step: SearchStep.intro, progress: 0);
  }

  Future<void> connectNearby(FoundLight light) async {
    _timer?.cancel();
    state = state.copyWith(connectingId: light.id);
    _paired = await _lights.connect(light);
    if (ref.mounted) state = state.copyWith(connectingId: null);
  }

  void _sweep() {
    state = state.copyWith(step: SearchStep.sweeping);
    _every(sweepInterval, () {
      if (_sweepIndex >= sweepOrder.length) {
        _timer?.cancel();
        _lights.endProbe();
        state = state.copyWith(step: SearchStep.notFound);
        return;
      }
      _lights.probe(sweepOrder[_sweepIndex++], _red);
      state = state.copyWith(progress: _sweepIndex / sweepOrder.length);
    });
  }

  void _flash(int index) {
    state = state.copyWith(step: SearchStep.confirming, candidate: index, candidateCount: _candidates.length);
    final target = _candidates[index];
    _tick = 0;
    _every(flashInterval, () => _lights.probe(target, (_tick++).isEven ? _blue : _red));
  }

  Future<void> _pair(ChannelLight light) async {
    _timer?.cancel();
    _paired = true;
    await _lights.pairChannel(light);
  }

  void _every(Duration interval, void Function() action) {
    _timer?.cancel();
    action();
    _timer = Timer.periodic(interval, (_) {
      if (ref.mounted) action();
    });
  }
}
