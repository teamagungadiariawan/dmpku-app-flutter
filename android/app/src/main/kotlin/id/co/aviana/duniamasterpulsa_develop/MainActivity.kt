package id.co.aviana.duniamasterpulsa_develop

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// Imports untuk Printer
import com.google.gson.JsonParser
import com.mazenrashed.printooth.Printooth
import com.mazenrashed.printooth.data.PairedPrinter
import com.mazenrashed.printooth.data.printable.Printable
import com.mazenrashed.printooth.data.printable.TextPrintable
import com.mazenrashed.printooth.data.printer.DefaultPrinter
import com.mazenrashed.printooth.ui.ScanningActivity
import com.mazenrashed.printooth.utilities.PrintingCallback
import java.util.ArrayList
import android.bluetooth.BluetoothAdapter // <--- Tambahkan ini
import android.bluetooth.BluetoothDevice // <--- Tambahkan ini

class MainActivity : FlutterActivity() {
    // Channel lama untuk Device Info
    private val CHANNEL_DEVICE = "id.co.aviana.duniamasterpulsa_develop/device"

    // Channel baru untuk Printer (Saya sesuaikan dengan nama package kamu biar rapi)
    private val CHANNEL_PRINT = "id.co.aviana.duniamasterpulsa_develop/print"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Init Printooth Library di sini
        Printooth.init(this)

        // Enable edge-to-edge (Kode lama kamu)
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            window.isNavigationBarContrastEnforced = false
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.setDecorFitsSystemWindows(false)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 1. Handler untuk Device Info (getAndroidId)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_DEVICE).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAndroidId" -> {
                    val androidId = getAndroidId()
                    result.success(androidId)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        // 2. Handler untuk Printer Logic
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_PRINT).setMethodCallHandler { call, result ->
            when (call.method) {
                "setPrinter" -> {
                    val printerName = call.argument<String>("printerName")
                    val printAddress = call.argument<String>("printAddress")
                    if (printerName != null && printAddress != null) {
                        setPrinter(printerName, printAddress, result)
                    } else {
                        result.error("INVALID_ARGS", "Printer name or address is null", null)
                    }
                }
                "choosePrinter" -> {
                    choosePrinter(result)
                }

                "getPairedDevices" -> {
                    getPairedDevices(result)
                }

                "printMessage" -> {
                    val message = call.argument<String>("message")
                    val printerName = call.argument<String>("printerName")
                    val printAddress = call.argument<String>("printAddress")

                    if (message != null && printerName != null && printAddress != null) {
                        printMessage(message, printerName, printAddress, result)
                    } else {
                        result.error("INVALID_ARGS", "Arguments cannot be null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    // --- Helper Device Info ---
    private fun getAndroidId(): String {
        return Settings.Secure.getString(
            contentResolver,
            Settings.Secure.ANDROID_ID
        )
    }

    // --- Helper Printer Logic ---
    private fun setPrinter(printerName: String, printAddress: String, result: MethodChannel.Result) {
        try {
            Printooth.setPrinter(printerName, printAddress)
            result.success("Printer set to $printerName at $printAddress")
        } catch (e: Exception) {
            result.error("SET_PRINTER_ERROR", e.message, null)
        }
    }

    private fun choosePrinter(result: MethodChannel.Result) {
        try {
            // Membuka Activity Scanning bawaan library Printooth
            val intent = Intent(this, ScanningActivity::class.java)
            startActivityForResult(intent, ScanningActivity.SCANNING_FOR_PRINTER)
            result.success("Scanning for printers started")
        } catch (e: Exception) {
            result.error("CHOOSE_PRINTER_ERROR", e.message, null)
        }
    }

    private fun printMessage(message: String, printerName: String, printAddress: String, result: MethodChannel.Result) {
        try {
            var printer1 = PairedPrinter(printerName, printAddress)

            Printooth.printer(printer1).printingCallback = object : PrintingCallback {
                override fun connectingWithPrinter() {}
                override fun printingOrderSentSuccessfully() {}
                override fun connectionFailed(error: String) {
                    println("Print Error Connection: $error")
                }
                override fun disconnected() {}
                override fun onError(error: String) {
                    println("Print Error: $error")
                }
                override fun onMessage(message: String) {}
            }

            var printables = ArrayList<Printable>()
            val jsonObj = JsonParser.parseString(message).asJsonObject

            if (jsonObj.has("data")) {
                val data = jsonObj.get("data").asJsonArray

                for (element in data) {
                    val el = element.asJsonObject
                    val text = if (el.has("text")) el.get("text").asString else ""

                    val align = if (el.has("align")) {
                        when (el.get("align").asString) {
                            "left" -> DefaultPrinter.ALIGNMENT_LEFT
                            "center" -> DefaultPrinter.ALIGNMENT_CENTER
                            "right" -> DefaultPrinter.ALIGNMENT_RIGHT
                            else -> DefaultPrinter.ALIGNMENT_LEFT
                        }
                    } else {
                        DefaultPrinter.ALIGNMENT_LEFT
                    }

                    val isToken = if (el.has("isToken")) el.get("isToken").asBoolean else false
                    val newLines = if (el.has("newLine")) el.get("newLine").asInt else 0

                    if (isToken) {
                        var printable = TextPrintable.Builder()
                            .setText(text)
                            .setAlignment(align)
                            .setNewLinesAfter(newLines)
                            .setFontSize(DefaultPrinter.FONT_SIZE_LARGE)
                            .build()
                        printables.add(printable)
                    } else {
                        var printable = TextPrintable.Builder()
                            .setText(text)
                            .setAlignment(align)
                            .setNewLinesAfter(newLines)
                            .build()
                        printables.add(printable)
                    }
                }

                Printooth.printer(printer1).print(printables)
                result.success("Printing message on $printerName")
            } else {
                result.error("PRINT_ERROR", "No data found in JSON message", null)
            }
        } catch (e: Exception) {
            result.error("PRINT_ERROR", e.message, null)
        }
    }

    // --- LOGIC MENGAMBIL PAIRED DEVICES (NATIVE ANDROID) ---
    private fun getPairedDevices(result: MethodChannel.Result) {
        try {
            val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()

            if (bluetoothAdapter == null) {
                result.error("NO_BLUETOOTH", "Device does not support Bluetooth", null)
                return
            }

            // Ambil list device yang sudah bonding (Paired) langsung dari Android
            // Menggunakan Set<BluetoothDevice>
            val pairedDevices: Set<BluetoothDevice> = bluetoothAdapter.bondedDevices

            val list = ArrayList<HashMap<String, String>>()

            if (pairedDevices.isNotEmpty()) {
                for (device in pairedDevices) {
                    val map = HashMap<String, String>()
                    // Ambil Nama dan Mac Address
                    map["name"] = device.name ?: "Unknown Device"
                    map["address"] = device.address ?: ""
                    list.add(map)
                }
            }

            // Kirim list balik ke Flutter
            result.success(list)
        } catch (e: SecurityException) {
            // Error ini muncul jika permission BLUETOOTH_CONNECT belum di-approve user
            result.error("PERMISSION_ERROR", "Need Bluetooth Connect Permission: ${e.message}", null)
        } catch (e: Exception) {
            result.error("GET_DEVICES_ERROR", e.message, null)
        }
    }
}