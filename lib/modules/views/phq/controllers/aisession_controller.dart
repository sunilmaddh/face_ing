import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/voice_call_controller.dart';

class AiSessionController extends GetxController {
  final voiceCallCOntroller = Get.put(VoiceCallController());
  final isTalking = false.obs;
  final sessionTime = '00:00'.obs;
  RxBool isTimeOver = false.obs;
  RxBool isFirstTimeToConnect = false.obs;
  RxBool isSecondTimeToConnect = false.obs;

  final stopwatch = Stopwatch();
  Timer? timer;

  var time = "00:00".obs;

  Future<void> start() async {
    isTimeOver.value = false;
    _endingStarted = false;
    Get.find<SocketController>().isSessionEnding = false;
    stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      final elapsedSeconds = stopwatch.elapsed.inSeconds;

      final minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, '0');
      final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
      sessionTime.value = "$minutes:$seconds";

      // if (elapsedSeconds >= 240) {
      //   await endSessionGracefully();
      // }
    });
  }

  bool _endingStarted = false;

  Future<void> endSessionGracefully() async {
    if (_endingStarted) return;
    _endingStarted = true;
    isTimeOver.value = true;
    timer?.cancel();
    stopwatch.stop();

    final socket = Get.find<SocketController>();

    try {
      // 1. stop mic first so user audio is not sent anymore
      callAudioController!.stopMicCaptureIfRunning();

      // 2. wait a little for already-playing agent voice to complete
      final waitMs = callAudioController?.remainingAgentAudioMs ?? 0;

      if (waitMs > 0) {
        await Future.delayed(Duration(milliseconds: waitMs));
      }
      Get.find<VoiceCallController>().messageC.value =
          AppConstents.voiceAgentEndMessage;
      final message = {
        "type": "call_ended",
        "stream_sid": Get.find<VoiceCallController>().streamId.value,
      };
      debugPrint("Message $message");
      await Get.find<SocketController>().sendMessage(message);
      // 3. small safety gap
      await Future.delayed(const Duration(milliseconds: 300));

      // 4. play local closing audio
      await playVoiceAgent();

      // 5. now disconnect websocket
      await socket.disconnect();
      // 6. stop local timer/session cleanup
      await stop();
    } catch (e) {
      debugPrint("endSessionGracefully error: $e");
      try {
        await socket.disconnect();
      } catch (_) {}
      await stop();
    }
  }

  Future<void> stop() async {
    stopwatch.stop();
    timer?.cancel();
  }

  void reset() {
    stopwatch.reset();
    sessionTime.value = "00:00";
  }

  Future<void> callkintisugiIntiateApi() async {
    Get.find<VoiceController>().isInitiating(true);
    final response = await Get.find<VoiceController>().initiateKintisugi();
    Get.find<AssessmentController>().sessionId.value = response;
    await Get.find<VoiceCallController>().getCredentials(
      sessionId: response,
      isUserVoice: true,
      isAgentVoice: false,
      isUserTransaction: false,
      isAgentTransaction: true,
      isFullRecording: false,
      isUserAgentVoice: false,
    );
    Get.find<VoiceController>().isInitiating(false);
  }
}
