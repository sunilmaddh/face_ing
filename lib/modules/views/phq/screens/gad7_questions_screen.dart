import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/phq/controllers/phq_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
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
      floatingActionButton: Obx(
        () => GestureDetector(
          onTap:
              controller.allG7QuestionsAnswered
                  ? () async {
                    assessmentController.setGad7Answers(
                      controller.selectedG7Answers,
                    );
                    await assessmentController.submitAssessment(
                      sessionID:
                          Get.find<AssessmentController>().sessionId.value,
                    );
                    Get.off(() => PhqResultScreen())!.whenComplete(() {
                      Get.back();
                      Get.back();
                    });
                  }
                  : null,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color:
                  controller.allG7QuestionsAnswered
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
        title: "GAD-7",
        isCenterTitle: false,
        actions: [
          TextButton(
            onPressed: () async {
              // final result = await assessmentController.getResult();
              Get.off(() => PhqResultScreen())!.whenComplete(() {
                Get.back();
                Get.back();
              });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            '${controller.selectedG7Answers.length} of ${controller.gad7Question.length} questions',
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
                            controller.selectedG7Answers.length /
                            controller.gad7Question.length,
                        backgroundColor: Colors.grey[200],
                        color: AppColors.primary,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(width: 8),
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
        ],
      ),
    );
  }
}
