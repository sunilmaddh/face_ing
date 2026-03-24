import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/data/models/pulse_survey_question_list_model.dart';

class PulseSurveyService {
  PulseSurveyService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();

  Future<ApiResponse<PulseSurveyQuestionListModel>>
  getPulseSurveyQuestionList() async {
    return await apiService.send<PulseSurveyQuestionListModel>(
      ApiRequest(
        endpoint: apiEndpoints.getPulseSurveyQuestionsForUser,
        method: HttpMethod.get,
      ),
      fromJson: (json) => PulseSurveyQuestionListModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> storePulseSurvey({required var data}) async {
    return apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.saveUserPulseSurvey,
        method: HttpMethod.post,
        body: data,
      ),
    );
  }

  Future<ApiResponse<PulseSurveyModel>> getPulseSurveyResult() async {
    return apiService.send<PulseSurveyModel>(
      ApiRequest(
        endpoint: apiEndpoints.pulseSurveyHome,
        method: HttpMethod.post,
      ),
      fromJson: (json) => PulseSurveyModel.fromJson(json),
    );
  }
}
