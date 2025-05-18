import 'package:get/get.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class OnboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    String userId = StorageHelper.read("userId") ?? "";
    String isWalk = StorageHelper.read("isWalkThrough") ?? "";
    String isOnboard = StorageHelper.read("isOnboard") ?? "";
    Future.delayed(Duration(seconds: 2), () {
      if (isWalk != "isWalk") {
        AppNavigation.off(AppRoutes.onboardScreen);
      } else if (userId.isNotEmpty && isOnboard != "isOnboard") {
        AppNavigation.offAll(AppRoutes.createAccount);
      } else if (userId.isNotEmpty && isOnboard == "isOnboard") {
        AppNavigation.off(AppRoutes.homeScreen);
      } else {
        AppNavigation.off(AppRoutes.loginScreen);
      } // Replaces SplashScreen
    });
  }
}
