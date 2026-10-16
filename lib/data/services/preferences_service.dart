import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/light_state.dart';
import '../../domain/models/paired_light.dart';
import 'protocol/frame_codec.dart';

/// Persists the paired light and its last state on the device.
/// Keys match earlier builds so existing pairings carry over.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _channel = 'light.channel';
  static const _group = 'light.group';
  static const _id = 'light.id';
  static const _name = 'light.name';
  static const _state = 'light.state';

  PairedLight? loadLight() {
    final ch = _prefs.getInt(_channel);
    if (ch != null) {
      final g = _prefs.getInt(_group) ?? allGroups;
      return ChannelLight(ch, g >= groupCount ? allGroups : g); // older builds saved "all" as 255
    }
    final id = _prefs.getString(_id);
    if (id != null) return ConnectedLight(id, _prefs.getString(_name) ?? 'Light');
    return null;
  }

  Future<void> saveLight(PairedLight? light) async {
    for (final k in [_channel, _group, _id, _name]) {
      await _prefs.remove(k);
    }
    switch (light) {
      case ChannelLight(:final channel, :final group):
        await _prefs.setInt(_channel, channel);
        await _prefs.setInt(_group, group);
      case ConnectedLight(:final id, :final name):
        await _prefs.setString(_id, id);
        await _prefs.setString(_name, name);
      case null:
        break;
    }
  }

  LightState? loadState() {
    final raw = _prefs.getString(_state);
    if (raw == null) return null;
    try {
      return FrameCodec.decode(raw.split(',').map(int.parse).toList());
    } on FormatException {
      return null;
    }
  }

  Future<void> saveState(LightState s) => _prefs.setString(_state, FrameCodec.encode(s).join(','));
}
