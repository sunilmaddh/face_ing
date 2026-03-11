import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_result_screen.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import '../controllers/phq_controller.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/phq_question_card.dart';
import 'phq9_questions_screen.dart';

class PhqTwoQuestionsScreen extends StatelessWidget {
  PhqTwoQuestionsScreen({super.key});
  final controller = Get.put(PhqController());
  final assessmentController = Get.find<AssessmentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => GestureDetector(
          onTap:
              controller.allPhTwoQuestionsAnswered
                  ? () {
                    assessmentController.setPhq2Answers(
                      controller.selectedPhTwoAnswers,
                    );
                    Get.to(() => const Phq9QuestionsScreen());
                  }
                  : null,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color:
                  controller.allPhTwoQuestionsAnswered
                      ? AppColors.primary
                      : Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "PHQ-2",
        isCenterTitle: false,
        actions: [
          TextButton(
            onPressed: () async {
              final result = await assessmentController.getResult();
              if (result != null) {
                Get.to(() => PhqResultScreen(result: result));
              }
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),

      //  AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Get.until((route) => route.isFirst),
      //   ),
      //   title: const Text(
      //     'PHQ-2',
      //     style: TextStyle(
      //       color: AppColors.primary,
      //       fontSize: 18,
      //       fontFamily: "Manrope",
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      //   actions: [

      //   ],
      // ),
      body: Obx(
        () =>
            controller.isLoading.isTrue
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Assessment Progress',
                                    style: TextStyle(
                                      fontSize: AppDimensions.font(14),
                                      color: Color(0xff334155),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Manrope",
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.selectedPhTwoAnswers.length} of ${controller.phqTwoQuestion.length} questions',
                                      style: TextStyle(
                                        fontSize: AppDimensions.font(14),
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Obx(
                                () => LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(10),
                                  value:
                                      controller.selectedPhTwoAnswers.length /
                                      controller.phqTwoQuestion.length,
                                  backgroundColor: Colors.grey[200],
                                  color: AppColors.primary,
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                            child: Obx(
                              () => Column(
                                children: List.generate(
                                  controller.phqTwoQuestion.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: PhqQuestionCard(
                                      questionNumber: index + 1,
                                      question:
                                          controller.phqTwoQuestion[index],
                                      selectedValue: controller
                                          .getPhTwoSelectedAnswer(index),
                                      onOptionSelected: (value) {
                                        controller.selectPhTwoAnswer(
                                          index,
                                          value,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 100,
                    //   right: 16,
                    //   child: Obx(
                    //     () => GestureDetector(
                    //       onTap:
                    //           controller.allPhTwoQuestionsAnswered
                    //               ? () {
                    //                 assessmentController.setPhq2Answers(
                    //                   controller.selectedPhTwoAnswers,
                    //                 );
                    //                 Get.to(() => const Phq9QuestionsScreen());
                    //               }
                    //               : null,
                    //       child: Container(
                    //         width: 56,
                    //         height: 56,
                    //         decoration: BoxDecoration(
                    //           color:
                    //               controller.allPhTwoQuestionsAnswered
                    //                   ? AppColors.primary
                    //                   : Colors.grey,
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: const Icon(
                    //           Icons.arrow_forward,
                    //           color: Colors.white,
                    //           size: 24,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
      ),
    );
  }
}
