import 'package:freezed_annotation/freezed_annotation.dart';

part 'paired_light.freezed.dart';

/// Number of channels a broadcast light can be set to (1-100).
const channelCount = 100;

/// Factory-default channel.
const defaultChannel = 100;

/// Groups A-F are 0-5. This value addresses every group at once.
const allGroups = 7;
const groupCount = 6;

/// The light the app controls.
@freezed
sealed class PairedLight with _$PairedLight {
  /// A broadcast-only light. It never appears in a Bluetooth scan and follows
  /// commands sent on its channel and group.
  const factory PairedLight.channel(int channel, int group) = ChannelLight;

  /// A light that advertises itself and is controlled over a GATT connection.
  const factory PairedLight.connected(String id, String name) = ConnectedLight;

  /// Where a light is out of the box.
  static const factoryDefault = ChannelLight(defaultChannel, allGroups);
}
