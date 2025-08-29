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
  static void show({
    required String title,
    required String message,
    bool isError = false,
  }) {
    // Close current snackbar if it's still open
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    // Delay snackbar show slightly to ensure the previous one is closed cleanly
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }
}
