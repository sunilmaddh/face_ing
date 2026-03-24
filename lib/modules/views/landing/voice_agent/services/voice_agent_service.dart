import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/kintsugi_initiate_response.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/model/webhook_response.dart';

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
    required var data,
  }) async {
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
