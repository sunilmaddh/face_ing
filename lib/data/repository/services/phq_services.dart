import '../services/base_api_services.dart';

class PhqServices extends BaseApiService {
  Future<Map<String, dynamic>> submitAssessment({
    required List<int> phq2,
    required List<int> phq9,
    required List<int> gad7,
    String? sessionId
  }) async {
    final data = {
      "phq2": phq2,
      "phq9": phq9,
      "gad7": gad7,
    };
    return await postRequest('/kintsugi/submit-questionnaires/$sessionId', data: data);
  }

  Future<Map<String, dynamic>> getResult(String sessionId) async {
    return await getRequest('/kintsugi/result/$sessionId');
  }
}
