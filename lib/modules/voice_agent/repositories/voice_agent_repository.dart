import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsugi_initiate_response.dart';
import 'package:ntt_data/modules/voice_agent/model/request/voice_webhook_request.dart';
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
    required VoiceWebhookRequest request,
  }) async {
    return await voiceAgentService.initiateWebhook(
      tanantId: tanantId,
      request: request,
    );
  }
}
