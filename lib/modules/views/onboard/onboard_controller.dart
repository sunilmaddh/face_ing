import 'package:get/get.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class OnboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    String userId = StorageHelper.read("userId") ?? "";
    bool isWalk = StorageHelper.read("isWalkThrough") ?? false;
    bool isOnboard = StorageHelper.read("isOnboard") ?? false;
    Future.delayed(Duration(seconds: 2), () {
      if (!isWalk) {
        AppNavigation.off(AppRoutes.onboardScreen);
      } else if (userId.isNotEmpty && !isOnboard) {
        AppNavigation.offAll(AppRoutes.createAccount);
      } else if (userId.isNotEmpty && isOnboard) {
        AppNavigation.off(AppRoutes.homeScreen);
      } else {
        AppNavigation.off(AppRoutes.loginScreen);
      } // Replaces SplashScreen
    });
  }
}
