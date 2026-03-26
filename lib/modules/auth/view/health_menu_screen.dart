import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/auth/view/health_menu_page_view_builder.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class HealthMenuScreen extends StatelessWidget {
  HealthMenuScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: AppNavigation.back,
        title: AppConstents.createAccount,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: HealthMenuPageViewBuilder(
            pages: authController.medicalQuestionList,
            authController: authController,
          ),
        ),
      ),
    );
  }
}
