import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/data/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/pulse/widget/pulse_page_data_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/pulse_rounded_button.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class PulseSurveyPageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final landingController = Get.find<LandingController>();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  RxList<Question> pages;
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
            child: Obx(() {
              final questions = pulseSurveyController.pulseQuestionList;
              return PageView.builder(
                controller: _pageController,
                itemCount: questions.length,
                onPageChanged: (index) {
                  _currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return PulsePageDataWidget(
                    id: q.questionId!,
                    question: q.pulseSurveyQuestion!,
                    text: q.pulseSurveyQuestionTitle!,
                    list: q.pulseSurveyAnswerOptions!,
                    pulseController: pulseSurveyController,
                  );
                },
              );
            }),
          ),

          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, currentIndex, child) {
                return Obx(
                  () => PulseRoundedButton(
                    isEnable: pulseSurveyController.isEnable.value,
                    onPressed: () {
                      if (currentIndex == pages.length - 1) {
                        pulseSurveyController.storePulseQuetionList();
                        landingController.onTabTapped(3);
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        pulseSurveyController.isEnable.value = false;
                      }
                    },
                    isSubmit: currentIndex == pages.length - 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
