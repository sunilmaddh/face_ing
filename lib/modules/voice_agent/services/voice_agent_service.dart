import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsugi_initiate_response.dart';
import 'package:ntt_data/modules/voice_agent/model/webhook_response.dart';

class VoiceAgentService {
  VoiceAgentService({required this.apiService});
  final ApiService apiService;
  final apiEndpoint = ApiEndpoints();

  Future<ApiResponse<KintsigiInitiateResponse>> initiateKintsugiApi() async {
    return apiService.send<KintsigiInitiateResponse>(
      ApiRequest(
        endpoint: apiEndpoint.kintsugiInitiate,
        method: HttpMethod.get,
      ),
      fromJson: (json) => KintsigiInitiateResponse.fromJson(json),
    );
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
    final data = {
      "agent_id": "2f0817e4-6585-4ebe-8a0a-29f09652ef00",
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

    return await apiService.send<WebhookResponse>(
      ApiRequest(
        endpoint: "${apiEndpoint.initiateWebhook}/$tanantId/",
        method: HttpMethod.post,
        body: data,
        useVoiceBaseUrl: true,
        isHttps: true,
      ),
      fromJson: (json) => WebhookResponse.fromJson(json),
    );
  }
}
