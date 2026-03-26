import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/phq/widgets/question_card.dart';
import 'package:ntt_data/modules/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class AiSessionScreen extends BaseView<AiSessionController> {
  AiSessionScreen({super.key});

  final VoiceCallController voiceCallController =
      Get.find<VoiceCallController>();

  @override
  bool get useDefaultLoader => false;

  @override
  void onInit(AiSessionController controller) {
    controller.initializeSession();
  }

  @override
  Widget buildView(BuildContext context, AiSessionController controller) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isInitiating.isTrue &&
            controller.isFirstTimeToConnect.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        return _buildBody(context, controller);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
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
            children: [
              Container(
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              Text(
                ' Secure Connection',
                style: TextStyle(
                  color: const Color(0xff64748B),
                  fontSize: AppDimensions.font(16),
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AiSessionController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        QuestionCard(
          widget: Obx(
            () => CommonText.text(
              voiceCallController.agentName.value,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              fontFamily: "Manrope",
              fontSize: AppDimensions.font(14),
              color: const Color(0xff137FEC).withOpacity(0.6),
            ),
          ),
        ),
        _buildAvatar(),
        SizedBox(height: AppDimensions.height(80)),
        _buildStartButton(context, controller),
        SizedBox(height: AppDimensions.height(80)),
      ],
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      height: AppDimensions.height(360),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _circle(290, 0.10),
            _circle(220, 0.10),
            _circle(160, 0.20),
            _profileImage(),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, double opacity) {
    return Container(
      width: AppDimensions.width(size),
      height: AppDimensions.height(size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xff137FEC).withOpacity(opacity),
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Obx(
            () => ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: voiceCallController.agentImage.value,
                placeholder:
                    (_, __) => const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(Icons.person, size: 50),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.graphic_eq, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton(
    BuildContext context,
    AiSessionController controller,
  ) {
    return SizedBox(
      height: AppDimensions.height(48),
      child: Obx(() {
        if (controller.isSecondTimeToConnect.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return ElevatedButton(
          onPressed: () async {
            await _startCall(controller);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone_outlined, color: AppColors.btntext),
                CommonText.text(
                  "Start Now",
                  color: AppColors.btntext,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Manrope",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _startCall(AiSessionController controller) async {
    bool isCallReady = controller.isCallReady.value;

    if (controller.isFirstTimeToConnect.isFalse) {
      isCallReady = await controller.reInitializeSession();
    }

    if (!isCallReady) return;

    final success = await voiceCallController.initializeAndStartCall(
      tenantIds: voiceCallController.tenant.value,
      agentIds: voiceCallController.agentId.value,
      streamIds: voiceCallController.streamId.value,
    );

    if (success) {
      AppNavigation.to(AppRoutes.aiSessionCallScreen);
      controller.isFirstTimeToConnect.value = false;
    }
  }
}
