import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice/widgets/voice_recording_widget.dart';
import 'package:ntt_data/modules/views/voice/widgets/voice_top_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

class VoiceScreen extends StatelessWidget {
  VoiceScreen({super.key});
  final _voiceController = Get.find<VoiceController>();
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
                    AppNavigation.to(AppRoutes.pulseProgressWidget);
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
