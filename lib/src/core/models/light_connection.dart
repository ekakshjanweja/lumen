import 'package:freezed_annotation/freezed_annotation.dart';

import 'paired_light.dart';

part 'light_connection.freezed.dart';

enum LinkStatus { connecting, connected, reconnecting }

/// The paired light, if any, and whether commands can reach it.
@freezed
abstract class LightConnection with _$LightConnection {
  const LightConnection._();

  const factory LightConnection(PairedLight? light, LinkStatus status) = _LightConnection;

  /// Nothing paired yet.
  static const none = LightConnection(null, LinkStatus.connecting);

  bool get hasLight => light != null;
}

/// A light found in a Bluetooth scan (only connectable lights show up).
@freezed
abstract class FoundLight with _$FoundLight {
  const factory FoundLight(String id, String name, int rssi) = _FoundLight;
}
