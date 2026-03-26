import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ProgressHandlerMixin on GetxController {
  AnimationController? animationController;
  final RxBool isStarted = false.obs;
  final RxInt progress = 0.obs;
  final RxString imageValidityString = "".obs;
  RxString scanType = "".obs;
  final RxBool showImageValidity = false.obs;

  void startProgress({required int seconds}) {
    animationController?.duration = Duration(seconds: seconds);
    animationController?.reset();
    isStarted.value = true;
    animationController?.forward();
  }

  void stopProgress() {
    animationController?.stop();
    isStarted.value = false;
  }

  void resetProgress() {
    animationController?.reset();
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
    animationController?.dispose();
    super.onClose();
  }

  static Future<List<dynamic>> storingVitalResult(
    VitalSignsResults vitalsResults,
  ) async {
    return [
      vitalsResults.getResult(VitalSignTypes.wellnessIndex),
      vitalsResults.getResult(VitalSignTypes.respirationRate),
      vitalsResults.getResult(VitalSignTypes.pulseRate),
      vitalsResults.getResult(VitalSignTypes.prq),
      vitalsResults.getResult(VitalSignTypes.bloodPressure),
      vitalsResults.getResult(VitalSignTypes.oxygenSaturation),
      vitalsResults.getResult(VitalSignTypes.hemoglobin),
      vitalsResults.getResult(VitalSignTypes.hemoglobinA1C),
      vitalsResults.getResult(VitalSignTypes.ascvdRisk),
      vitalsResults.getResult(VitalSignTypes.heartAge),
      vitalsResults.getResult(VitalSignTypes.highBloodPressureRisk),
      vitalsResults.getResult(VitalSignTypes.highHemoglobinA1CRisk),
      vitalsResults.getResult(VitalSignTypes.highFastingGlucoseRisk),
      vitalsResults.getResult(VitalSignTypes.highTotalCholesterolRisk),
      vitalsResults.getResult(VitalSignTypes.lowHemoglobinRisk),
      vitalsResults.getResult(VitalSignTypes.stressLevel),
      vitalsResults.getResult(VitalSignTypes.stressIndex),
      vitalsResults.getResult(VitalSignTypes.normalizedStressIndex),
      vitalsResults.getResult(VitalSignTypes.sdnn),
      vitalsResults.getResult(VitalSignTypes.meanRri),
      vitalsResults.getResult(VitalSignTypes.rmssd),
      vitalsResults.getResult(VitalSignTypes.pnsZone),
      vitalsResults.getResult(VitalSignTypes.pnsIndex),
      vitalsResults.getResult(VitalSignTypes.snsZone),
      vitalsResults.getResult(VitalSignTypes.snsIndex),
      vitalsResults.getResult(VitalSignTypes.sd1),
      vitalsResults.getResult(VitalSignTypes.sd2),
      vitalsResults.getResult(VitalSignTypes.lfhf),
    ];
  }

  static Future<bool> checkingVitalResult(
    VitalSignsResults vitalsResults,
  ) async {
    final List<dynamic> list = await storingVitalResult(vitalsResults);
    debugPrint("Vital list: $list");
    final hasInvalid = list.any((result) => result == null || result == 0.0);
    return hasInvalid;
  }
}
