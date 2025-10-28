import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class GeustServices extends BaseApiService {
  final apiEndpoints = ApiEndpoints();
  Future<Map<String, dynamic>> getGeustHistoryService({required var data}) {
    return postRequest(apiEndpoints.listOfGeust, data: data);
  }

  Future<Map<String, dynamic>> getGeustDetailsService({required var data}) {
    return postRequest(apiEndpoints.geustHistoryList, data: data);
  }

  Future<Map<String, dynamic>> addGeustService({required var data}) {
    return postRequest(apiEndpoints.addGeust, data: data);
  }

  Future<Map<String, dynamic>> deleteGuest({required var data}) {
    return postRequest(apiEndpoints.deleteGuest, data: data);
  }

  Future<Map<String, dynamic>> storeBinahHealthForUserService({
    required var data,
  }) {
    return postRequest(apiEndpoints.storeSdkDataForUser, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.userHealthHistory, data: data);
  }
}
