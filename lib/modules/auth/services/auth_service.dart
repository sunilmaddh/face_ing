// ignore: implementation_imports
import 'dart:io';

import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/modules/auth/models/error_response.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';
import 'package:ntt_data/modules/pulse/models/medical_question_model.dart';
import 'package:ntt_data/modules/auth/models/user_create_response_model.dart';

class AuthService {
  AuthService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<UserCreateResponseModel>> profileCreation({
    required String emailId,
    required String userId,
    required String name,
    required String genderType,
    required String weight,
    required String height,
    required String dob,
    required String userImage,
    required String smokerType,
    required List<Map<String, dynamic>> healthList,
  }) async {
    final data = {
      "userDao": {"emailId": emailId, "userId": userId},
      "perDetailsDao": {
        "userEmail": emailId,
        "password": "",
        "userName": name,
        "userGender": genderType,
        "userWeight": weight,
        "userHeight": height,
        "userDOB": dob,
        "userImage": userImage,
        "smokerType": smokerType,
      },
      "helthDetailsListDao": healthList,
    };

    return await apiService.send<UserCreateResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.continueSignUp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserCreateResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<LoginResponseModel>> userLogin({
    required String email,
    required String password,
  }) async {
    final data = {"emailId": email, "password": password, "sDKType": "BINAH"};
    return apiService.send<LoginResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.login,
        method: HttpMethod.post,
        body: data,
        requiresAuth: false,
      ),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> getForgotOtp({
    required String email,
  }) async {
    var data = {"emailId": email};
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.getforgetOtp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserAuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> verifyForgotOtp({
    required String emailId,
    required String otp,
    required String userId,
  }) async {
    var data = {"emailId": emailId, "otp": otp, "userId": userId};
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.verifyForgotOtp,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserAuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> resetPassword({
    required String emailId,
    required String password,
    required String confirmPassword,
    required String userId,
  }) async {
    var data = {
      "emailId": emailId,
      "password": password,
      "confirmPassword": confirmPassword,
      "userId": userId,
    };
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.resetPassword,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => UserAuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<MedicalQuestionModels>> getMedicalQeustionList() async {
    return await apiService.send<MedicalQuestionModels>(
      ApiRequest(
        endpoint: apiEndpoints.medicalQuestionList,
        method: HttpMethod.post,
      ),
      fromJson: (json) => MedicalQuestionModels.fromJson(json),
    );
  }

  // Future<ApiResponse<Map<String, dynamic>>> uploadDocument(
  //   String imagePath,
  //   String userID,
  //   String imageType,
  //   String guestId,
  //   String isGuest,
  // ) async {
  //   return await apiService.uploadImage(
  //     endpoint: apiEndpoints.profileUpload,
  //     filePath: imagePath,
  //     imageType: imageType,
  //     guestId: guestId,
  //     isGuest: isGuest,
  //   );
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
  // }
}
