import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice/widgets/voice_recording_widget.dart';
import 'package:ntt_data/modules/views/voice/widgets/voice_top_widget.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

class VoiceScreen extends StatelessWidget {
  VoiceScreen({super.key});
  final _voiceController = Get.find<VoiceController>();
  final _controller = Get.find<LandingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () =>
            _voiceController.isStarted.isTrue
                ? PrimaryButton(
                  width: AppDimensions.width(243),
                  text: "Stop Speak",
                  onPressed: () {
                    _controller.onTabTapped(0);
                    // AppNavigation.to(AppRoutes.pulseProgressWidget);
                  },
                )
                : SizedBox(),
      ),
      appBar: CustomAppBar(
        title: "Voice",
        onTop: () {
          _voiceController.isStarted.value = false;
          Get.back();
        },
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppAssets.voiceBg),
            ),
          ),
          child: Obx(
            () =>
                _voiceController.isStarted.isTrue
                    ? VoiceRecordingWidget()
                    : VoiceTopWidget(
                      onTop: () {
                        _voiceController.isStarted.value = true;
                      },
                    ),
          ),
        ),
      ),
    );
  }
}
