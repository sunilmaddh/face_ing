// import 'package:ntt_data/core/utils/api_endpoints.dart';
// import 'package:ntt_data/data/repository/services/base_api_services.dart';

// class PulseServices extends BaseApiService {
//   final apiEndpoints = ApiEndpoints();
//   Future<Map<String, dynamic>> getPulseQuestionListServices() async {
//     return await getRequest(apiEndpoints.getPulseSurveyQuestionsForUser);
//   }

//   Future<Map<String, dynamic>> savePulseServeyServices({
//     required List<Map<String, dynamic>> data,
//   }) async {
//     return await postRequest(apiEndpoints.saveUserPulseSurvey, data: data);
//   }

//   Future<Map<String, dynamic>> fetchPulseServeyServices({
//     required List<Map<String, dynamic>> data,
//   }) async {
//     return await postRequest(apiEndpoints.pulseSurveyHome, data: data);
//   }
// }
