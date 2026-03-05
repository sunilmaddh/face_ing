import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'phq_two_questions_screen.dart';
import '../widgets/action_button.dart';
import '../widgets/question_card.dart';

class AiSessionController extends GetxController {
  final isTalking = false.obs;
  final sessionTime = '04:12'.obs;
}

class AiSessionScreen extends StatefulWidget {
  const AiSessionScreen({super.key});

  @override
  State<AiSessionScreen> createState() => _AiSessionScreenState();
}

class _AiSessionScreenState extends State<AiSessionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final controller = Get.put(AiSessionController());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            const Text(
              'AI Session in Progress',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              '1 Secure Connection',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                QuestionCard(
                  question:
                      '"How have you been\nmanaging your stress levels\nthis week?"',
                  speaker: 'Dr. Sarah Speaking',
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 360,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    final isTalking =
                                        controller.isTalking.value;
                                    return Container(
                                      width:
                                          isTalking
                                              ? 280 +
                                                  (_animationController.value *
                                                      40)
                                              : 280,
                                      height:
                                          isTalking
                                              ? 280 +
                                                  (_animationController.value *
                                                      40)
                                              : 280,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(
                                          0xFF2196F3,
                                        ).withOpacity(0.15),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: 10,
                                  child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      final isTalking =
                                          controller.isTalking.value;
                                      return Container(
                                        width:
                                            isTalking
                                                ? 200 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 200,
                                        height:
                                            isTalking
                                                ? 200 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFF2196F3,
                                          ).withOpacity(0.15),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 14,
                                  child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      final isTalking =
                                          controller.isTalking.value;
                                      return Container(
                                        width:
                                            isTalking
                                                ? 160 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 160,
                                        height:
                                            isTalking
                                                ? 160 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 160,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFF2196F3,
                                          ).withOpacity(0.25),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 15,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 4,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF2196F3),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.graphic_eq,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Text(
                    controller.sessionTime.value,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 10,
                  ),
                  child: Container(
                    height: 80,
                    // width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap:
                                  () =>
                                      controller.isTalking.value =
                                          !controller.isTalking.value,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color:
                                      controller.isTalking.value
                                          ? const Color(0xFFEF5350)
                                          : Colors.grey.withAlpha(40),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  controller.isTalking.value
                                      ? Icons.stop
                                      : Icons.mic_outlined,
                                  color: Colors.grey,
                                  size: 34,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          ActionButton(
                            icon: Icons.call_end,
                            color: Colors.red,
                            onTap:
                                () =>
                                    Get.to(() => const PhqTwoQuestionsScreen()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 150),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
