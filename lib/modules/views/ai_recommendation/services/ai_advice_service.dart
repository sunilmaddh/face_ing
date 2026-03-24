import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/ai_reccamandation_response.dart';

class AiAdviceService {
  AiAdviceService({required this.apiService});
  final ApiService apiService;
  Future<ApiResponse<AiRecamendationResponse>> getAiAdvice() async {
    return apiService.send<AiRecamendationResponse>(
      ApiRequest(
        endpoint: ApiEndpoints().voiceAgent,
        method: HttpMethod.post,
        body: {},
        requiresAuth: false,
        encryptBody: true,
      ),
      fromJson: (json) => AiRecamendationResponse.fromJson(json),
    );
  }
}
