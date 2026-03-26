import 'package:flutter/material.dart';
import 'package:ntt_data/modules/ai_recommendation/view/ai_advice_screen.dart';
import 'package:ntt_data/modules/home/view/home_screen.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_screen.dart';
import 'package:ntt_data/modules/voice_agent/view/ai_session_screen.dart';
import 'package:ntt_data/widgets/bar/custom_bottom_navigation_bar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomBottomNavigationBar(
        pageList: const [
          HomeScreen(),
          AiAdviceScreen(),
          _AiSessionTab(),
          PulseSurveyScreen(fromBottomNav: false),
        ],
      ),
    );
  }
}

class _AiSessionTab extends StatelessWidget {
  const _AiSessionTab();

  @override
  Widget build(BuildContext context) {
    return AiSessionScreen();
  }
}
