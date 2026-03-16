import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/phq/widgets/linear_progress_bar_with_dot.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import '../widgets/action_button.dart';
import '../widgets/circular_progress_Painter.dart';
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
    playDuringCalling();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressWithDot(progress: socketController.progress.value),
              SizedBox(height: AppDimensions.height(10)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: AppDimensions.height(82),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: AppDimensions.width(48),
                            height: AppDimensions.height(48),
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
                                  : Icons.mic_none_outlined,
                              color: Color(0xff475569),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () =>
                            controller.isTimeOver.isFalse
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                )
                                : SizedBox.shrink(),
                      ),
                      // SizedBox(width: 50),
                      ActionButton(
                        icon: Icons.call_end,
                        color: Colors.red,
                        onTap: () async {
                          CommonDialog().showCallAlertDialog(
                            context: context,
                            onConfirm: () {
                              // Get.back();
                            },
                            onCancel: () {
                              controller.endSessionGracefully();
                            },
                            title: "Are you sure to end the conversation?",
                            message:
                                "The voice scan requires a few minutes of interaction to collect sufficient audio for analysis. Ending the session now may result in incomplete or inaccurate results.",
                            confirmText: "",
                          );
                          // controller.endSessionGracefully();
                          // controller.sessionTime.value = "00:00";
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                                    Get.find<VoiceCallController>()
                                        .agentName
                                        .value,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.font(14),
                                    color: AppColors.primary.withOpacity(0.6),
                                  ),
                                  SizedBox(height: AppDimensions.height(20)),
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
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                ],
                              ),
                            )
                            : SizedBox.shrink(),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      SizedBox(
                        height: AppDimensions.height(320),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // AnimatedBuilder(
                                  //   animation: _animationController,
                                  //   builder: (context, child) {
                                  //     return Obx(
                                  //       () => CircularProgressWithDot(
                                  //         progress:
                                  //             socketController.progress.value,
                                  //         size:
                                  //             AppDimensions.width(220) +
                                  //             (_animationController.value * 40),
                                  //         strokeWidth: 14,
                                  //         progressColor: AppColors.primary,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Container(
                                        width:
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
                                                ? AppDimensions.width(270) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.width(270),
                                        height:
                                            Get.find<VoiceCallController>()
                                                    .messageC
                                                    .isNotEmpty
                                                ? AppDimensions.height(270) +
                                                    (_animationController
                                                            .value *
                                                        40)
                                                : AppDimensions.height(270),
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
                                    top: 3,
                                    child: AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        return Container(
                                          width:
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
                                                  ? AppDimensions.width(210) +
                                                      (_animationController
                                                              .value *
                                                          40)
                                                  : AppDimensions.width(210),
                                          height:
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
                                                  ? AppDimensions.height(210) +
                                                      (_animationController
                                                              .value *
                                                          40)
                                                  : AppDimensions.height(210),
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
                                    top: 5,
                                    child: AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        return Container(
                                          width:
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
                                                  ? AppDimensions.width(170) +
                                                      (_animationController
                                                              .value *
                                                          40)
                                                  : AppDimensions.width(170),
                                          height:
                                              Get.find<VoiceCallController>()
                                                      .messageC
                                                      .isNotEmpty
                                                  ? AppDimensions.height(170) +
                                                      (_animationController
                                                              .value *
                                                          40)
                                                  : AppDimensions.height(170),
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
                                    top: 10,
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          width: AppDimensions.width(152),
                                          height: AppDimensions.height(152),
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
                                          right: 25,

                                          child: Column(
                                            children: [
                                              Container(
                                                width: AppDimensions.width(25),
                                                height: AppDimensions.height(
                                                  25,
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //   6,
                                                // ),
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
                    ],
                  ),

                  // Obx(
                  //   () =>
                  //       controller.isTimeOver.isFalse
                  //           ? Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Obx(
                  //                 () => CommonText.text(
                  //                   controller.sessionTime.value,
                  //                   fontSize: 30,
                  //                   fontWeight: FontWeight.w700,
                  //                   color: AppColors.bottomTextColor,
                  //                   fontFamily: "Manrope",
                  //                 ),
                  //               ),
                  //               CommonText.text(
                  //                 "Listening...",
                  //                 fontSize: AppDimensions.font(14),
                  //                 fontWeight: FontWeight.w700,
                  //                 color: AppColors.infoIconColor,
                  //                 fontFamily: "Manrope",
                  //               ),
                  //             ],
                  //           )
                  //           : SizedBox.shrink(),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: AppDimensions.width(25),
                  //     vertical: AppDimensions.height(20),
                  //   ),
                  //   child: FAProgressBar(
                  //     size: 20,
                  //     borderRadius: BorderRadius.circular(20),
                  //     progressColor: AppColors.primary,
                  //     currentValue: 20, // convert int → double
                  //     displayText: "%",
                  //     formatValue:
                  //         (value, _) =>
                  //             value.toInt().toString(), // show only integer
                  //     // ensures no extra decimals
                  //   ),
                  // ),
                  // SizedBox(height: AppDimensions.height(10)),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: AppDimensions.width(25),
                  //   ),
                  //   child: CommonText.text(
                  //     fontFamily: "Manrope",
                  //     fontSize: AppDimensions.font(12),
                  //     fontWeight: FontWeight.w400,
                  //     maxLines: 5,
                  //     color: Color(0xff334155),

                  //     "Lorem Ipsum is placeholder text commonly used in design, publishing, and UI mockups to show how text will look in a layout before the real content is ready.",
                  //   ),
                  // ),
                  SizedBox(height: AppDimensions.height(20)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
