import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'phq_two_questions_screen.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '"How have you been\nmanaging your stress levels\nthis week?"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap button and speak',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 40),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final isTalking = controller.isTalking.value;
                          return Container(
                            width:
                                isTalking
                                    ? 180 + (_animationController.value * 40)
                                    : 180,
                            height:
                                isTalking
                                    ? 180 + (_animationController.value * 40)
                                    : 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(
                                0xFF2196F3,
                              ).withOpacity(isTalking ? 0.1 : 0.2),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
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
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => Text(
                      controller.sessionTime.value,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                                    : const Color(0xFF2196F3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.isTalking.value ? Icons.stop : Icons.mic,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    _buildActionButton(
                      icon: Icons.call_end,
                      color: const Color(0xFFEF5350),
                      onTap: () => Get.to(() => const PhqTwoQuestionsScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    Color color = const Color(0xFFBDBDBD),
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
