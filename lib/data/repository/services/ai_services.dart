import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class AiServices extends BaseApiService {
  final apiEndpoints = ApiEndpoints();

  Future<Map<String, dynamic>> aiRecamendation() async {
    return await postRequest(apiEndpoints.voiceAgent, data: null);
  }
}
