import 'package:get/get.dart';

class AppNavigation {
  /// Navigate to a screen with a name
  static void to(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  /// Replace the current screen with a new one
  static void off(String route, {dynamic arguments}) {
    Get.offNamed(route, arguments: arguments);
  }

  /// Remove all previous screens and navigate to a new one
  static void offAll(String route, {dynamic arguments}) {
    Get.offAllNamed(route, arguments: arguments);
  }

  /// Navigate back to the previous screen
  static void back() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    }
  }

  // /// Navigate to the login screen
  // static void goToLogin() {
  //   Get.offAllNamed(AppRoutes.login);
  // }

  // /// Navigate to the home screen
  // static void goToHome() {
  //   Get.offAllNamed(AppRoutes.home);
  // }

  // /// Navigate to profile with optional arguments
  // static void goToProfile({int? userId}) {
  //   Get.toNamed(AppRoutes.profile, arguments: {"userId": userId});
  // }
}
