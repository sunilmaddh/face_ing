import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_result_screen.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.until((route) => route.isFirst),
        ),
        title: const Text(
          'PHQ-2',
          style: TextStyle(color: AppColors.primary, fontSize: 18),
        ),
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
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
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
                              const Text(
                                'Assessment Progress',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => LinearProgressIndicator(
                                        value:
                                            controller
                                                .selectedPhTwoAnswers
                                                .length /
                                            controller.phqTwoQuestion.length,
                                        backgroundColor: Colors.grey[200],
                                        color: AppColors.primary,
                                        minHeight: 6,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Obx(
                                    () => Text(
                                      '${controller.selectedPhTwoAnswers.length} of ${controller.phqTwoQuestion.length} questions',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF2196F3),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                    Positioned(
                      bottom: 100,
                      right: 16,
                      child: Obx(
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
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
