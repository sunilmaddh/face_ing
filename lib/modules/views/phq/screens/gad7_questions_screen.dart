import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gad7_controller.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/phq_question_card.dart';
import 'phq_result_screen.dart';

class Gad7QuestionsScreen extends StatelessWidget {
  const Gad7QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Gad7Controller());
    final assessmentController = Get.put(AssessmentController());

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
          style: TextStyle(color: Color(0xFF2196F3), fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
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
                                  controller.selectedAnswers.length /
                                  controller.assessment.questions.length,
                              backgroundColor: Colors.grey[200],
                              color: const Color(0xFF2196F3),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Obx(
                          () => Text(
                            '${controller.selectedAnswers.length} of ${controller.assessment.questions.length} questions',
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
                      controller.assessment.questions.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Obx(
                          () => PhqQuestionCard(
                            questionNumber: index + 1,
                            question: controller.assessment.questions[index],
                            selectedValue: controller.getSelectedAnswer(index),
                            onOptionSelected: (value) {
                              controller.selectAnswer(index, value);
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
                    controller.allQuestionsAnswered
                        ? () async {
                          assessmentController.setGad7Answers(
                            controller.selectedAnswers,
                          );
                          final success =
                              await assessmentController.submitAssessment();
                          if (success) {
                            final result = await assessmentController.getResult();
                            if (result != null) {
                              Get.to(() => PhqResultScreen(result: result));
                            }
                          }
                        }
                        : null,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color:
                        controller.allQuestionsAnswered
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
