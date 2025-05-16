import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/onboard/onboard_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _onboardController = Get.find<OnboardController>();
    return Scaffold(
      body: Center(
        child: CommonText.text("Face.ing", fontSize: AppDimensions.font(38)),
      ),
    );
  }
}
