package dev.ekaksh.lumen

import android.Manifest
import android.bluetooth.BluetoothManager
import android.bluetooth.le.AdvertiseCallback
import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Broadcasts the light's control frame as manufacturer data (company 0xFFFF),
 * the same way the stock app's native "ibe" plugin does. Lights in channel
 * mode never connect; they just listen for this advert.
 */
class MainActivity : FlutterActivity() {
    private var advertising = false
    private var pendingPermission: MethodChannel.Result? = null

    private val callback = object : AdvertiseCallback() {}

    private val advertiser
        get() = (getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager)
            .adapter?.bluetoothLeAdvertiser

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "lumen/beacon").setMethodCallHandler { call, result ->
            when (call.method) {
                "ensurePermission" -> ensurePermission(result)
                "hasPermission" -> result.success(hasPermission())
                "start" -> start(call.arguments as ByteArray, result)
                "stop" -> { stop(); result.success(null) }
                "openAppSettings" -> {
                    startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.fromParts("package", packageName, null)))
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun hasPermission() = Build.VERSION.SDK_INT < Build.VERSION_CODES.S ||
        checkSelfPermission(Manifest.permission.BLUETOOTH_ADVERTISE) == PackageManager.PERMISSION_GRANTED

    private fun ensurePermission(result: MethodChannel.Result) {
        if (hasPermission()) return result.success(true)
        pendingPermission?.success(false)
        pendingPermission = result
        requestPermissions(arrayOf(Manifest.permission.BLUETOOTH_ADVERTISE), REQUEST_ADVERTISE)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != REQUEST_ADVERTISE) return
        pendingPermission?.success(grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED)
        pendingPermission = null
    }

    @Suppress("MissingPermission")
    private fun start(payload: ByteArray, result: MethodChannel.Result) {
        val adv = advertiser
        if (!hasPermission()) return result.error("permission", "Nearby devices permission denied", null)
        if (adv == null) return result.error("unavailable", "Bluetooth advertising is not available", null)
        if (advertising) adv.stopAdvertising(callback)
        val settings = AdvertiseSettings.Builder()
            .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
            .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH)
            .setConnectable(true)
            .setTimeout(0)
            .build()
        val data = AdvertiseData.Builder()
            .addManufacturerData(0xFFFF, payload)
            .setIncludeDeviceName(false)
            .setIncludeTxPowerLevel(false)
            .build()
        adv.startAdvertising(settings, data, callback)
        advertising = true
        result.success(null)
    }

    @Suppress("MissingPermission")
    private fun stop() {
        if (advertising && hasPermission()) advertiser?.stopAdvertising(callback)
        advertising = false
    }

    override fun onDestroy() {
        stop()
        super.onDestroy()
    }

    companion object {
        private const val REQUEST_ADVERTISE = 4107
    }
}
