// ignore: implementation_imports
import 'dart:io';

import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/modules/views/auth/model/login_response_model.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/modules/views/auth/model/user_create_response_model.dart';

class AuthService {
  AuthService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();

  // Future<Map<String, dynamic>> getSignUpOtp({required var data}) async {
  //   return await postRequest(apiEndpoints.signUp, data: data);
  // }

  // Future<Map<String, dynamic>> verifySignUpOtp({required var data}) async {
  //   return await postRequest(apiEndpoints.verifySignUpOtp, data: data);
  // }

  Future<ApiResponse<UserCreateResponseModel>> profileCreation({
    required var data,
  }) async {
    return await apiService.send<UserCreateResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.continueSignUp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserCreateResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<LoginResponseModel>> userLogin({required var data}) async {
    return apiService.send<LoginResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.login,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<ErrorResponse>> getForgotOtp({required var data}) async {
    return await apiService.send<ErrorResponse>(
      ApiRequest(
        endpoint: apiEndpoints.getforgetOtp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => ErrorResponse.fromJson(json),
    );
  }

  Future<ApiResponse<ErrorResponse>> verifyForgotOtp({
    required var data,
  }) async {
    return await apiService.send<ErrorResponse>(
      ApiRequest(
        endpoint: apiEndpoints.verifyForgotOtp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => ErrorResponse.fromJson(json),
    );
  }

  Future<ApiResponse<ErrorResponse>> resetPassword({required var data}) async {
    return await apiService.send<ErrorResponse>(
      ApiRequest(
        endpoint: apiEndpoints.resetPassword,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => ErrorResponse.fromJson(json),
    );
  }

  Future<ApiResponse<MedicalQuestionModels>> getMedicalQeustionList({
    required var data,
  }) async {
    return await apiService.send<MedicalQuestionModels>(
      ApiRequest(
        endpoint: apiEndpoints.medicalQuestionList,
        method: HttpMethod.post,
      ),
      fromJson: (json) => MedicalQuestionModels.fromJson(json),
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> uploadDocument(
    String imagePath,
    String userID,
    String imageType,
    String guestId,
    String isGuest,
  ) async {
    return await apiService.uploadImage(
      endpoint: apiEndpoints.profileUpload,
      filePath: imagePath,
      imageType: imageType,
      guestId: guestId,
      isGuest: isGuest,
    );
    // Response? response = await apiService. uploadImage(
    //   apiEndpoints.profileUpload,
    //   imagePath!.path,
    //   userID,
    //   imageType,
    //   guestId,
    //   isGuest,
    // );
    // debugPrint(
    //   "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}",
    // );
    // Map<String, dynamic> responseData = {'responseCode': response.statusCode};
    // if (response.statusCode == 200) {
    //   var resjson = response.body;
    //   responseData.putIfAbsent(
    //     'response',
    //     () => uploadImageResponseModelFromJson(resjson),
    //   );
    // } else {
    //   // AppSnackbar.show(title: "Error", message: response.body.toString());
    // }
    // return responseData;
  }
}
