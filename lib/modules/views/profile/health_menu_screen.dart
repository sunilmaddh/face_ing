import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/profile/widgets/profile_page_view_builder.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class HealthMenuScreen extends StatelessWidget {
  HealthMenuScreen({super.key});

  final _authController = Get.find<AuthController>();
  final List<dynamic> _pages = [
    {
      "id": 1,
      "text":
          "Do you have any existing health conditions that we should be aware of for accurate analysis?",
      "options": [
        "Diabetes",
        "Hypertension",
        "Asthma",
        "Other",
        "No, I'm Genereally Healthy",
      ],
    },
    {
      "id": 2,
      "text": "What is your primary health concern?",
      "options": [
        "Cardiovascular",
        "Weight management",
        "Mental health",
        "Sleep",
        "Other",
      ],
    },
    {
      "id": 3,
      "text": "Would you consider your lifestyle to be active?",
      "options": [
        "Very active",
        "Moderately active",
        "Somewhat active",
        "Not active",
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: AppConstents.createAccount,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ProfilePageViewBuilder(
          pages: _authController.medicalQuestionListModel.value,
          authController: _authController,
        ),
      ),
    );
  }
}
