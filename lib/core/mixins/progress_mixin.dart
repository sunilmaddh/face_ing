import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ProgressHandlerMixin on GetxController {
  late AnimationController animationController;
  final RxBool isStarted = false.obs;
  final RxInt progress = 0.obs;
  final RxString imageValidityString = "".obs;
  RxString scanType = "".obs;
  final RxBool showImageValidity = false.obs;

  void startProgress({required int seconds}) {
    animationController.duration = Duration(seconds: seconds);
    animationController.reset();
    isStarted.value = true;
    animationController.forward();
  }

  void stopProgress() {
    animationController.stop();
    isStarted.value = false;
  }

  void resetProgress() {
    animationController.reset();
    progress.value = 0;
    isStarted.value = false;
  }

  void closeProgress() {
    stopProgress();
    resetProgress();
  }

  void handleValid(String message, {int durationSeconds = 30}) {
    imageValidityString.value = message;
    // resetProgress();
    // startProgress(seconds: durationSeconds);
  }

  void handleInvalid(String message) {
    imageValidityString.value = message;
    // closeProgress();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  static Future<bool> verifyVitalResult(VitalSignsResults vitalsResults) async {
    List vitalList = [
      vitalsResults.getResult(VitalSignTypes.wellnessIndex).toString(),
      vitalsResults.getResult(VitalSignTypes.wellnessIndex).toString(),
      vitalsResults.getResult(VitalSignTypes.respirationRate).toString(),
      vitalsResults.getResult(VitalSignTypes.pulseRate).toString(),
      vitalsResults.getResult(VitalSignTypes.prq).toString(),
      vitalsResults.getResult(VitalSignTypes.bloodPressure).toString(),
      vitalsResults.getResult(VitalSignTypes.oxygenSaturation).toString(),
      vitalsResults.getResult(VitalSignTypes.hemoglobin).toString(),
      vitalsResults.getResult(VitalSignTypes.hemoglobinA1C).toString(),
      vitalsResults.getResult(VitalSignTypes.ascvdRisk).toString(),
      vitalsResults.getResult(VitalSignTypes.heartAge).toString(),
      vitalsResults.getResult(VitalSignTypes.highBloodPressureRisk).toString(),
      vitalsResults.getResult(VitalSignTypes.highHemoglobinA1CRisk).toString(),
      vitalsResults.getResult(VitalSignTypes.highFastingGlucoseRisk).toString(),
      vitalsResults
          .getResult(VitalSignTypes.highTotalCholesterolRisk)
          .toString(),
      vitalsResults.getResult(VitalSignTypes.lowHemoglobinRisk).toString(),
      vitalsResults.getResult(VitalSignTypes.stressIndex).toString(),
      vitalsResults.getResult(VitalSignTypes.sdnn).toString(),
      vitalsResults.getResult(VitalSignTypes.lfhf).toString(),
    ];

    for (var result in vitalList) {
      if (result == null) {
        return false;
      }
    }
    return true;
  }
}
