import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class OnboardController extends GetxController {
  final IndoSharedPreference _indoSharedPreference =
      IndoSharedPreference.instance;

  @override
  void onInit() {
    super.onInit();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    final userId = await _indoSharedPreference.getUserId();

    if (userId.isNotEmpty) {
      final isOnboard = await _indoSharedPreference.getOnBoard();
      if (isOnboard == "true") {
        AppNavigation.to(AppRoutes.homeScreen);
      } else {
        AppNavigation.to(AppRoutes.createAccount);
      }
    } else {
      final isWalk = await _indoSharedPreference.getWalkScreen();
      if (isWalk == true) {
        AppNavigation.to(AppRoutes.loginScreen);
      } else {
        AppNavigation.to(AppRoutes.onboardScreen);
      }
    }
  }
}
