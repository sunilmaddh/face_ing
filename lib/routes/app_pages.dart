import 'package:get/route_manager.dart';
import 'package:ntt_data/modules/views/binah/mesurement_screen.dart';
import 'package:ntt_data/modules/views/auth/otp_forgot_screen.dart';
import 'package:ntt_data/modules/views/geust/add_new_geust_screen.dart';
import 'package:ntt_data/modules/views/geust/geust_user_history_screen.dart';
import 'package:ntt_data/modules/views/geust/guest_health_history_list.dart';
import 'package:ntt_data/modules/views/geust/guest_history_details.dart';
import 'package:ntt_data/modules/views/health_data/all_report_screen.dart';
import 'package:ntt_data/modules/views/health_data/analyzing_health_data.dart';
import 'package:ntt_data/modules/views/home/home_screen.dart';
import 'package:ntt_data/modules/views/profile/congratulation_screen.dart';
import 'package:ntt_data/modules/views/profile/create_account_screen.dart';
import 'package:ntt_data/modules/views/auth/login_screen.dart';
import 'package:ntt_data/modules/views/profile/health_menu_screen.dart';
import 'package:ntt_data/modules/views/auth/reset_password_screen.dart';
import 'package:ntt_data/modules/views/onboard/onboard_screen.dart';
import 'package:ntt_data/modules/views/onboard/splash_screen.dart';
import 'package:ntt_data/modules/views/profile/update_user_guest_details.dart';
import 'package:ntt_data/modules/views/profile/user_health_details.dart';
import 'package:ntt_data/modules/views/profile/user_history_data.dart';
import 'package:ntt_data/modules/views/profile/vital_descriptions.dart';
import 'package:ntt_data/modules/views/vital_graph/vital_graph_history.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),

    GetPage(name: AppRoutes.createAccount, page: () => CreateAccountScreen()),

    GetPage(name: AppRoutes.healthMenu, page: () => HealthMenuScreen()),
    GetPage(
      name: AppRoutes.congratulationsScreen,
      page: () => CongratulationScreen(),
    ),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen()),
    GetPage(name: AppRoutes.onboardScreen, page: () => OnboardScreen()),
    GetPage(
      name: AppRoutes.analyzingHealthData,
      page: () => AnalyzingHealthData(),
    ),
    GetPage(
      name: AppRoutes.geustUserHistory,
      page: () => GeustUserHistoryScreen(),
    ),
    // GetPage(name: AppRoutes.otpSignupScreen, page: () => OtpSignupScreen()),
    GetPage(name: AppRoutes.otpForgotScreen, page: () => OtpForgotScreen()),
    GetPage(
      name: AppRoutes.guestHistoryDetails,
      page: () => GuestHistoryDetails(),
    ),
    GetPage(name: AppRoutes.addNewGeustScreen, page: () => AddNewGuestScreen()),
    GetPage(name: AppRoutes.mesurementScreen, page: () => MeasurementScreen()),
    GetPage(name: AppRoutes.userHistoryList, page: () => UserHistoryData()),
    GetPage(name: AppRoutes.userHealthDatails, page: () => UserHealthDetails()),
    GetPage(name: AppRoutes.allReportScreen, page: () => AllReportScreen()),
    GetPage(
      name: AppRoutes.guestHealthHistoryList,
      page: () => GuestHealthHistoryList(),
    ),
    GetPage(
      name: AppRoutes.updateUserGuestDetails,
      page: () => UpdateUserGuestDetails(),
    ),
    GetPage(name: AppRoutes.vitalDescriptions, page: () => VitalDescriptions()),
    GetPage(name: AppRoutes.vitalGraphHistory, page: () => VitalGraphHistory()),
  ];
}
