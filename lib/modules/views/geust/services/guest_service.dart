import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/guest_list_response_model.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';

class GuestService {
  GuestService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<GuestListResponseModel>> getGeustHistoryService({
    required var data,
  }) async {
    return await apiService.send<GuestListResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.listOfGeust,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => GuestListResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getGeustDetailsService({
    required var data,
  }) async {
    return await apiService.send<HealthDetailsResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.geustHistoryList,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => HealthDetailsResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> addGeustService({required var data}) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.addGeust,
        method: HttpMethod.post,
        body: data,
      ),
    );
  }

  Future<ApiResponse<void>> deleteGuest({required var data}) {
    return apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.deleteGuest,
        method: HttpMethod.post,
        body: data,
      ),
    );
  }

  Future<ApiResponse<void>> storeBinahHealthForUserService({
    required var data,
  }) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.storeSdkDataForUser,
        method: HttpMethod.post,
      ),
    );
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await apiService.send<UserHistoryListModel>(
      ApiRequest(
        endpoint: apiEndpoints.userHealthHistory,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserHistoryListModel.fromJson(json),
    );
  }
}
