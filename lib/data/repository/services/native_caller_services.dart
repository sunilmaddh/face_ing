import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class NativeCaller {
  final _profileController = Get.find<ProfileController>();
  static const MethodChannel _channel = MethodChannel("com.example/anura_sdk");
  static const MethodChannel _resultChannel = MethodChannel(
    'com.example.channel',
  );

  /// Starts the native Anura face scan
  static Future<void> startFaceScan(Map<String, dynamic> data) async {
    try {
      await _channel.invokeMethod('startAnura', data);
    } on PlatformException catch (e) {
      // Log the error or handle it gracefully
      print("PlatformException in startFaceScan: ${e.message}");
    } catch (e) {
      // Fallback for any other exception
      print("Unexpected error in startFaceScan: $e");
    }
  }

  void setupResultListener() {
    _resultChannel.setMethodCallHandler((call) async {
      if (call.method == 'navigateToResults') {
        try {
          final jsonString = call.arguments as String;
          debugPrint(" Received from native: $jsonString");
          // Decode JSON string into your Dart model
          final result = anlyzeHealthDataResponseModelFromJson(
            jsonString.toString(),
          );
          _profileController.anlyzeHealthDataResponseModel.value = result;
          // Log the raw JSON if needed
          debugPrint(
            " Received from native developer : ${_profileController.anlyzeHealthDataResponseModel}",
          );

          // You can now use `result` as a Dart object
          // Example:
          // print('Measurement ID: ${result.measurementID}');

          // Navigate to next screen
          AppNavigation.to(AppRoutes.analyzingHealthData);
        } catch (e) {
          debugPrint(" Error parsing JSON from native: $e");
        }
      } else {
        debugPrint(" Unknown method: ${call.method}");
      }

      // switch (call.method) {
      //   case 'navigateToResults':
      //     String resultData = call.arguments;
      //     // Navigate or update state with resultData
      //     print("Received from native: $resultData");
      //     AppNavigation.to(AppRoutes.analyzingHealthData);
      //     // Example: Navigate using GetX, etc.
      //     // Get.to(() => ResultsPage(data: resultData));
      //     break;
      //   default:
      //     print("Unknown method: ${call.method}");
      // }
    });
  }
}
