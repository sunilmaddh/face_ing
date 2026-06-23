import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/bindings/app_bindings.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_config.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/routes/app_pages.dart';
import 'package:ntt_data/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.instance.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConfig.deviceSize,
      minTextAdapt: true,
      ensureScreenSize: true,
      child: GetMaterialApp(
        navigatorKey: Get.key,
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        initialRoute: AppRoutes.splashScreen,
        getPages: AppPages.getPages,
        builder: (context, child) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child ?? const SizedBox.shrink(),
          );
        },
        routingCallback: (routing) {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
      ),
    );
  }
}
