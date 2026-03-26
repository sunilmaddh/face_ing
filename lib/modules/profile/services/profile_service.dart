import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/update_details_response_model.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';
import 'package:ntt_data/modules/profile/models/vital_descriptions_model.dart';

class ProfileService {
  ProfileService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();

  Future<ApiResponse<void>> storeUserHealthDataService({
    required var data,
  }) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.storeSdkDataForUser,
        method: HttpMethod.post,
        body: data,
      ),
    );
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.userHealthHistory,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserHistoryListModel.fromJson(json),
    );
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getUserHealthDetailsService({
    required var data,
  }) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.userHealthDetails,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => HealthDetailsResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<UpdateDetailsResponseModel>> updateDetailsUGService({
    required var data,
  }) async {
    return await apiService.send<UpdateDetailsResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.updatePersonalDetails,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UpdateDetailsResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<VitalDescriptionsModel>> getVitalDescriptionService({
    required var data,
  }) async {
    return await apiService.send<VitalDescriptionsModel>(
      ApiRequest(
        endpoint: apiEndpoints.getVitalDescryption,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => VitalDescriptionsModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> logoutUserService() async {
    return await apiService.send(
      ApiRequest(endpoint: apiEndpoints.logoutUser, method: HttpMethod.post),
    );
  }
}
