import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/modules/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/voice_agent/helper/audio_player.dart';
import 'package:ntt_data/modules/voice_agent/model/webhook_response.dart';
import 'package:ntt_data/modules/voice_agent/repositories/voice_agent_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceCallController extends BaseController {
  VoiceCallController({required this.voiceAgentRepository});

  final VoiceAgentRepository voiceAgentRepository;
  final SocketController socketController = Get.find<SocketController>();

  final RxString messageC = "".obs;
  final RxString agentName = "".obs;
  final RxString agentImage = "".obs;
  final RxString tenant = "".obs;
  final RxString agentId = "".obs;
  final RxString streamId = "".obs;
  final RxBool isConverssionStarted = false.obs;
  final Rx<WebhookResponse> webhookResponse = WebhookResponse().obs;

  @override
  void onInit() {
    super.onInit();
    requestMicPermission();
  }

  void setConverssionFlag() {
    isConverssionStarted.value = true;
  }

  Future<bool> getCredentials({
    required String sessionId,
    required bool isUserVoice,
    required bool isAgentVoice,
    required bool isUserTransaction,
    required bool isAgentTransaction,
    required bool isFullRecording,
    required bool isUserAgentVoice,
  }) async {
    showLoading(true);

    try {
      final userName = await IndoSharedPreference.instance.getUserName();
      final token = await IndoSharedPreference.instance.getAccessToken();
      final responseData = await voiceAgentRepository.initiateWebhook(
        tanantId: AppConstents.tanantId,
        userName: userName,
        sessionId: sessionId,
        token: token,
        isUserVoice: isUserVoice,
        isAgentVoice: isAgentVoice,
        isUserTransaction: isUserTransaction,
        isAgentTransaction: isAgentTransaction,
        isFullRecording: isFullRecording,
        isUserAgentVoice: isUserAgentVoice,
      );
      if (responseData.statusCode == 200) {
        final result = responseData.data;
        if (result == null) {
          setError("Something went wrong");
          return false;
        }
        agentName.value = result.agentName ?? "";
        agentImage.value = result.agentImage ?? "";
        tenant.value = result.tenant ?? "";
        agentId.value = result.agent ?? "";
        streamId.value = result.streamSid ?? "";
        webhookResponse.value = result;
        return true;
      } else {
        setError(responseData.message ?? "Something went wrong");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      setError("Something went wrong");
      return false;
    } finally {
      showLoading(false);
    }
  }

  Future<bool> initializeAndStartCall({
    required String tenantIds,
    required String agentIds,
    required String streamIds,
  }) async {
    try {
      messageC.value = "";
      await socketController.connectSocket(
        tenantId: tenantIds,
        botId: agentIds,
        streamId: streamIds,
      );
      await playDuringCalling();
      await Future.delayed(const Duration(milliseconds: 300));
      final message = {
        "type": "start",
        "stream_sid": webhookResponse.value.streamSid,
        "transport": "webrtc_mobile",
      };
      debugPrint("Message $message");
      await socketController.sendMessage(message);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      setError("Failed to start call");
      return false;
    }
  }

  Future<bool> requestMicPermission() async {
    var status = await Permission.microphone.status;

    if (status.isGranted) return true;

    status = await Permission.microphone.request();

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }
}
