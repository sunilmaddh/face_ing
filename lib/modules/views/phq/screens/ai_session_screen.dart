import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_controller.dart';
import 'phq_two_questions_screen.dart';
import '../widgets/action_button.dart';
import '../widgets/question_card.dart';

class AiSessionController extends GetxController {
  final isTalking = false.obs;
  final sessionTime = '00:00'.obs;

  final stopwatch = Stopwatch();
  Timer? timer;

  var time = "00:00".obs;

  void start() {
    stopwatch.start();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, '0');
      final seconds = (stopwatch.elapsed.inSeconds % 60).toString().padLeft(
        2,
        '0',
      );

      sessionTime.value = "$minutes:$seconds";
    });
  }

  void stop() {
    stopwatch.stop();
    timer?.cancel();
  }

  void reset() {
    stopwatch.reset();
    time.value = "00:00";
  }
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
  // final socketController = Get.find<SocketController>();
  final voiceController = Get.put(VoiceCallController());
  final socketController = Get.put(SocketController());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    voiceController.getCredentials();
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.stop();
    socketController.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'AI Session in Progress',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                const Text(
                  ' Secure Connection',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Obx(
                  () => QuestionCard(
                    question: '"${Get.find<VoiceCallController>().messageC}"',
                    speaker: 'Dr. Sarah Speaking',
                  ),
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
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
                                                ? 160 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 160,
                                        height:
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
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
                                        child: Image.asset(
                                          AppAssets.voiceagentimage,
                                        ),
                                        // child: const Icon(
                                        //   Icons.person,
                                        //   size: 60,
                                        //   color: Colors.white,
                                        // ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.sessionTime.value,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bottomTextColor,
                        ),
                      ),
                    ),
                    Text(
                      "Listening...",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.infoIconColor,
                      ),
                    ),
                  ],
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
                                      Get.find<VoiceCallController>()
                                          .messageC
                                          .isNotEmpty,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color:
                                      Get.find<VoiceCallController>()
                                              .messageC
                                              .isNotEmpty
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
                            onTap: () {
                              socketController.disconnect();

                              Get.to(() => const PhqTwoQuestionsScreen());
                              controller.sessionTime.value = "00:00";
                              controller.stop();
                            },
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
