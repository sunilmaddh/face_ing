import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/kintsugi_result_response.dart';
import 'package:ntt_data/data/models/kintsungi_questionaries_response.dart';

class PhqService {
  PhqService({required this.apiService});
  final ApiService apiService;
  final apiEndPoints = ApiEndpoints();

  Future<ApiResponse<void>> submitAssessment({
    required List<int> phq2,
    required List<int> phq9,
    required List<int> gad7,
    String? sessionId,
  }) async {
    final data = {"phq2": phq2, "phq9": phq9, "gad7": gad7};
    return await apiService.send(
      ApiRequest(
        endpoint: "${apiEndPoints.kintsugiQuestionnaires}/$sessionId",
        method: HttpMethod.post,
        body: data,
      ),
    );
  }

  Future<ApiResponse<KintsigiRusltResponse>> getResult(String sessionId) async {
    return await apiService.send(
      ApiRequest(
        endpoint: "${apiEndPoints.kintsugiResult}/$sessionId",
        method: HttpMethod.get,
      ),
      fromJson: (json) => KintsigiRusltResponse.fromJson(json),
    );
  }

  Future<ApiResponse<KintsigiRusltResponse>> getSession() async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndPoints.kintsugiSessions,
        method: HttpMethod.get,
      ),
      fromJson: (json) => KintsigiRusltResponse.fromJson(json),
    );
  }

  Future<ApiResponse<KintsigiQuestionariesResponse>>
  questionaryKintsugiApi() async {
    return apiService.send<KintsigiQuestionariesResponse>(
      ApiRequest(
        endpoint: apiEndPoints.kintsugiQuestionnaires,
        method: HttpMethod.get,
      ),
      fromJson: (json) => KintsigiQuestionariesResponse.fromJson(json),
    );
  }
}
