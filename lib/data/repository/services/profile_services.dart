import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class ProfileServices extends BaseApiService {
  final apiEndpoints = ApiEndpoints();
  Future<Map<String, dynamic>> getMedicalQeustionList() async {
    return await postRequestWithoutBody(apiEndpoints.medicalQuestionList);
  }

  Future<Map<String, dynamic>> profileCreation({required var data}) async {
    return await postRequest(apiEndpoints.continueSignUp, data: data);
  }

  Future<Map<String, dynamic>> storeUserHealthDataService({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.storeSdkDataForUser, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.userHealthHistory, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthDetailsService({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.userHealthDetails, data: data);
  }

  Future<Map<String, dynamic>> updateDetailsUGService({
    required var data,
  }) async {
    return await putRequest(apiEndpoints.updatePersonalDetails, data);
  }

  Future<Map<String, dynamic>> getVitalDescriptionService({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.getVitalDescryption, data: data);
  }

  Future<Map<String, dynamic>> logoutUserService() async {
    return await postRequest(apiEndpoints.logoutUser, data: {});
  }
}
