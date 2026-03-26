import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/modules/geust/models/guest_list_response_model.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';

class GuestService {
  GuestService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<GuestListResponseModel>> getGeustHistoryService({
    required String userId,
  }) async {
    var data = {"userId": userId};
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
    required String userId,
    required String guestId,
    required String scanId,
    required bool isFullHistory,
  }) async {
    final data = {
      "userId": userId,
      "guestId": guestId,
      "healthId": scanId,
      "isFullHistory": isFullHistory,
    };
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

  Future<ApiResponse<void>> deleteGuest({
    required String userId,
    required String guestId,
  }) async {
    final data = {"userId": userId, "guestId": guestId};
    return await apiService.send(
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
    required String userId,
    required String isUser,
    required String guestId,
  }) async {
    var data = {"userId": userId, "guestId": guestId, "isUser": isUser};
    return await apiService.send<UserHistoryListModel>(
      ApiRequest(
        endpoint: apiEndpoints.userHealthHistory,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserHistoryListModel.fromJson(json),
    );
  }

  Future<ApiResponse<UploadImageResponseModel>> uploadImage({
    required String filePath,
    required String imageType,
  }) async {
    return await apiService.uploadImage<UploadImageResponseModel>(
      endpoint: ApiEndpoints().profileUpload,
      filePath: filePath,
      imageType: imageType,
      guestId: "",
      isGuest: "false",
      fromJson:
          (Map<String, dynamic> json) =>
              UploadImageResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> logoutUserService() async {
    return await apiService.send(
      ApiRequest(endpoint: apiEndpoints.logoutUser, method: HttpMethod.post),
    );
  }
}
