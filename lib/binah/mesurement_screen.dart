import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/start_stop_button.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});
  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final controller = Get.find<MeasurementController>();
  final String scanType = Get.arguments["scanType"] ?? "";
  @override
  void dispose() {
    // TODO: implement dispose
    controller.cloase();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() {
    //   controller.isMeasurementCanceled.value = false;
    //   controller.scanType.value = scanType;
    //   controller.startStopButtonClicked();
    // });
    return FocusDetector(
      onFocusLost: () {
        controller.screenInFocus(
          false,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
        );
      },
      onFocusGained: () {
        controller.screenInFocus(
          true,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CameraPreview(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: AppDimensions.height(250),
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Obx(() {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ImageValidityScan(),

                            MeasurmentProgress(controller: controller),
                            SizedBox(height: 30),
                            StartStopButton(),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeasurmentProgress extends StatelessWidget {
  const MeasurmentProgress({super.key, required this.controller});

  final MeasurementController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible:
            controller.imageData.value != null &&
            controller.imageData.value!.imageValidity == ImageValidity.valid &&
            controller.isStarted.value == true,
        child: Column(
          children: [
            PulseRate(),

            SizedBox(
              width: 300,
              height: AppDimensions.height(100),
              child: LottieBuilder.asset(
                AppAssets.heartRateAnim,
                fit: BoxFit.fill,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.width(20),
              ),
              child: FAProgressBar(
                progressColor: Colors.green,
                currentValue: controller.progress.value,
                displayText: "%",
              ),
            ),
          ],
        ),
      );
    });
  }
}
