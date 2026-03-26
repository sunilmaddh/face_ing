import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/modules/auth/widgets/custom_onboarding_screen.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});
  final List<dynamic> _pages = [
    {
      'image': AppAssets.onboard1,
      'title': 'Welcome',
      'description': 'Discover amazing features with our app.',
    },
    {
      'image': AppAssets.onboard1,
      'title': 'Easy to Use',
      'description': 'Navigate with ease and simplicity.',
    },
    {
      'image': AppAssets.onboard1,
      'title': 'Get Started',
      'description': 'Join us and explore endless possibilities!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: CustomOnboardingScreen(pages: _pages));
  }
}
