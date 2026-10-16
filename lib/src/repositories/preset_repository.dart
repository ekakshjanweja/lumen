import 'dart:async';

import '../core/models/color_preset.dart';
import '../services/preset_store.dart';

/// Source of truth for colour presets: the user's saved ones, and which of
/// the built-in ones they've deleted.
class PresetRepository {
  PresetRepository({required PresetStore store}) : _store = store, _saved = store.load(), _hidden = store.loadHidden();

  final PresetStore _store;
  final _changes = StreamController<void>.broadcast();
  List<ColorPreset> _saved;
  Set<String> _hidden;

  /// Oldest first.
  List<ColorPreset> get saved => _saved;

  /// Built-in presets the user hasn't deleted, in their original order.
  List<ColorPreset> get builtIns => [
    for (final p in builtInPresets)
      if (!_hidden.contains(p.id)) p,
  ];

  /// Fires after [saved] or [builtIns] change.
  Stream<void> get changes => _changes.stream;

  Future<ColorPreset> save({required String name, required int hue, required int saturation}) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString().padLeft(20, '0');
    final trimmed = name.trim();
    final preset = ColorPreset(
      id: id,
      name: trimmed.isEmpty ? 'My color' : trimmed,
      hue: hue % 360,
      saturation: saturation.clamp(0, 100),
    );
    _emit([..._saved, preset]);
    await _store.put(preset);
    return preset;
  }

  /// Saved presets are removed for good; built-in ones are only hidden, so
  /// [restoreBuiltIns] can bring them back.
  Future<void> delete(ColorPreset preset) async {
    if (preset.builtIn) {
      _hidden = {..._hidden, preset.id};
      _changes.add(null);
      await _store.putHidden(_hidden);
    } else {
      _emit([
        for (final p in _saved)
          if (p.id != preset.id) p,
      ]);
      await _store.delete(preset.id);
    }
  }

  Future<void> restoreBuiltIns() async {
    _hidden = {};
    _changes.add(null);
    await _store.putHidden(_hidden);
  }

  void _emit(List<ColorPreset> next) {
    _saved = List.unmodifiable(next);
    _changes.add(null);
  }

  void dispose() => _changes.close();
}
