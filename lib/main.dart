import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/bindings/app_bindings.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_pages.dart';

import 'package:ntt_data/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Required before anything native-related

  const MethodChannel('com.example.channel').setMethodCallHandler((call) async {
    if (call.method == 'navigateToResults') {
      final data = call.arguments;
      debugPrint("Data from native: $data");
      // Your route
      AppNavigation.to(AppRoutes.analyzingHealthData);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        initialBinding: AppBindings(),
        initialRoute: AppRoutes.splashScreen,
        getPages: AppPages.getPages,
      ),
    );
  }
}
