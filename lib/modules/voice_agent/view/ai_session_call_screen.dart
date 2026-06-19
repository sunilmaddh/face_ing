import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/phq/widgets/action_button.dart';
import 'package:ntt_data/modules/phq/widgets/circular_progress_Painter.dart';
import 'package:ntt_data/modules/phq/widgets/question_card.dart';
import 'package:ntt_data/modules/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/voice_agent/view/vertically_scroll_text.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiSessionCallScreen extends StatefulWidget {
  const AiSessionCallScreen({super.key});

  @override
  State<AiSessionCallScreen> createState() => _AiSessionCallScreenState();
}

class _AiSessionCallScreenState extends State<AiSessionCallScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AiSessionController controller;
  late final SocketController socketController;
  late final VoiceCallController voiceCallController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AiSessionController>();
    socketController = Get.find<SocketController>();
    voiceCallController = Get.find<VoiceCallController>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppMethods().toggleWakelock(true);
      voiceCallController.setConverssionFlag();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.stop();
    controller.reset();
    socketController.disconnect();
    voiceCallController.isConverssionStarted.value = false;
    AppMethods().toggleWakelock(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Obx(() {
          if (controller.isTimeOver.isTrue) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: AppDimensions.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppDimensions.height(10)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: AppDimensions.height(82),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: const [
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            socketController.isMicMute.toggle();
                          },
                          child: Container(
                            width: AppDimensions.width(48),
                            height: AppDimensions.height(48),
                            decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(40),
                              shape: BoxShape.circle,
                            ),
                            child: Obx(
                              () => Icon(
                                socketController.isMicMute.isTrue
                                    ? Icons.mic_off_outlined
                                    : Icons.mic_none_outlined,
                                color: const Color(0xff475569),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => CommonText.displaySmall(
                                controller.sessionTime.value,

                                color: AppColors.bottomTextColor,
                              ),
                            ),
                            CommonText.labelLarge(
                              "Listening...",

                              fontWeight: FontWeight.w700,
                              color: AppColors.infoIconColor,
                            ),
                          ],
                        ),
                        ActionButton(
                          icon: Icons.call_end,
                          color: Colors.red,
                          onTap: () async {
                            CommonDialog().showCallAlertDialog(
                              context: context,
                              onConfirm: () {},
                              onCancel: () {
                                controller.endSessionGracefully();
                              },
                              title: "Are you sure to end the conversation?",
                              message:
                                  "The voice scan requires a few minutes of interaction to collect sufficient audio for analysis. Ending the session now may result in incomplete or inaccurate results.",
                              confirmText: "",
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppDimensions.height(10)),
            Obx(() {
              if (voiceCallController.messageC.isEmpty) {
                return SizedBox(height: AppDimensions.height(160));
              }
              return QuestionCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText.labelLarge(
                      voiceCallController.agentName.value,

                      fontWeight: FontWeight.w600,

                      // ignore: deprecated_member_use
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                    SizedBox(height: AppDimensions.height(10)),
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.height(160),
                      child: VerticalAutoScroll(
                        text: voiceCallController.messageC.value,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: AppDimensions.height(20)),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: AppDimensions.height(340),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final isStarted =
                                    voiceCallController
                                        .isConverssionStarted
                                        .isTrue;
                                return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return SizedBox(
                                      width:
                                          isStarted
                                              ? AppDimensions.width(270) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.width(270),
                                      height:
                                          isStarted
                                              ? AppDimensions.height(270) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.height(270),
                                      child: CircularProgressWithDot(
                                        progress:
                                            socketController.progress.value,
                                      ),
                                    );
                                  },
                                );
                              }),
                              Obx(() {
                                final isStarted =
                                    voiceCallController
                                        .isConverssionStarted
                                        .isTrue;
                                return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Container(
                                      width:
                                          isStarted
                                              ? AppDimensions.width(240) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.width(240),
                                      height:
                                          isStarted
                                              ? AppDimensions.height(240) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.height(240),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(
                                          0xFF2196F3,
                                          // ignore: deprecated_member_use
                                        ).withOpacity(0.15),
                                      ),
                                    );
                                  },
                                );
                              }),
                              Positioned(
                                top: 17,
                                child: Obx(() {
                                  final isStarted =
                                      voiceCallController
                                          .isConverssionStarted
                                          .isTrue;
                                  return AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Container(
                                        width:
                                            isStarted
                                                ? AppDimensions.width(185) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.width(185),
                                        height:
                                            isStarted
                                                ? AppDimensions.height(185) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.height(185),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFF2196F3,
                                            // ignore: deprecated_member_use
                                          ).withOpacity(0.15),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                              Positioned(
                                top: 26,
                                child: Obx(() {
                                  final isStarted =
                                      voiceCallController
                                          .isConverssionStarted
                                          .isTrue;
                                  return AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Container(
                                        width:
                                            isStarted
                                                ? AppDimensions.width(140) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.width(140),
                                        height:
                                            isStarted
                                                ? AppDimensions.height(140) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.height(140),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(
                                            0xFF2196F3,
                                            // ignore: deprecated_member_use
                                          ).withOpacity(0.25),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                              Positioned(
                                top: 34,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      width: AppDimensions.width(122),
                                      height: AppDimensions.height(122),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5,
                                        ),
                                      ),
                                      child: Obx(
                                        () => ClipOval(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                voiceCallController
                                                    .agentImage
                                                    .value,
                                            placeholder: (context, url) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 25,
                                      child: Container(
                                        width: AppDimensions.width(25),
                                        height: AppDimensions.height(25),
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
                                          size: 15,
                                        ),
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
                ),
              ],
            ),
            SizedBox(height: AppDimensions.height(120)),
          ],
        ),
      ),
    );
  }
}
