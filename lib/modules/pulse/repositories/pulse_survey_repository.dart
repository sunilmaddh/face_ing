import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/modules/pulse/models/requests/pulse_survey_answer_request.dart';
import 'package:ntt_data/modules/pulse/service/pulse_survey_service.dart';

class PulseSurveyRepository {
  PulseSurveyRepository({required this.pulseSurveyService});
  final PulseSurveyService pulseSurveyService;

  Future<ApiResponse<PulseSurveyQuestionListModel>>
  getPulseSurveyQuestionList() async {
    return pulseSurveyService.getPulseSurveyQuestionList();
  }

  Future<ApiResponse<void>> storePulseSurvey({
    required List<PulseSurveyAnswerRequest> data,
  }) async {
    return await pulseSurveyService.storePulseSurvey(
      data: data.map((e) => e.toJson()).toList(),
    );
  }

  Future<ApiResponse<PulseSurveyModel>> getPulseSurveyResult() async {
    return await pulseSurveyService.getPulseSurveyResult();
  }
}
