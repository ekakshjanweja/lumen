import 'package:flutter/foundation.dart';

enum AdapterStatus { unknown, unavailable, unauthorized, off, on }

/// Whether the phone can talk to lights right now.
@immutable
class BluetoothStatus {
  const BluetoothStatus({this.adapter = AdapterStatus.unknown, this.broadcastDenied = false, this.canTurnOn = false});

  final AdapterStatus adapter;

  /// The user declined the permission needed to broadcast to channel lights.
  final bool broadcastDenied;

  /// Whether the app can switch Bluetooth on itself (Android only).
  final bool canTurnOn;

  BluetoothStatus copyWith({AdapterStatus? adapter, bool? broadcastDenied}) => BluetoothStatus(
    adapter: adapter ?? this.adapter,
    broadcastDenied: broadcastDenied ?? this.broadcastDenied,
    canTurnOn: canTurnOn,
  );

  @override
  bool operator ==(Object other) =>
      other is BluetoothStatus &&
      other.adapter == adapter &&
      other.broadcastDenied == broadcastDenied &&
      other.canTurnOn == canTurnOn;

  @override
  int get hashCode => Object.hash(adapter, broadcastDenied, canTurnOn);
}
