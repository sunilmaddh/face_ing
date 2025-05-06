import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class GeustServices extends BaseApiService {
  Future<Map<String, dynamic>> getGeustHistoryService() {
    return getRequest(ApiEndpoints.geustHistoryList);
  }
}
