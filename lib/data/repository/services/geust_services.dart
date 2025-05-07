import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class GeustServices extends BaseApiService {
  Future<Map<String, dynamic>> getGeustHistoryService({required var data}) {
    return postRequest(ApiEndpoints.listOfGeust, data: data);
  }

  Future<Map<String, dynamic>> getGeustDetailsService({required var data}) {
    return postRequest(ApiEndpoints.geustHistoryList, data: data);
  }

  Future<Map<String, dynamic>> addGeustService({required var data}) {
    return postRequest(ApiEndpoints.addGeust, data: data);
  }

  Future<Map<String, dynamic>> deleteGuest({required var data}) {
    return postRequest(ApiEndpoints.deleteGuest, data: data);
  }
}
