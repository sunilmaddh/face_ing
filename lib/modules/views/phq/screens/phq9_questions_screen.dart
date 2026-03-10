import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/phq/controllers/phq_controller.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_result_screen.dart';
import '../controllers/phq9_controller.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/phq_question_card.dart';
import 'gad7_questions_screen.dart';

class Phq9QuestionsScreen extends StatelessWidget {
  const Phq9QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhqController>();
    final assessmentController = Get.find<AssessmentController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'PHQ-9',
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
      body: Stack(
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
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Obx(
                            () => LinearProgressIndicator(
                              value:
                                  controller.selectedPh9Answers.length /
                                  controller.phq9Question.length,
                              backgroundColor: Colors.grey[200],
                              color: const Color(0xFF2196F3),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Obx(
                          () => Text(
                            '${controller.selectedPh9Answers.length} of ${controller.phq9Question.length} questions',
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
                  child: Column(
                    children: List.generate(
                      controller.phq9Question.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Obx(
                          () => PhqQuestionCard(
                            questionNumber: index + 1,
                            question: controller.phq9Question[index],
                            selectedValue: controller.getPh9SelectedAnswer(
                              index,
                            ),
                            onOptionSelected: (value) {
                              controller.selectPh9Answer(index, value);
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
            bottom: 16,
            right: 16,
            child: Obx(
              () => GestureDetector(
                onTap:
                    controller.allPh9QuestionsAnswered
                        ? () {
                          assessmentController.setPhq9Answers(
                            controller.selectedPh9Answers,
                          );
                          Get.to(() => const Gad7QuestionsScreen());
                        }
                        : null,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color:
                        controller.allPh9QuestionsAnswered
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
    );
  }
}
