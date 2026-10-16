import 'package:flutter/services.dart';

/// Native BLE broadcaster. Android sends the payload as manufacturer data
/// (MainActivity.kt); iOS sends it as an iBeacon (AppDelegate.swift).
class BeaconService {
  BeaconService([MethodChannel? channel]) : _channel = channel ?? const MethodChannel('lumen/beacon');

  final MethodChannel _channel;

  /// Prompts for the broadcast permission if needed. Returns whether it is granted.
  Future<bool> ensurePermission() async => await _channel.invokeMethod<bool>('ensurePermission') ?? false;

  /// Checks the permission without prompting.
  Future<bool> hasPermission() async => await _channel.invokeMethod<bool>('hasPermission') ?? false;

  /// Starts (or replaces) the broadcast with a 23-byte payload.
  Future<void> advertise(List<int> payload) => _channel.invokeMethod('start', Uint8List.fromList(payload));

  Future<void> stop() async {
    try {
      await _channel.invokeMethod('stop');
    } on PlatformException {
      // Nothing to stop.
    }
  }

  Future<void> openAppSettings() => _channel.invokeMethod('openAppSettings');
}
