import 'package:flutter/services.dart';

class NativeCaller {
  static const MethodChannel _channel = MethodChannel("com.example/anura_sdk");

  // Function to call native code
  static Future<void> startFaceScan() async {
    try {
      await _channel.invokeMethod('startAnura');
    } on PlatformException catch (e) {
      // return "Failed to get message: '${e.message}'.";
    }
  }
}
