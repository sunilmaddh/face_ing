import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class SplashController extends BaseController {
  final AppPreferences _appPreferences = AppPreferences.instance;

  Future<void> checkUserStatus() async {
    final userId = _appPreferences.getUserId();
    if (userId.isNotEmpty) {
      final isOnboard = _appPreferences.getOnBoard();
      if (isOnboard == "true") {
        AppNavigation.off(AppRoutes.landingSceen);
      } else {
        AppNavigation.off(AppRoutes.createAccount);
      }
    } else {
      final isWalk = _appPreferences.getWalkScreen();
      if (isWalk == true) {
        AppNavigation.off(AppRoutes.loginScreen);
      } else {
        AppNavigation.off(AppRoutes.onboardScreen);
      }
    }
  }
}
