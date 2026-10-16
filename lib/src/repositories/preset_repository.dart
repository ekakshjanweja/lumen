import 'dart:async';

import '../core/models/color_preset.dart';
import '../services/preset_store.dart';

/// Source of truth for the user's saved colour presets.
class PresetRepository {
  PresetRepository({required PresetStore store}) : _store = store, _saved = store.load();

  final PresetStore _store;
  final _changes = StreamController<List<ColorPreset>>.broadcast();
  List<ColorPreset> _saved;

  /// Oldest first.
  List<ColorPreset> get saved => _saved;
  Stream<List<ColorPreset>> get changes => _changes.stream;

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

  Future<void> delete(String id) async {
    _emit([
      for (final p in _saved)
        if (p.id != id) p,
    ]);
    await _store.delete(id);
  }

  void _emit(List<ColorPreset> next) {
    _saved = List.unmodifiable(next);
    _changes.add(_saved);
  }

  void dispose() => _changes.close();
}
