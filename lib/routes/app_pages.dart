import 'package:get/route_manager.dart';
import 'package:ntt_data/modules/binah/view/mesurement_screen.dart';
import 'package:ntt_data/modules/auth/view/otp_forgot_screen.dart';
import 'package:ntt_data/modules/geust/view/add_new_geust_screen.dart';
import 'package:ntt_data/modules/geust/view/geust_user_history_screen.dart';
import 'package:ntt_data/modules/geust/view/guest_health_history_list.dart';
import 'package:ntt_data/modules/geust/view/guest_history_details.dart';
import 'package:ntt_data/modules/binah/view/all_report_screen.dart';
import 'package:ntt_data/modules/binah/view/analyzing_health_data.dart';
import 'package:ntt_data/modules/home/view/home_screen.dart';
import 'package:ntt_data/modules/landing/binding/landing_binding.dart';
import 'package:ntt_data/modules/landing/view/landing_screen.dart';
import 'package:ntt_data/modules/voice_agent/view/ai_session_call_screen.dart';
import 'package:ntt_data/modules/voice_agent/view/ai_session_screen.dart';
import 'package:ntt_data/modules/phq/view/phq_result_screen.dart';
import 'package:ntt_data/modules/auth/view/congratulation_screen.dart';
import 'package:ntt_data/modules/auth/view/create_account_screen.dart';
import 'package:ntt_data/modules/auth/view/login_screen.dart';
import 'package:ntt_data/modules/auth/view/health_menu_screen.dart';
import 'package:ntt_data/modules/auth/view/onboard/reset_password_screen.dart';
import 'package:ntt_data/modules/auth/view/onboard/onboard_screen.dart';
import 'package:ntt_data/modules/auth/view/onboard/splash_screen.dart';
import 'package:ntt_data/modules/profile/view/update_user_guest_details.dart';
import 'package:ntt_data/modules/profile/view/user_health_details.dart';
import 'package:ntt_data/modules/profile/view/user_history_data.dart';
import 'package:ntt_data/modules/profile/view/vital_descriptions.dart';
import 'package:ntt_data/modules/pulse/views/pulse_screen.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_analyzing_screen.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_progress_widget.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_screen.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_sucess_screen.dart';
import 'package:ntt_data/modules/vital_graph/binding/vital_graph_binding.dart';
import 'package:ntt_data/modules/vital_graph/view/vital_graph_history.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),

    GetPage(
      name: AppRoutes.createAccount,
      page: () => CreateAccountScreen(),
      // binding: AuthBinding(),
    ),

    GetPage(name: AppRoutes.healthMenu, page: () => HealthMenuScreen()),
    GetPage(
      name: AppRoutes.congratulationsScreen,
      page: () => CongratulationScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen()),
    GetPage(
      name: AppRoutes.landingSceen,
      page: () => LandingScreen(),
      binding: LandingBinding(),
    ),
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
    GetPage(
      name: AppRoutes.userHistoryList,
      page: () => UserHistoryData(),
      binding: VitalGraphBinding(),
    ),
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
    GetPage(
      name: AppRoutes.pulseProgressWidget,
      page: () => PulseSurveyProgressWidget(),
    ),
    GetPage(
      name: AppRoutes.pulseSurveyAnalyzingScreen,
      page: () => PulseSurveyAnalyzingScreen(),
    ),
    GetPage(
      name: AppRoutes.pulseSurveyScreen,
      page: () {
        final args = Get.arguments ?? {};
        return PulseSurveyScreen(fromBottomNav: args["fromBottomNav"] ?? true);
      },
    ),

    GetPage(
      name: AppRoutes.pulseScreen,
      page: () {
        final args = Get.arguments ?? {};
        return PulseScreen(fromHome: args["fromHome"] ?? false);
      },
    ),
    // GetPage(name: AppRoutes.voiceScreen, page: () => VoiceScreen()),
    GetPage(
      name: AppRoutes.pulseSuccess,
      page: () => PulseSurveySuccessScreen(),
    ),
    GetPage(name: AppRoutes.phqResultScreen, page: () => PhqResultScreen()),
    GetPage(name: AppRoutes.aiSessionScreen, page: () => AiSessionScreen()),
    GetPage(
      name: AppRoutes.aiSessionCallScreen,
      page: () => AiSessionCallScreen(),
    ),
  ];
}
