import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/modules/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/pulse/views/pulse_survey_sucess_screen.dart';
import 'package:ntt_data/modules/pulse/widget/pulse_page_data_widget.dart';
import 'package:ntt_data/widgets/button/pulse_rounded_button.dart';
import 'package:ntt_data/widgets/face_progress_indicator.dart';

// ignore: must_be_immutable
class PulseSurveyPageViewBuilder extends StatelessWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final landingController = Get.find<LandingController>();
  RxList<Question> pages;
  final PulseSurveyController pulseSurveyController;

  PulseSurveyPageViewBuilder({
    super.key,
    required this.pages,
    required this.pulseSurveyController,
  });

  @override
  Widget build(BuildContext context) {
    /// 🔥 FIX: VERY IMPORTANT LINE
    pulseSurveyController.setPageController(_pageController);

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
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: questions.length,
                onPageChanged: (index) => _currentIndex.value = index,
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

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, index, child) {
                final bool isLast = index == pages.length - 1;
                final bool isFirst = index == 0;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 🔹 PREVIOUS
                    if (!isFirst)
                      PulseRoundedButton(
                        isPrevious: true,
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 450),
                            curve: Curves.ease,
                          );
                          pulseSurveyController.isEnable.value = true;
                        },
                      )
                    else
                      const SizedBox(width: 50),

                    /// 🔹 SAVE ONLY ON LAST INDEX
                    if (isLast)
                      Obx(
                        () => PulseRoundedButton(
                          isEnable: pulseSurveyController.isEnable.value,
                          isSubmit: true,
                          onPressed: () {
                            pulseSurveyController.storePulseQuetionList();
                            Get.off(() => const PulseSurveySuccessScreen());
                          },
                        ),
                      )
                    else if (isFirst)
                      Obx(
                        () => PulseRoundedButton(
                          isEnable: pulseSurveyController.isEnable.value,
                          isPrevious: false,
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      )
                    else
                      const SizedBox(width: 50),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
