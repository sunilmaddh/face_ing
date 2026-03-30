import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_strings.dart'; // ✅ added
import 'package:ntt_data/modules/auth/widgets/custom_onboarding_screen.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});

  final List<Map<String, String>> _pages = [
    {
      'image': AppAssets.onboard1,
      'title': AppStrings.onboardWelcomeTitle,
      'description': AppStrings.onboardWelcomeDesc,
    },
    {
      'image': AppAssets.onboard1,
      'title': AppStrings.onboardEasyTitle,
      'description': AppStrings.onboardEasyDesc,
    },
    {
      'image': AppAssets.onboard1,
      'title': AppStrings.onboardStartTitle,
      'description': AppStrings.onboardStartDesc,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: CustomOnboardingScreen(pages: _pages));
  }
}
