import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class VitalGraphServices extends BaseApiService {
  final apiEndpoints = ApiEndpoints();
  Future<Map<String, dynamic>> callVitalGraphApiServices({
    required var data,
  }) async {
    return postRequest(apiEndpoints.graphData, data: data);
  }
  
}
