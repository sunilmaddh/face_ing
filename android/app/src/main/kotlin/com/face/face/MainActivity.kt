package com.face.face



import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private lateinit var voiceBridgePlugin: VoiceBridgePlugin

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        voiceBridgePlugin = VoiceBridgePlugin(this)
        voiceBridgePlugin.register(flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy() {
        if (::voiceBridgePlugin.isInitialized) {
            voiceBridgePlugin.dispose()
        }
        super.onDestroy()
    }
}