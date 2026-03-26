import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsugi_initiate_response.dart';
import 'package:ntt_data/modules/voice_agent/model/webhook_response.dart';
import 'package:ntt_data/modules/voice_agent/services/voice_agent_service.dart';

class VoiceAgentRepository {
  VoiceAgentRepository({required this.voiceAgentService});

  final VoiceAgentService voiceAgentService;

  Future<ApiResponse<KintsigiInitiateResponse>> initiateKintsugiApi() async {
    return await voiceAgentService.initiateKintsugiApi();
  }

  Future<ApiResponse<WebhookResponse>> initiateWebhook({
    required String tanantId,
    required String userName,
    required String sessionId,
    required String token,
    required bool isUserVoice,
    required bool isAgentVoice,
    required bool isUserTransaction,
    required bool isAgentTransaction,
    required bool isFullRecording,
    required bool isUserAgentVoice,
  }) async {
    return await voiceAgentService.initiateWebhook(
      tanantId: tanantId,
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
  }
}
