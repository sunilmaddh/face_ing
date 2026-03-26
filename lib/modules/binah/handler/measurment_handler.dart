import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/binah/handler/error_handler.dart';
import 'package:ntt_data/modules/binah/handler/session_manager.dart';

class MeasurementManager {
  final RxBool isStarted = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isScanningDone = false.obs;

  final SessionManager sessionManager;
  final ErrorHandler errorHandler;

  MeasurementManager(this.sessionManager, this.errorHandler);
  Future<void> start(int duration) async {
    try {
      isLoading.value = true;
      isStarted.value = true;
      await sessionManager.start(duration);
      isLoading.value = false;
      debugPrint("✅ Measurement started for $duration sec");
    } catch (e) {
      errorHandler.onError("Measurement failed: $e");
      stop();
    }
  }

  Future<void> stop() async {
    try {
      isStarted.value = false;
      isLoading.value = false;
      await sessionManager.stop();
      debugPrint("🛑 Measurement stopped");
    } catch (e) {
      errorHandler.onError("Stop failed: $e");
    }
  }

  void markScanDone() {
    isScanningDone.value = true;
    isStarted.value = false;
  }
}
