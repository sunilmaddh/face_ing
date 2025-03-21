import 'package:get/get.dart';
import 'package:ntt_data/routes/app_routes.dart';

class OnboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Delay navigation to allow SplashScreen to appear briefly
    Future.delayed(Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.onboardScreen); // Replaces SplashScreen
    });
  }
}
