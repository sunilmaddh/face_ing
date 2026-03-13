import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/bindings/app_bindings.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/data/repository/services/native_caller_services.dart';
import 'package:ntt_data/routes/app_pages.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  IndoSharedPreference.instance.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AppBindings().dependencies();
  // await requestMicPermission();
  NativeCaller().setupResultListener();

  //runApp(DevicePreview(builder: (context) => const MyApp()));
  runApp(const MyApp());
}

Future<bool> requestMicPermission() async {
  var status = await Permission.microphone.status;

  debugPrint("Permission microphone $status");

  if (status.isGranted) return true;

  status = await Permission.microphone.request();

  if (status.isGranted) return true;

  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }

  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstents.deviceSize,
      minTextAdapt: true,
      ensureScreenSize: true,
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Face.ing',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        initialRoute: AppRoutes.splashScreen,
        getPages: AppPages.getPages,
        routingCallback: (routing) {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
      ),
    );
  }
}
