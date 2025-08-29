// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AppSnackbar {
//   static void show({required String title, required String message, bool isError = false}) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? Colors.red : Colors.green,
//       colorText: Colors.white,
//       borderRadius: 10,
//       margin: const EdgeInsets.all(10),
//       duration: const Duration(seconds: 3),
//       icon: Icon(
//         isError ? Icons.error : Icons.check_circle,
//         color: Colors.white,
//       ),
//       shouldIconPulse: true,
//       animationDuration: const Duration(milliseconds: 500),
//       forwardAnimationCurve: Curves.easeOutBack,
//       reverseAnimationCurve: Curves.easeInBack,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static DateTime? _lastShownTime;
  static const int _debounceMs = 500; // Half a second debounce

  static void show({
    required String title,
    required String message,
    bool isError = false,
  }) {
    final now = DateTime.now();

    // Prevent multiple calls within debounce window
    if (_lastShownTime != null &&
        now.difference(_lastShownTime!).inMilliseconds < _debounceMs) {
      return;
    }
    _lastShownTime = now;

    // Close any existing snackbar
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    // Show snackbar
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }
}
