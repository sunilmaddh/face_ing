import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsugi_result_response.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsungi_questionaries_response.dart';
import 'package:ntt_data/modules/phq/services/phq_service.dart';

class PhqRepository {
  PhqRepository({required this.phqService});
  final PhqService phqService;
  Future<ApiResponse<void>> submitAssessment({
    required List<int> phq2,
    required List<int> phq9,
    required List<int> gad7,
    String? sessionId,
  }) async {
    return await phqService.submitAssessment(
      phq2: phq2,
      phq9: phq9,
      gad7: gad7,
    );
  }

  Future<ApiResponse<KintsigiRusltResponse>> getResult(String sessionId) async {
    return await phqService.getResult(sessionId);
  }

  Future<ApiResponse<KintsigiRusltResponse>> getSession() async {
    return await phqService.getSession();
  }

  Future<ApiResponse<KintsigiQuestionariesResponse>>
  questionaryKintsugi() async {
    return await phqService.questionaryKintsugiApi();
  }
}
