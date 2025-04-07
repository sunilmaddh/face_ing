import 'package:flutter/services.dart';

class NativeCaller {
  static const MethodChannel _channel = MethodChannel("com.example/anura_sdk");

  /// Starts the native Anura face scan
  static Future<void> startFaceScan() async {
    try {
      await _channel.invokeMethod('startAnura');
    } on PlatformException catch (e) {
      // Log the error or handle it gracefully
      print("PlatformException in startFaceScan: ${e.message}");
    } catch (e) {
      // Fallback for any other exception
      print("Unexpected error in startFaceScan: $e");
    }
  }
}
