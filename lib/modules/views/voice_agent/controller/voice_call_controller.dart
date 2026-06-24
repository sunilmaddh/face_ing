import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_player.dart';
import 'package:ntt_data/modules/views/voice_agent/services/base_api_service.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/model/webhook_response.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceCallController extends GetxController {
  final socketController = Get.put(SocketController());
  RxString messageC = "".obs;
  RxString agentName = "".obs;
  RxString agentImage = "".obs;
  RxString tenant = "".obs;
  RxString agentId = "".obs;
  RxString streamId = "".obs;
  RxBool isConverssionStarted = false.obs;
  Rx<WebhookResponse> webhookResponse = WebhookResponse().obs;
  @override
  void onInit() async {
    await requestMicPermission();
    super.onInit();
  }

  void setConverssionFlag() {
    isConverssionStarted(true);
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
    try {
      var userName = await IndoSharedPreference.instance.getUserName();
      var token = await IndoSharedPreference.instance.getAccessToken();
      var data = {
        "agent_id": "c899cabb-39d7-423f-ad83-a40ef2ed1115",
        // "2f0817e4-6585-4ebe-8a0a-29f09652ef00",
        "user_name": userName,
        "is_user_voice": isUserVoice,
        "is_agent_voice": isAgentVoice,
        "is_user_transcription": isUserTransaction,
        "is_agent_transcription": isAgentTransaction,
        "is_full_recording": isFullRecording,
        "is_user_agent_voice": isUserAgentVoice,
        "session_id": sessionId,
        "session_token": token,
        "session_url": "http://${ApiEndpoints.baseUrl}/kintsugi/submit-audio",
        "session_user_duration": 60,
      };
      debugPrint(data.toString());
      Map<String, dynamic> resposneData = await BaseVoiceApiService()
          .postRequest(data: data, userName: '');
      int statusCode = resposneData["statusCode"];
      if (statusCode == 200) {
        var result = webhookResponseFromJson(resposneData["responseBody"]);
        agentName.value = result.agentName!;
        agentImage.value = result.agentImage!;
        tenant.value = result.tenant!;
        agentId.value = result.agent!;
        streamId.value = result.streamSid!;
        webhookResponse.value = result;

        return true;
      } else if (statusCode == 500) {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
        return false;
      } else {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> initializeAndStartCall({
    required String tenantIds,
    required String agentIds,
    required String streamIds,
  }) async {
    try {
      messageC.value = "";
      await Get.find<SocketController>().connectSocket(
        tenantId: "61a4dd35-338d-401a-a2fa-946b654a91f8",
        botId: "c899cabb-39d7-423f-ad83-a40ef2ed1115",
        streamId: streamIds,
      );
      await playDuringCalling();
      await Future.delayed(Duration(milliseconds: 300));
      final message = {
        "type": "start",
        "stream_sid": webhookResponse.value.streamSid,
        "transport": "webrtc_mobile",
      };
      debugPrint("Message $message");
      await Get.find<SocketController>().sendMessage(message);
      return true;
    } catch (e) {
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
