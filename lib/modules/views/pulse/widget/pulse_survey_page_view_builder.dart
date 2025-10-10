import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_page_data_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class PulseSurveyPageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  List<dynamic> pages;
  final PulseSurveyController pulseSurveyController;

  PulseSurveyPageViewBuilder({
    super.key,
    required this.pages,
    required this.pulseSurveyController,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FaceProgressIndicator(
            pages: pages,
            valueCurrentIndex: _currentIndex,
            isLarge: true,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                _currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                return PulsePageDataWidget(
                  id: pages[index]["id"],
                  question: pages[index]["question"],
                  text: pages[index]["question"],
                  list: pages[index]["option_list"],
                  pulseController: pulseSurveyController,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, currentIndex, child) {
                return RoundedButton(
                  isAppBar: false,
                  onPressed: () {
                    if (currentIndex == pages.length - 1) {
                      AppNavigation.to(AppRoutes.pulseSurveyAnalyzingScreen);
                      // var data = AppMethods.getstoreQuestionAnswer();
                      // debugPrint(authController.dataList.toString());
                      // authController.profileCreation();
                      // AppNavigation.to(AppRoutes.congratulationsScreen);
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
