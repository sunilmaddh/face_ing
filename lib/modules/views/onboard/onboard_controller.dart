import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class OnboardController extends GetxController {
  final IndoSharedPreference _indoSharedPreference =
      IndoSharedPreference.instance;

  Future<void> checkUserStatus() async {
    final userId = await _indoSharedPreference.getUserId();
    AppSnackbar.show(title: "Message", message: userId);
    if (userId.isNotEmpty) {
      final isOnboard = await _indoSharedPreference.getOnBoard();
      if (isOnboard == "true") {
        AppNavigation.off(AppRoutes.homeScreen);
      } else {
        AppNavigation.off(AppRoutes.createAccount);
      }
    } else {
      final isWalk = await _indoSharedPreference.getWalkScreen();
      AppSnackbar.show(title: "Message", message: isWalk.toString());
      if (isWalk == true) {
        AppNavigation.off(AppRoutes.loginScreen);
      } else {
        AppNavigation.off(AppRoutes.onboardScreen);
      }
    }
  }
}
