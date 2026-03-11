import 'dart:async';

import 'package:awesome_datetime_picker/awesome_datetime_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_call_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'phq_two_questions_screen.dart';
import '../widgets/action_button.dart';
import '../widgets/question_card.dart';

class AiSessionController extends GetxController {
  final voiceCallCOntroller = Get.put(VoiceCallController());
  final isTalking = false.obs;
  final sessionTime = '00:00'.obs;
  RxBool isTimeOver = false.obs;
  RxBool isFirstTimeToConnect = false.obs;

  final stopwatch = Stopwatch();
  Timer? timer;

  var time = "00:00".obs;

  Future<void> start() async {
    isTimeOver.value = false;
    _endingStarted = false;
    Get.find<SocketController>().isSessionEnding = false;
    // if (voiceCallCOntroller.messageC.isNotEmpty) {
    //   stopwatch.start();
    // }
    stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      final elapsedSeconds = stopwatch.elapsed.inSeconds;

      final minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, '0');
      final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
      sessionTime.value = "$minutes:$seconds";

      // if (elapsedSeconds >= 180) {
      //   // final message = {
      //   //   "type": "call_ended",
      //   //   "stream_sid": Get.find<VoiceCallController>().streamId.value,
      //   // };
      //   // debugPrint("Message $message");
      //   // await Get.find<SocketController>().sendMessage(message);
      //   // voiceCallCOntroller.messageC.value = AppConstents.voiceAgentEndMessage;
      //   await endSessionGracefully();

      //   // cancelCall();
      // }
    });
  }

  // Future<void> cancelCall() async {
  //   Get.find<SocketController>().disconnect();
  //   stop();
  //   Get.find<VoiceCallController>().messageC.value =
  //       AppConstents.voiceAgentEndMessage;
  //   playVoiceAgent();
  // }
  bool _endingStarted = false;

  Future<void> endSessionGracefully() async {
    if (_endingStarted) return;
    _endingStarted = true;
    isTimeOver.value = true;
    timer?.cancel();
    stopwatch.stop();

    final socket = Get.find<SocketController>();

    try {
      // 1. stop mic first so user audio is not sent anymore
      callAudioController!.stopMicCaptureIfRunning();

      // 2. wait a little for already-playing agent voice to complete
      final waitMs = callAudioController?.remainingAgentAudioMs ?? 0;

      if (waitMs > 0) {
        await Future.delayed(Duration(milliseconds: waitMs));
      }
      Get.find<VoiceCallController>().messageC.value =
          AppConstents.voiceAgentEndMessage;
      final message = {
        "type": "call_ended",
        "stream_sid": Get.find<VoiceCallController>().streamId.value,
      };
      debugPrint("Message $message");
      await Get.find<SocketController>().sendMessage(message);
      // 3. small safety gap
      await Future.delayed(const Duration(milliseconds: 300));

      // 4. play local closing audio
      await playVoiceAgent();

      // 5. now disconnect websocket
      await socket.disconnect();
      // 6. stop local timer/session cleanup
      await stop();
    } catch (e) {
      debugPrint("endSessionGracefully error: $e");
      try {
        await socket.disconnect();
      } catch (_) {}
      await stop();
    }
  }

  Future<void> stop() async {
    stopwatch.stop();
    timer?.cancel();
  }

  void reset() {
    stopwatch.reset();
    sessionTime.value = "00:00";
  }

  Future<void> callkintisugiIntiateApi() async {
    Get.find<VoiceController>().isInitiating(true);
    final response = await Get.find<VoiceController>().initiateKintisugi();
    Get.find<AssessmentController>().sessionId.value = response;
    await Get.find<VoiceCallController>().getCredentials(
      sessionId: response,
      isUserVoice: true,
      isAgentVoice: false,
      isUserTransaction: false,
      isAgentTransaction: true,
      isFullRecording: false,
      isUserAgentVoice: false,
    );
    Get.find<VoiceController>().isInitiating(false);
  }
}

class AiSessionCallScreen extends StatefulWidget {
  const AiSessionCallScreen({super.key});

  @override
  State<AiSessionCallScreen> createState() => _AiSessionCallScreenState();
}

class _AiSessionCallScreenState extends State<AiSessionCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final controller = Get.find<AiSessionController>();
  // final socketController = Get.find<SocketController>();
  // final voiceController = Get.put(VoiceCallController());
  final socketController = Get.find<SocketController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  String cleanText(String text) {
    return text.replaceAll(RegExp(r'\n+'), '\n');
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.stop();
    controller.reset();
    socketController.disconnect();
    disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
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
                      onTap: () {
                        if (socketController.isMicMute.isFalse) {
                          socketController.isMicMute.value = true;
                        } else {
                          socketController.isMicMute.value = false;
                        }
                      },

                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color:
                              Get.find<SocketController>().isMicMute.isTrue
                                  ? const Color(0xFFEF5350)
                                  : Colors.grey.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Get.find<SocketController>().isMicMute.isTrue
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
                    onTap: () async {
                      // socketController.disconnect();
                      // Get.to(() => PhqTwoQuestionsScreen());

                      controller.endSessionGracefully();
                      controller.sessionTime.value = "00:00";
                      // controller.stop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Obx(
                    () =>
                        Get.find<VoiceCallController>().messageC.isNotEmpty
                            ? QuestionCard(
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: CommonText.text(
                                      maxLines: 10,

                                      cleanText(
                                        '"${Get.find<VoiceCallController>().messageC}"',
                                      ),
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppDimensions.font(18),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  CommonText.text(
                                    Get.find<VoiceCallController>()
                                        .agentName
                                        .value,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.font(18),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox.shrink(),
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
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
                                                ? 280 +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : 280,
                                        height:
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
                                                ? 280 +
                                                    (_animationController
                                                            .value *
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
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
                                                  ? 200 +
                                                      (_animationController
                                                              .value *
                                                          40)
                                                  : 200,
                                          height:
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
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
                                          child: Obx(
                                            () => ClipOval(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    Get.find<
                                                          VoiceCallController
                                                        >()
                                                        .agentImage
                                                        .value,
                                                //  "https://dev.sourcebytes.ai${voiceCallCOntroller.agentImage.value}",
                                                placeholder: (context, url) {
                                                  return CircularProgressIndicator();
                                                },
                                              ),
                                            ),
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
                                                padding: const EdgeInsets.all(
                                                  6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF2196F3,
                                                  ),
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
                    () =>
                        controller.isTimeOver.isFalse
                            ? Column(
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
                            )
                            : SizedBox.shrink(),
                  ),

                  SizedBox(height: 150),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
