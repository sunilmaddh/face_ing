// import 'package:ntt_data/core/utils/api_endpoints.dart';
// import 'package:ntt_data/data/repository/services/base_api_services.dart';

// class VoiceService extends BaseApiService {
//   Future<Map<String, dynamic>> initiateKintsugiApi() async {
//     return getRequest(ApiEndpoints().kintsugiInitiate);
//   }

//   Future<Map<String, dynamic>> questionaryKintsugiApi() async {
//     return getRequest(ApiEndpoints().kintsugiQuestionnaires);
//   }

//   Future<Map<String, dynamic>> initiateWebhook({
//     required String tanantId,
//     required var data,
//   }) async {
//     return postVoiceRequest(
//       "${ApiEndpoints().initiateWebhook}/$tanantId",
//       data: data,
//     );
//   }
// }
