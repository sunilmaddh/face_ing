import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/phq/screens/ai_session_call_screen.dart';
import 'package:ntt_data/modules/views/phq/widgets/question_card.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_call_controller.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiSessionScreen extends StatefulWidget {
  const AiSessionScreen({super.key});

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
                                                      placeholder: (
                                                        context,
                                                        url,
                                                      ) {
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

                              Get.to(() => AiSessionCallScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),

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
