import 'package:flutter/foundation.dart';

/// Number of channels a broadcast light can be set to (1-100).
const channelCount = 100;

/// Factory-default channel.
const defaultChannel = 100;

/// Groups A-F are 0-5. This value addresses every group at once.
const allGroups = 7;
const groupCount = 6;

/// The light the app controls.
sealed class PairedLight {
  const PairedLight();
}

/// A broadcast-only light. It never appears in a Bluetooth scan and follows
/// commands sent on its channel and group.
@immutable
final class ChannelLight extends PairedLight {
  const ChannelLight(this.channel, this.group);

  static const factoryDefault = ChannelLight(defaultChannel, allGroups);

  final int channel;
  final int group;

  @override
  bool operator ==(Object other) => other is ChannelLight && other.channel == channel && other.group == group;

  @override
  int get hashCode => Object.hash(channel, group);

  @override
  String toString() => 'ChannelLight($channel, $group)';
}

/// A light that advertises itself and is controlled over a GATT connection.
@immutable
final class ConnectedLight extends PairedLight {
  const ConnectedLight(this.id, this.name);

  final String id;
  final String name;

  @override
  bool operator ==(Object other) => other is ConnectedLight && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
