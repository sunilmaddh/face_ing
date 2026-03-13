import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import '../widgets/action_button.dart';
import '../widgets/question_card.dart';

class AiSessionCallScreen extends StatefulWidget {
  const AiSessionCallScreen({super.key});

  @override
  State<AiSessionCallScreen> createState() => _AiSessionCallScreenState();
}

class _AiSessionCallScreenState extends State<AiSessionCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final controller = Get.find<AiSessionController>();
  final socketController = Get.find<SocketController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    AppMethods().toggleWakelock(true);
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
    AppMethods().toggleWakelock(false);
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
                      controller.endSessionGracefully();
                      controller.sessionTime.value = "00:00";
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
                                                placeholder: (context, url) {
                                                  return CircularProgressIndicator();
                                                },
                                              ),
                                            ),
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
