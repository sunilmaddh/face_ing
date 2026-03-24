import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/ai_reccamandation_response.dart';
import 'package:ntt_data/modules/views/ai_recommendation/services/ai_advice_service.dart';

class AiAdviceRepository {
  AiAdviceRepository({required this.aiAdviceService});
  final AiAdviceService aiAdviceService;
  Future<ApiResponse<AiRecamendationResponse>> getAiAdvice() async {
    return aiAdviceService.getAiAdvice();
  }
}
