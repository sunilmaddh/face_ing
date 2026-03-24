import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/ai_recommendation/view/ai_advice_screen.dart';
import 'package:ntt_data/modules/views/landing/view/home/home_screen.dart';
import 'package:ntt_data/modules/views/phq/screens/ai_session_screen.dart';
import 'package:ntt_data/modules/views/landing/pulse/views/pulse_survey_screen.dart';
import 'package:ntt_data/widgets/bar/custom_bottom_navigation_bar.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return true = allow back
        // return false = block back
        return false;
      },
      child: CustomBottomNavigationBar(
        pageList: [
          HomeScreen(),
          AiAdviceScreen(),
          AiSessionScreen(),
          PulseSurveyScreen(fromBottomNav: false),
        ],
      ),
    );
  }
}
