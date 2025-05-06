import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ProgressHandlerMixin on GetxController {
  late AnimationController animationController;
  final RxBool isStarted = false.obs;
  final RxDouble progress = 0.0.obs;
  final RxString imageValidityString = "".obs;
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
    progress.value = 0.0;
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
}
