import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/phq/screens/ai_session_call_screen.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_two_questions_screen.dart';
import 'package:ntt_data/modules/views/phq/widgets/question_card.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_call_controller.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiSessionScreen extends StatefulWidget {
  AiSessionScreen({super.key});

  @override
  State<AiSessionScreen> createState() => _AiSessionScreenState();
}

class _AiSessionScreenState extends State<AiSessionScreen> {
  final controller = Get.find<AiSessionController>();
  final voiceCallCOntroller = Get.find<VoiceCallController>();
  final voiceCOntroller = Get.find<VoiceController>();

  @override
  void initState() {
    callMethod();
    // TODO: implement initState

    super.initState();
  }

  void callMethod() async {
    controller.isFirstTimeToConnect(true);
    await controller.callkintisugiIntiateApi();
    await initPlayer();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Session in Progress',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppDimensions.font(18),
                fontWeight: FontWeight.w700,
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
                Text(
                  ' Secure Connection',
                  style: TextStyle(
                    color: Color(0xff64748B),
                    fontSize: AppDimensions.font(16),
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            voiceCOntroller.isInitiating.isTrue
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        QuestionCard(
                          widget: CommonText.text(
                            textAlign: TextAlign.center,
                            voiceCallCOntroller.agentName.value,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Manrope",
                            fontSize: AppDimensions.font(14),
                            color: Color(0xff137FEC).withOpacity(0.6),
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
                                        Container(
                                          width: AppDimensions.width(290),
                                          height: AppDimensions.height(290),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color(
                                              0xff137FEC,
                                            ).withOpacity(0.10),
                                          ),
                                        ),

                                        Positioned(
                                          // top: 10,
                                          child: Container(
                                            width: AppDimensions.width(220),
                                            height: AppDimensions.height(220),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xff137FEC,
                                              ).withOpacity(0.10),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          // top: 14,
                                          child: Container(
                                            width: AppDimensions.width(160),
                                            height: AppDimensions.height(160),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(
                                                0xff137FEC,
                                              ).withOpacity(0.20),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // top: 15,
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
                                                          voiceCallCOntroller
                                                              .agentImage
                                                              .value,
                                                      //  "https://dev.sourcebytes.ai${voiceCallCOntroller.agentImage.value}",
                                                      placeholder: (
                                                        context,
                                                        url,
                                                      ) {
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
                                                      padding:
                                                          const EdgeInsets.all(
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

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Obx(
                        //       () => Text(
                        //         controller.sessionTime.value,
                        //         style: const TextStyle(
                        //           fontSize: 32,
                        //           fontWeight: FontWeight.bold,
                        //           color: AppColors.bottomTextColor,
                        //         ),
                        //       ),
                        //     ),
                        //     Text(
                        //       "Listening...",
                        //       style: const TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //         color: AppColors.infoIconColor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 70,
                        //     vertical: 10,
                        //   ),
                        //   child: Container(
                        //     height: 80,
                        //     // width: 200,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(50),
                        //       color: Colors.white,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.black26,
                        //           blurRadius: 10,
                        //           offset: Offset(0, 4),
                        //         ),
                        //       ],
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(10),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           Obx(
                        //             () => GestureDetector(
                        //               onTap:
                        //                   () =>
                        //                       Get.find<VoiceCallController>()
                        //                           .messageC
                        //                           .isNotEmpty,
                        //               child: Container(
                        //                 width: 56,
                        //                 height: 56,
                        //                 decoration: BoxDecoration(
                        //                   color:
                        //                       Get.find<VoiceCallController>()
                        //                               .messageC
                        //                               .isNotEmpty
                        //                           ? const Color(0xFFEF5350)
                        //                           : Colors.grey.withAlpha(40),
                        //                   shape: BoxShape.circle,
                        //                 ),
                        //                 child: Icon(
                        //                   controller.isTalking.value
                        //                       ? Icons.stop
                        //                       : Icons.mic_outlined,
                        //                   color: Colors.grey,
                        //                   size: 34,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        // ),
                        //  ),
                        SizedBox(height: AppDimensions.height(80)),
                        SizedBox(
                          height: AppDimensions.height(48),
                          child: ElevatedButton(
                            onPressed: () async {
                              // await Get.find<SocketController>().disconnect();
                              if (controller.isFirstTimeToConnect.isFalse) {
                                await controller.callkintisugiIntiateApi();
                                await initPlayer();
                              }
                              controller.isFirstTimeToConnect(false);
                              await voiceCallCOntroller.initializeAndStartCall(
                                tenantIds: voiceCallCOntroller.tenant.value,
                                agentIds: voiceCallCOntroller.agentId.value,
                                streamIds: voiceCallCOntroller.streamId.value,
                              );
                              // Get.find<VoiceCallController>().messageC.value =
                              //     "";
                              Get.to(() => AiSessionCallScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              // padding: EdgeInsets.symmetric(
                              //   vertical: padding,
                              //   horizontal: padding * 2,
                              // ),
                              shadowColor: Colors.black26,
                              elevation: 4,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    color: AppColors.btntext,
                                  ),
                                  CommonText.text(
                                    "Start Now",
                                    color: AppColors.btntext,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Manrope",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppDimensions.height(80)),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}
