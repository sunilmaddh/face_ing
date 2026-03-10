import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/phq/controllers/phq_controller.dart';
import '../controllers/gad7_controller.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/phq_question_card.dart';
import 'phq_result_screen.dart';

class Gad7QuestionsScreen extends StatelessWidget {
  const Gad7QuestionsScreen({super.key});

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
          'GAD-7',
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
                                  controller.selectedG7Answers.length /
                                  controller.gad7Question.length,
                              backgroundColor: Colors.grey[200],
                              color: const Color(0xFF2196F3),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Obx(
                          () => Text(
                            '${controller.selectedG7Answers.length} of ${controller.gad7Question.length} questions',
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
                      controller.gad7Question.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Obx(
                          () => PhqQuestionCard(
                            questionNumber: index + 1,
                            question: controller.gad7Question[index],
                            selectedValue: controller.getPh7SelectedAnswer(
                              index,
                            ),
                            onOptionSelected: (value) {
                              controller.selectPh7Answer(index, value);
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
                    controller.allG7QuestionsAnswered
                        ? () async {
                          assessmentController.setGad7Answers(
                            controller.selectedG7Answers,
                          );
                          await assessmentController.submitAssessment(
                            sessionID:
                                Get.find<AssessmentController>()
                                    .sessionId
                                    .value,
                          );
                        }
                        : null,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color:
                        controller.allG7QuestionsAnswered
                            ? const Color(0xFF2196F3)
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
