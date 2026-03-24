import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/update_details_response_model.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/data/models/vital_descriptions_model.dart';
import 'package:ntt_data/modules/views/profile/services/profile_service.dart';

class ProfileRepository {
  ProfileRepository({required this.profileService});
  final ProfileService profileService;
  Future<ApiResponse<void>> storeUserHealthData({required var data}) async {
    return await profileService.storeUserHealthDataService(data: data);
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistory({
    required var data,
  }) async {
    return await profileService.getUserHealthHistoryService(data: data);
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getUserHealthDetails({
    required var data,
  }) async {
    return await profileService.getUserHealthDetailsService(data: data);
  }

  Future<ApiResponse<UpdateDetailsResponseModel>> updateDetailsUG({
    required var data,
  }) async {
    return await profileService.updateDetailsUGService(data: data);
  }

  Future<ApiResponse<VitalDescriptionsModel>> getVitalDescription({
    required var data,
  }) async {
    return await profileService.getVitalDescriptionService(data: data);
  }

  Future<ApiResponse<void>> logoutUser() async {
    return await profileService.logoutUserService();
  }
}
