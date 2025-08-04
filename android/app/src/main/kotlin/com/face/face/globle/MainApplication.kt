package com.face.face.globle
import android.app.Application
import android.content.Intent
import android.util.Log
import com.face.face.measurement.FaceAnuraMeasurementActivity.Companion.TAG
import com.face.face.measurement.FaceStartActivity
import com.google.gson.Gson
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlin.collections.get

class MainApplication : Application() {

    private val CHANNEL_ANURA = "com.face/anura_sdk"
    private val CHANNEL_RESULT = "com.face.channel"

    lateinit var flutterEngine: FlutterEngine


    override fun onCreate() {
        super.onCreate()

        // Step 1: Create engine
        flutterEngine = FlutterEngine(this)

        // Step 2: Register Flutter plugins
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Step 3: Register method channel for Flutter → Native (Anura)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ANURA)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startAnura" -> {
                        val data = call.arguments as? Map<*, *>
                        Log.d(TAG, "Data from flutter: ${data}")
                        if (data != null) {
                            GlobalData.guestName = data["name"].toString()
                            GlobalData.userId = data["userId"].toString()
                            GlobalData.gender = data["gender"].toString()
                            GlobalData.dob = data["dob"].toString()
                            GlobalData.weight = data["weight"].toString()
                            GlobalData.guestHeight = data["height"].toString()
                            GlobalData.emailId = data["emailId"].toString()
                            GlobalData.token = data["token"].toString()
                            GlobalData.scanType = data["scanType"].toString()
                        }

                        Log.d(TAG, "Data from flutter: $data ${GlobalData.dob}")
                        startAnura()
                        result.success("Anura SDK Started")
                    }
                    "stopAnura" -> {
                        stopAnura()
                        result.success("Anura SDK Stopped")
                    }
                    else -> result.notImplemented()
                }
            }

        // Step 4: Cache engine
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    }

    // This will be used from Native to send data to Flutter
    fun sendResultsToFlutter(results: String) {
        Log.d("jsonString Sunil", results.toString())
          val gson = Gson()
           val jsonString = gson.toJson(results)
        Log.d("jsonString Sunil", jsonString)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_RESULT)
            .invokeMethod("navigateToResults", jsonString)
    }

    private fun startAnura() {
        try {
            Log.d("AnuraSDK", "Anura SDK Started")
            val intent = Intent(this, FaceStartActivity()::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            // Initialize and start Anura SDK (replace with actual Anura SDK implementation)
            Log.d("AnuraSDK", "Anura SDK Started")
        } catch (e: Exception) {
            Log.e("AnuraSDK", "Error starting Anura SDK: ${e.message}")
        }
    }

    private fun stopAnura() {
        // TODO: Implement stop logic
    }
}
