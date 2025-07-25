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

  Future<Map<String, dynamic>> storeBinahHealthForUserService({
    required var data,
  }) {
    return postRequest(ApiEndpoints.storeSdkDataForUser, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await postRequest(ApiEndpoints.userHealthHistory, data: data);
  }
}
