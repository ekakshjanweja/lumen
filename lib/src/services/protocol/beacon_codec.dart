import '../../core/models/light_state.dart';
import '../../core/models/paired_light.dart';

/// The 23-byte broadcast that channel lights follow. It is shaped like an
/// iBeacon, so Android can send it as manufacturer data and iOS as a real
/// iBeacon. See PROTOCOL.md.
///
/// ```
/// 02 15 | FAA50000-1111-ABCD-0123-BE89 + channel (u32) | major | minor | power
/// major = group (bits 0-2) | effect << 3 | saturation << 8 | 0x8000 (colour mode)
/// minor = hue (colour mode) or kelvin/100 << 9 (white mode)
/// ```
abstract final class BeaconCodec {
  static List<int> encode(ChannelLight target, LightState s) {
    var major = target.group & 0x7;
    var minor = 0;
    switch (s.mode) {
      case LightMode.white:
        minor = (s.kelvin ~/ 100).clamp(0, 99) << 9;
      case LightMode.color:
        major += (s.saturation.clamp(0, 100) << 8) | 0x8000;
        minor = s.hue.clamp(0, 360);
      case LightMode.effect:
        major += s.effect.clamp(0, 24) << 3;
    }
    final power = s.on ? s.brightness.clamp(0, 100) : 0;
    final ch = target.channel.clamp(1, channelCount);
    return [
      0x02, 0x15, // iBeacon prefix
      0xFA, 0xA5, 0x00, 0x00, 0x11, 0x11, 0xAB, 0xCD, 0x01, 0x23, 0xBE, 0x89,
      (ch >> 24) & 0xff, (ch >> 16) & 0xff, (ch >> 8) & 0xff, ch & 0xff,
      (major >> 8) & 0xff, major & 0xff,
      (minor >> 8) & 0xff, minor & 0xff,
      power,
    ];
  }
}
