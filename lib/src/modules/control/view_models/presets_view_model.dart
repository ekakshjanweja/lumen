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

  const factory PresetsState({@Default([]) List<ColorPreset> saved}) = _PresetsState;

  /// Newest saved first, then the built-in ones.
  List<ColorPreset> get all => [...saved.reversed, ...builtInPresets];
}

/// The user's saved colours: listing, saving and deleting them.
@riverpod
class PresetsViewModel extends _$PresetsViewModel {
  late PresetRepository _presets;

  @override
  PresetsState build() {
    _presets = ref.watch(presetRepositoryProvider);
    final sub = _presets.changes.listen((saved) {
      if (ref.mounted) state = PresetsState(saved: saved);
    });
    ref.onDispose(sub.cancel);
    return PresetsState(saved: _presets.saved);
  }

  Future<ColorPreset> save(String name, {required int hue, required int saturation}) =>
      _presets.save(name: name, hue: hue, saturation: saturation);

  Future<void> delete(String id) => _presets.delete(id);
}
