import 'dart:async';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/utils/app_logger.dart';
import 'package:ntt_data/modules/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/voice_agent/helper/audio_player.dart';
import 'package:ntt_data/modules/voice_agent/model/request/voice_call_request.dart';
import 'package:ntt_data/modules/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/voice_agent/repositories/voice_agent_repository.dart';

class AiSessionController extends BaseController {
  AiSessionController({
    required this.voiceAgentRepository,
    required this.voiceCallController,
    required this.socketController,
    required this.assessmentController,
  });
  final VoiceAgentRepository voiceAgentRepository;
  final VoiceCallController voiceCallController;
  final SocketController socketController;
  final AssessmentController assessmentController;

  final RxString sessionTime = '00:00'.obs;
  final RxBool isTimeOver = false.obs;
  final RxBool isFirstTimeToConnect = false.obs;
  final RxBool isSecondTimeToConnect = false.obs;
  final RxBool isInitiating = false.obs;
  final RxBool isCallReady = false.obs;

  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  bool _endingStarted = false;
  Future<void> start() async {
    isTimeOver.value = false;
    _endingStarted = false;
    socketController.isSessionEnding = false;

    timer?.cancel();
    stopwatch.start();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsedSeconds = stopwatch.elapsed.inSeconds;

      final minutes = stopwatch.elapsed.inMinutes.toString().padLeft(2, '0');
      final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');

      sessionTime.value = "$minutes:$seconds";
    });
  }

  Future<void> stop() async {
    stopwatch.stop();
    timer?.cancel();
    timer = null;
  }

  void reset() {
    stopwatch.reset();
    sessionTime.value = "00:00";
    isTimeOver.value = false;
  }

  // ================= SESSION FLOW =================

  Future<bool> initializeSession() async {
    isInitiating.value = true;

    try {
      final sessionId = await _initiateKintisugi();

      if (sessionId.isEmpty) return false;

      assessmentController.sessionId.value = sessionId;
      final request = VoiceCallRequest(
        sessionId: sessionId,
        isUserVoice: true,
        isAgentVoice: true,
        isUserTransaction: false,
        isAgentTransaction: false,
        isFullRecording: true,
        isUserAgentVoice: true,
      );

      final success = await voiceCallController.getCredentials(
        request: request,
      );

      return success;
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
      return false;
    } finally {
      isInitiating.value = false;
    }
  }

  Future<bool> reInitializeSession() async {
    isSecondTimeToConnect.value = true;

    try {
      final success = await initializeSession();
      return success;
    } finally {
      isSecondTimeToConnect.value = false;
    }
  }

  Future<String> _initiateKintisugi() async {
    try {
      final response = await voiceAgentRepository.initiateKintsugiApi();

      if (response.statusCode == 200 && response.data != null) {
        return response.data!.sessionId ?? "";
      }
      setError(ValidationStrings.commonErrorMessage);
      return "";
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
      return "";
    }
  }

  // ================= END SESSION =================

  Future<void> endSessionGracefully() async {
    if (_endingStarted) return;

    _endingStarted = true;
    isTimeOver.value = true;

    timer?.cancel();
    stopwatch.stop();

    try {
      callAudioController?.stopMicCaptureIfRunning();

      final waitMs = callAudioController?.remainingAgentAudioMs ?? 0;

      if (waitMs > 0) {
        await Future.delayed(Duration(milliseconds: waitMs));
      }

      voiceCallController.messageC.value = AppStrings.voiceAgentEndMessage;

      final message = {
        "type": "call_ended",
        "stream_sid": voiceCallController.streamId.value,
      };

      await socketController.sendMessage(message);

      await Future.delayed(const Duration(milliseconds: 300));

      await playVoiceAgent();

      await socketController.disconnect();

      await stop();
    } catch (e) {
      AppLogger.error("endSessionGracefully error: $e");
      try {
        await socketController.disconnect();
      } catch (_) {}
      await stop();
      setError("Failed to end session properly");
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    stopwatch.stop();
    super.onClose();
  }
}
