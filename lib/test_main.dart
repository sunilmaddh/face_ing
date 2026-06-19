import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_config.dart';

void main() {
  runApp(MyApp());
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
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Face.ing',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.btntext),
        ),
        home: MyWidget(),

        routingCallback: (routing) {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: CallGraphWidget())));
  }
}

class CallGraphWidget extends StatelessWidget {
  const CallGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(width: double.infinity, height: 120, child: SizedBox()),
    );
  }
}
