import 'package:hive_ce/hive_ce.dart';

import '../core/models/color_preset.dart';

/// Saved colour presets in a Hive box: one map per preset, keyed by id.
/// Ids are creation timestamps, so sorting by id keeps the saved order.
/// One reserved entry lists the built-in presets the user has deleted.
class PresetStore {
  PresetStore(this._box);

  static const boxName = 'color_presets';
  static const _hiddenKey = '_hidden_builtins';

  final Box<Map> _box;

  List<ColorPreset> load() {
    final presets = [
      for (final MapEntry(:key, :value) in _box.toMap().entries)
        if (key != _hiddenKey) ?_decode(key.toString(), value),
    ];
    return presets..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<void> put(ColorPreset preset) =>
      _box.put(preset.id, {'name': preset.name, 'hue': preset.hue, 'saturation': preset.saturation});

  Future<void> delete(String id) => _box.delete(id);

  /// Ids of built-in presets the user deleted.
  Set<String> loadHidden() => {...?(_box.get(_hiddenKey)?['ids'] as List?)?.whereType<String>()};

  Future<void> putHidden(Set<String> ids) => _box.put(_hiddenKey, {'ids': ids.toList()});

  /// Skips entries that don't parse instead of failing the whole list.
  ColorPreset? _decode(String id, Map raw) {
    final (name, hue, saturation) = (raw['name'], raw['hue'], raw['saturation']);
    if (name is! String || hue is! int || saturation is! int) return null;
    return ColorPreset(id: id, name: name, hue: hue % 360, saturation: saturation.clamp(0, 100));
  }
}
