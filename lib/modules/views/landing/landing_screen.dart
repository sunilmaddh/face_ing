import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/ai/view/ai_advice_screen.dart';
import 'package:ntt_data/modules/views/auth/maintence_screen.dart';
import 'package:ntt_data/modules/views/home/home_screen.dart';
import 'package:ntt_data/modules/views/pulse/views/pulse_survey_screen.dart';
import 'package:ntt_data/widgets/bar/custom_bottom_navigation_bar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      pageList: [
        HomeScreen(),
        const AiAdviceScreen(),
        const MaintenceScreen(),
        PulseSurveyScreen(fromBottomNav: false),
      ],
    );
  }
}
