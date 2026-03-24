import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/network_utils.dart';
import 'package:ntt_data/modules/views/auth/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _splashController = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      NetworkUtil.checkInternet(context);
      _splashController.checkUserStatus();
    });
    return Scaffold(body: Center(child: SvgPicture.asset(AppAssets.logo)));
  }
}
