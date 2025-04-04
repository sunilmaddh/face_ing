package com.example.ntt_data
import android.content.Intent
import android.util.Log
import com.example.ntt_data.measurement.AnuraExampleMeasurementActivity
import com.example.ntt_data.measurement.ExampleStartActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example/anura_sdk"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startAnura" -> {
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
    }

    private fun startAnura() {
        try {
            Log.d("AnuraSDK", "Anura SDK Started")
            val intent = Intent(this, ExampleStartActivity::class.java)
            startActivity(intent)
            // Initialize and start Anura SDK (replace with actual Anura SDK implementation)
            Log.d("AnuraSDK", "Anura SDK Started")
        } catch (e: Exception) {
            Log.e("AnuraSDK", "Error starting Anura SDK: ${e.message}")
        }
    }

    private fun stopAnura() {
        try {
            // Stop Anura SDK
            Log.d("AnuraSDK", "Anura SDK Stopped")
        } catch (e: Exception) {
            Log.e("AnuraSDK", "Error stopping Anura SDK: ${e.message}")
        }
    }
}
