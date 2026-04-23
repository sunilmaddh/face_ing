import 'dart:convert';

import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/env_config.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/storage/secure_storage.dart';
import 'package:ntt_data/core/utils/app_logger.dart';
import 'package:ntt_data/modules/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/voice_agent/helper/audio_player.dart';
import 'package:ntt_data/modules/voice_agent/model/request/start_streaming_request.dart';
import 'package:ntt_data/modules/voice_agent/model/request/voice_call_request.dart';
import 'package:ntt_data/modules/voice_agent/model/request/voice_webhook_request.dart';
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

  Future<bool> getCredentials({required VoiceCallRequest request}) async {
    showLoading(true);
    try {
      final userName = AppPreferences.instance.getUserName();
      final token = await SecureStorageService.instance.getAccessToken();
      final requestData = VoiceWebhookRequest(
        agentId: ApiConstants.agentId,
        userName: userName,
        isUserVoice: request.isUserVoice,
        isAgentVoice: request.isAgentVoice,
        isUserTranscription: request.isUserTransaction,
        isAgentTranscription: request.isAgentTransaction,
        isFullRecording: request.isFullRecording,
        isUserAgentVoice: request.isUserAgentVoice,
        sessionId: request.sessionId,
        sessionToken: token,
        sessionUrl: ApiEndpoints.sessionUrl,
      );
      final responseData = await voiceAgentRepository.initiateWebhook(
        tanantId: ApiConstants.tenantId,
        request: requestData,
      );
      if (responseData.statusCode == 200) {
        final result = responseData.data;
        if (result == null) {
          setError(ValidationStrings.commonErrorMessage);
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
        setError(responseData.message);
        return false;
      }
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
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
      final message = StartStreamRequest(
        streamSid: webhookResponse.value.streamSid ?? "",
      );
      await socketController.sendMessage(message.toJson());
      return true;
    } catch (e) {
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
