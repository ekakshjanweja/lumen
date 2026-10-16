import 'package:flutter/foundation.dart';

import 'paired_light.dart';

enum LinkStatus { connecting, connected, reconnecting }

/// The paired light, if any, and whether commands can reach it.
@immutable
class LightConnection {
  const LightConnection(this.light, this.status);
  const LightConnection.none() : light = null, status = LinkStatus.connecting;

  final PairedLight? light;
  final LinkStatus status;

  bool get hasLight => light != null;

  @override
  bool operator ==(Object other) => other is LightConnection && other.light == light && other.status == status;

  @override
  int get hashCode => Object.hash(light, status);
}

/// A light found in a Bluetooth scan (only connectable lights show up).
@immutable
class FoundLight {
  const FoundLight(this.id, this.name, this.rssi);
  final String id;
  final String name;
  final int rssi;
}
