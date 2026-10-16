import CoreBluetooth
import CoreLocation
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "BeaconPlugin") {
      BeaconPlugin.register(with: registrar)
    }
  }
}

/// Broadcasts the light's control frame (channel "lumen/beacon").
///
/// iOS does not let apps advertise arbitrary manufacturer data, but the frame
/// is shaped like an iBeacon (`02 15 <uuid> <major> <minor> <power>`), so it
/// goes out as a real one. The stock iOS app controls these lights the same way.
final class BeaconPlugin: NSObject, FlutterPlugin, CBPeripheralManagerDelegate {
  private var manager: CBPeripheralManager?
  private var pending: [String: Any]?
  private var permissionWaiters: [FlutterResult] = []

  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lumen/beacon", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(BeaconPlugin(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "ensurePermission":
      ensurePermission(result)
    case "hasPermission":
      result(CBManager.authorization == .allowedAlways)
    case "start":
      guard let data = (call.arguments as? FlutterStandardTypedData)?.data, data.count == 23 else {
        result(FlutterError(code: "payload", message: "Expected a 23-byte payload", details: nil))
        return
      }
      start([UInt8](data), result)
    case "stop":
      pending = nil
      manager?.stopAdvertising()
      result(nil)
    case "openAppSettings":
      if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
      }
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// Creating the manager is what shows the Bluetooth permission prompt.
  private func peripheral() -> CBPeripheralManager {
    if let manager { return manager }
    let created = CBPeripheralManager(delegate: self, queue: nil)
    manager = created
    return created
  }

  private func ensurePermission(_ result: @escaping FlutterResult) {
    switch CBManager.authorization {
    case .allowedAlways:
      result(true)
    case .notDetermined:
      permissionWaiters.append(result)
      _ = peripheral()
    default:
      result(false)
    }
  }

  private func start(_ b: [UInt8], _ result: @escaping FlutterResult) {
    guard CBManager.authorization == .allowedAlways else {
      result(FlutterError(code: "permission", message: "Bluetooth permission denied", details: nil))
      return
    }
    let uuid = Array(b[2..<18]).withUnsafeBufferPointer { NSUUID(uuidBytes: $0.baseAddress!) as UUID }
    let major = CLBeaconMajorValue(b[18]) << 8 | CLBeaconMajorValue(b[19])
    let minor = CLBeaconMinorValue(b[20]) << 8 | CLBeaconMinorValue(b[21])
    let power = NSNumber(value: Int8(bitPattern: b[22]))
    let region = CLBeaconRegion(uuid: uuid, major: major, minor: minor, identifier: "lumen")
    let advert = region.peripheralData(withMeasuredPower: power) as? [String: Any]

    let manager = peripheral()
    if manager.state == .poweredOn {
      manager.stopAdvertising()
      manager.startAdvertising(advert)
    } else {
      pending = advert // sent once Bluetooth is ready
    }
    result(nil)
  }

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    if CBManager.authorization != .notDetermined {
      let allowed = CBManager.authorization == .allowedAlways
      permissionWaiters.forEach { $0(allowed) }
      permissionWaiters.removeAll()
    }
    if peripheral.state == .poweredOn, let advert = pending {
      pending = nil
      peripheral.startAdvertising(advert)
    }
  }
}
