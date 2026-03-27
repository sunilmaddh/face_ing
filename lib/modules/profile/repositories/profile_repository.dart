import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/requets/update_details_request.dart';
import 'package:ntt_data/modules/profile/models/requets/user_health_details_request.dart';
import 'package:ntt_data/modules/profile/models/requets/user_history_request.dart';
import 'package:ntt_data/modules/profile/models/requets/vital_description_request.dart';
import 'package:ntt_data/modules/profile/models/update_details_response_model.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';
import 'package:ntt_data/modules/profile/models/vital_descriptions_model.dart';
import 'package:ntt_data/modules/profile/services/profile_service.dart';

class ProfileRepository {
  ProfileRepository({required this.profileService});
  final ProfileService profileService;
  Future<ApiResponse<void>> storeUserHealthData({required var data}) async {
    return await profileService.storeUserHealthDataService(data: data);
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistory({
    required UserHistoryRequest data,
  }) async {
    return await profileService.getUserHealthHistoryService(
      data: data.toJson(),
    );
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getUserHealthDetails({
    required UserHealthDetailsRequest data,
  }) async {
    return await profileService.getUserHealthDetailsService(
      data: data.toJson(),
    );
  }

  Future<ApiResponse<UpdateDetailsResponseModel>> updateDetailsUG({
    required UpdateDetailsRequest data,
  }) async {
    return await profileService.updateDetailsUGService(data: data.toJson());
  }

  Future<ApiResponse<VitalDescriptionsModel>> getVitalDescription({
    required VitalDescriptionRequest data,
  }) async {
    return await profileService.getVitalDescriptionService(data: data.toJson());
  }

  Future<ApiResponse<UploadImageResponseModel>> uploadImage({
    required String filePath,
    required String imageType,
  }) async {
    return await profileService.uploadImage(
      filePath: filePath,
      imageType: imageType,
    );
  }

  Future<ApiResponse<void>> logoutUser() async {
    return await profileService.logoutUserService();
  }
}
