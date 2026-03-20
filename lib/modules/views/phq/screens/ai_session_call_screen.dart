import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/phq/widgets/circular_progress_Painter.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/vertically_scroll_text.dart';
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
  final voiceController = Get.find<VoiceCallController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppMethods().toggleWakelock(true);
      Get.find<VoiceCallController>().setConverssionFlag();
    });
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
    Get.find<VoiceCallController>().isConverssionStarted(false);
    AppMethods().toggleWakelock(false);
    socketController.progress.value = 0.0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Obx(() {
          if (controller.isTimeOver.isFalse) {
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
                          /// Mic Button
                          GestureDetector(
                            onTap: () {
                              if (socketController.isMicMute.isFalse) {
                                socketController.isMicMute(true);
                              } else {
                                socketController.isMicMute(false);
                              }
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

                          /// Timer
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => CommonText.text(
                                  controller.sessionTime.value,
                                  fontSize: AppDimensions.font(24),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.bottomTextColor,
                                  fontFamily: "Manrope",
                                ),
                              ),
                              CommonText.text(
                                "Listening...",
                                fontSize: AppDimensions.font(14),
                                fontWeight: FontWeight.w700,
                                color: AppColors.infoIconColor,
                                fontFamily: "Manrope",
                              ),
                            ],
                          ),

                          /// End Call Button
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
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppDimensions.height(10)),
            Obx(
              () =>
                  Get.find<VoiceCallController>().messageC.isNotEmpty
                      ? QuestionCard(
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText.text(
                              Get.find<VoiceCallController>().agentName.value,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.font(14),
                              color: AppColors.primary.withOpacity(0.6),
                            ),
                            SizedBox(height: AppDimensions.height(10)),
                            SizedBox(
                              width: double.infinity,
                              height: AppDimensions.height(160),
                              child: VerticalAutoScroll(
                                text:
                                    Get.find<VoiceCallController>()
                                        .messageC
                                        .value,
                              ),
                            ),
                            SizedBox(height: 0),
                          ],
                        ),
                      )
                      : SizedBox(height: AppDimensions.height(160)),
            ),
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
                                    voiceController.isConverssionStarted.isTrue;
                                final progressTime =
                                    socketController.progress.value;

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
                                        time: progressTime,
                                      ),
                                    );
                                  },
                                );
                              }),
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Container(
                                    width:
                                        Get.find<VoiceCallController>()
                                                .isConverssionStarted
                                                .isTrue
                                            ? AppDimensions.width(240) +
                                                (_animationController.value *
                                                    40)
                                            : AppDimensions.width(240),
                                    height:
                                        Get.find<VoiceCallController>()
                                                .isConverssionStarted
                                                .isTrue
                                            ? AppDimensions.height(240) +
                                                (_animationController.value *
                                                    40)
                                            : AppDimensions.height(240),
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
                                top: 17,
                                child: AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Container(
                                      width:
                                          Get.find<VoiceCallController>()
                                                  .isConverssionStarted
                                                  .isTrue
                                              ? AppDimensions.width(185) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.width(185),
                                      height:
                                          Get.find<VoiceCallController>()
                                                  .isConverssionStarted
                                                  .isTrue
                                              ? AppDimensions.height(185) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.height(185),
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
                                top: 26,
                                child: AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Container(
                                      width:
                                          Get.find<VoiceCallController>()
                                                  .isConverssionStarted
                                                  .isTrue
                                              ? AppDimensions.width(140) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.width(140),
                                      height:
                                          Get.find<VoiceCallController>()
                                                  .isConverssionStarted
                                                  .isTrue
                                              ? AppDimensions.height(140) +
                                                  (_animationController.value *
                                                      40)
                                              : AppDimensions.height(140),
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
                                top: 34,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
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
                                          // borderRadius:
                                          //     BorderRadiusGeometry.circular(
                                          //       50,
                                          //     ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                Get.find<VoiceCallController>()
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
                                      right: 25,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: AppDimensions.width(25),
                                            height: AppDimensions.height(25),
                                            // padding: const EdgeInsets.all(
                                            //   6,
                                            // ),
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
                ),
              ],
            ),

            SizedBox(height: AppDimensions.height(AppDimensions.height(120))),
          ],
        ),
      ),
    );
  }
}
