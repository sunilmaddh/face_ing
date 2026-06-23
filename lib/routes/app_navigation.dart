import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppNavigation {
  /// Navigate to a screen with a name
  static void to(String route, {VoidCallback? action, dynamic arguments}) {
    final future = Get.toNamed(route, arguments: arguments);
    if (action != null) {
      future?.whenComplete(action);
    }
  }

  /// Replace the current screen with a new one
  static void off(String route, {VoidCallback? action, dynamic arguments}) {
    final future = Get.offNamed(route, arguments: arguments);
    if (action != null) {
      future?.whenComplete(action);
    }
  }

  /// Remove all previous screens and navigate to a new one
  static void offAll(String route, {VoidCallback? action, dynamic arguments}) {
    final future = Get.offAllNamed(route, arguments: arguments);
    if (action != null) {
      future?.whenComplete(action);
    }
  }

  /// Navigate back to the previous screen
  static void back() {
    if (Get.previousRoute.isNotEmpty) {
      AppNavigation.back();
    }
  }
}
