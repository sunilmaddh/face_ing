import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class StartStopButton extends StatelessWidget {
  StartStopButton({super.key});

  final controller = Get.find<MeasurementController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible:
            controller.sessionState.value == SessionState.ready ||
            controller.sessionState.value == SessionState.processing &&
                controller.isStarted.value == false,
        child: Column(
          children: [
            CommonText.text(
              "Sit still, ensure your face is evenly illuminated and there is no light source in the background.",
              color: AppColors.searchColor,
            ),
            PrimaryButton(
              isLoading: controller.isLoading.value,
              text: "Measure now",
              onPressed: () {
                controller.isLoading.value = true;
                controller.startStopButtonClicked();
              },
            ),
          ],
        ),
      );
      //  Opacity(
      //   opacity:
      //       (controller.sessionState.value == SessionState.ready ||
      //               controller.sessionState.value == SessionState.processing)
      //           ? 1.0
      //           : 0.5,
      //   child: InkWell(
      //     onTap: controller.startStopButtonClicked,
      //     child: Container(
      //       width: 300,
      //       height: 60,
      //       alignment: Alignment.center,
      //       padding: const EdgeInsets.symmetric(vertical: 20),
      //       color: const Color(0xFF6200EE),
      //       child: Text(
      //         controller.sessionState.value != SessionState.processing
      //             ? "STOP ${controller.sessionState.value}"
      //             : "START",
      //         style: const TextStyle(color: Colors.white),
      //       ),
      //     ),
      //   ),
      // );
    });
  }
}

class PulseRate extends StatelessWidget {
  const PulseRate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return Obx(
      () => Text(
        "${controller.pulseRate.value} bpm" ?? "",
        style: const TextStyle(color: Colors.black, fontSize: 26),
      ),
    );
  }
}

class ImageValidityScan extends StatelessWidget {
  const ImageValidityScan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return Center(
      child: Obx(
        () => Visibility(
          visible:
              controller.imageData.value != null &&
              controller.imageData.value!.imageValidity !=
                  ImageValidity.valid &&
              controller.isStarted.value == true,
          child: Text(
            controller.imageValidityString.value,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
