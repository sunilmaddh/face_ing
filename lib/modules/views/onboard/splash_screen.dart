import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/modules/views/onboard/onboard_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _onboardController = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    // Initialize the controller and trigger its logic
    Future.microtask(() => _onboardController.checkUserStatus());

    return Scaffold(body: Center(child: SvgPicture.asset(AppAssets.logo)));
  }
}
