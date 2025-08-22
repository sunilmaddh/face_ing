import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class VitalGraphServices extends BaseApiService {
  Future<Map<String, dynamic>> callVitalGraphApiServices({
    required var data,
  }) async {
    return postRequest(ApiEndpoints.graphData, data: data);
  }
}
