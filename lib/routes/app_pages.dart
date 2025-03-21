import 'package:get/route_manager.dart';
import 'package:ntt_data/modules/views/auth/widgets/otp_field_widget.dart';
import 'package:ntt_data/modules/views/health_data/analyzing_health_data.dart';
import 'package:ntt_data/modules/views/home/home_screen.dart';
import 'package:ntt_data/modules/views/profile/add_new_geust_screen.dart';
import 'package:ntt_data/modules/views/profile/congratulation_screen.dart';
import 'package:ntt_data/modules/views/profile/create_account_screen.dart';
import 'package:ntt_data/modules/views/auth/login_screen.dart';
import 'package:ntt_data/modules/views/profile/geust_user_history_screen.dart';
import 'package:ntt_data/modules/views/profile/health_menu_screen.dart';
import 'package:ntt_data/modules/views/profile/profile_upload_screen.dart';
import 'package:ntt_data/modules/views/auth/reset_password_screen.dart';
import 'package:ntt_data/modules/views/auth/singup_screen.dart';
import 'package:ntt_data/modules/views/home/scanning_screen.dart';
import 'package:ntt_data/modules/views/onboard/onboard_screen.dart';
import 'package:ntt_data/modules/views/onboard/splash_screen.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AppPages {

 static List<GetPage> getPages=[
    // GetPage(name: name, page: page)
    GetPage(name: AppRoutes.splashScreen, page: ()=>SplashScreen()),
    GetPage(name: AppRoutes.singnUp, page: ()=>SignupScreen()),
    GetPage(name: AppRoutes.createAccount, page: ()=>CreateAccountScreen()),
    GetPage(name: AppRoutes.profileUpload, page: ()=>ProfileUploadScreen()),
    GetPage(name: AppRoutes.healthMenu, page: ()=>HealthMenuScreen()),
     GetPage(name: AppRoutes.scanScreen, page: ()=>ScanningScreen()),
    GetPage(name: AppRoutes.congratulationsScreen, page: ()=>CongratulationScreen()),
    GetPage(name: AppRoutes.loginScreen, page: ()=>LoginScreen()),
    GetPage(name: AppRoutes.homeScreen, page: ()=>HomeScreen()),
    GetPage(name: AppRoutes.resetPassword, page: ()=>ResetPasswordScreen()),
    GetPage(name: AppRoutes.onboardScreen, page: ()=>OnboardScreen()),
    GetPage(name: AppRoutes.analyzingHealthData, page: ()=>AnalyzingHealthData()),
     GetPage(name: AppRoutes.geustUserHistory, page: ()=>GeustUserHistoryScreen()),
     GetPage(name: AppRoutes.otpFieldWidget, page: ()=>OtpFieldWidget()),
      GetPage(name: AppRoutes.addNewGeustScreen, page: ()=>AddNewGuestScreen()),
    GetPage(name: AppRoutes.scanScreen, page: ()=>ScanningScreen())
  ];
}