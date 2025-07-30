import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class ProfileServices extends BaseApiService {
  Future<Map<String, dynamic>> getMedicalQeustionList() async {
    return await postRequestWithoutBody(ApiEndpoints.medicalQuestionList);
  }

  Future<Map<String, dynamic>> profileCreation({required var data}) async {
    return await postRequest(ApiEndpoints.continueSignUp, data: data);
  }

  Future<Map<String, dynamic>> storeUserHealthDataService({
    required var data,
  }) async {
    return await postRequest(ApiEndpoints.storeSdkDataForUser, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthHistoryService({
    required var data,
  }) async {
    return await postRequest(ApiEndpoints.userHealthHistory, data: data);
  }

  Future<Map<String, dynamic>> getUserHealthDetailsService({
    required var data,
  }) async {
    return await postRequest(ApiEndpoints.userHealthDetails, data: data);
  }

  Future<Map<String, dynamic>> updateDetailsUGService({
    required var data,
  }) async {
    return await putRequest(ApiEndpoints.updatePersonalDetails, data);
  }

  Future<Map<String, dynamic>> getVitalDescriptionService({
    required var data,
  }) async {
    return await postRequest(ApiEndpoints.getVitalDescryption, data: data);
  }
}
