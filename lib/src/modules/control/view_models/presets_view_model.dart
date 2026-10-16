import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/color_preset.dart';
import '../../../core/providers.dart';
import '../../../repositories/preset_repository.dart';

part 'presets_view_model.freezed.dart';
part 'presets_view_model.g.dart';

@freezed
abstract class PresetsState with _$PresetsState {
  const PresetsState._();

  const factory PresetsState({
    @Default([]) List<ColorPreset> saved,
    @Default(builtInPresets) List<ColorPreset> builtIns,
  }) = _PresetsState;

  /// Newest saved first, then the built-in ones.
  List<ColorPreset> get all => [...saved.reversed, ...builtIns];

  /// Some built-in presets were deleted and can be brought back.
  bool get canRestore => builtIns.length < builtInPresets.length;
}

/// Colour presets: listing, saving and deleting them.
@riverpod
class PresetsViewModel extends _$PresetsViewModel {
  late PresetRepository _presets;

  @override
  PresetsState build() {
    _presets = ref.watch(presetRepositoryProvider);
    final sub = _presets.changes.listen((_) {
      if (ref.mounted) state = _read();
    });
    ref.onDispose(sub.cancel);
    return _read();
  }

  Future<ColorPreset> save(String name, {required int hue, required int saturation}) =>
      _presets.save(name: name, hue: hue, saturation: saturation);

  Future<void> delete(ColorPreset preset) => _presets.delete(preset);

  Future<void> restoreBuiltIns() => _presets.restoreBuiltIns();

  PresetsState _read() => PresetsState(saved: _presets.saved, builtIns: _presets.builtIns);
}
