import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

class StartStopButton extends StatelessWidget {
  StartStopButton({super.key});

  final controller = Get.find<MeasurementController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.sessionState.value;

      return Opacity(
        opacity:
            (state == SessionState.ready || state == SessionState.processing)
                ? 1.0
                : 0.5,
        child: InkWell(
          onTap: controller.startStopButtonClicked,
          child: Container(
            width: 100,
            height: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFF6200EE),
            child: Text(
              state == SessionState.processing ? "STOP" : "START",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
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
        controller.pulseRate.value ?? "null",
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
          visible: controller.showImageValidity.value,
          child: Container(
            color: const Color(0xFF3D3734),
            padding: const EdgeInsets.all(5.0),
            width: 180,
            child: Column(
              children: [
                const Text(
                  "Image Validity",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  controller.imageValidityString.value ?? "ggg",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
