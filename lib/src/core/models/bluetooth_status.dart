import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_status.freezed.dart';

enum AdapterStatus { unknown, unavailable, unauthorized, off, on }

/// Whether the phone can talk to lights right now.
@freezed
abstract class BluetoothStatus with _$BluetoothStatus {
  const factory BluetoothStatus({
    @Default(AdapterStatus.unknown) AdapterStatus adapter,

    /// The user declined the permission needed to broadcast to channel lights.
    @Default(false) bool broadcastDenied,

    /// Whether the app can switch Bluetooth on itself (Android only).
    @Default(false) bool canTurnOn,
  }) = _BluetoothStatus;
}
