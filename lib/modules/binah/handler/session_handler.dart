import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/binah/handler/measurment_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SessionStateHandler {
  final Rx<SessionState?> sessionState = Rx<SessionState?>(null);
  final RxBool showImageValidity = false.obs;

  final MeasurementManager measurementManager;
  SessionStateHandler(this.measurementManager);

  void handle(SessionState state) {
    sessionState.value = state;
    debugPrint("📡 Session state: $state");

    switch (state) {
      case SessionState.ready:
        WakelockPlus.enable();
        Future.delayed(const Duration(seconds: 5), () {
          if (sessionState.value == SessionState.ready) {
            measurementManager.start(60);
          }
        });
        break;
      case SessionState.terminating:
        WakelockPlus.disable();
        measurementManager.stop();
        break;
      default:
        break;
    }
  }
}
