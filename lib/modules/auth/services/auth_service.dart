// ignore: implementation_imports

import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/modules/auth/models/error_response.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';
import 'package:ntt_data/modules/auth/models/requests/forgot_otp_request.dart';
import 'package:ntt_data/modules/auth/models/requests/login_request.dart';
import 'package:ntt_data/modules/auth/models/requests/profile_creation_request.dart';
import 'package:ntt_data/modules/auth/models/requests/reset_password_request.dart';
import 'package:ntt_data/modules/auth/models/requests/upload_image_request.dart';
import 'package:ntt_data/modules/auth/models/requests/verify_otp_request.dart';
import 'package:ntt_data/modules/auth/models/user_create_response_model.dart';
import 'package:ntt_data/modules/pulse/models/medical_question_model.dart';

class AuthService {
  AuthService({required this.apiService});

  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();

  Future<ApiResponse<UserCreateResponseModel>> profileCreation({
    required ProfileCreationRequest request,
  }) async {
    return await apiService.send<UserCreateResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.continueSignUp,
        method: HttpMethod.post,
        body: request.toJson(),
      ),
      fromJson: (json) => UserCreateResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<LoginResponseModel>> userLogin({
    required LoginRequest request,
  }) async {
    return apiService.send<LoginResponseModel>(
      ApiRequest(
        endpoint: apiEndpoints.login,
        method: HttpMethod.post,
        body: request.toJson(),
        requiresAuth: false,
      ),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> getForgotOtp({
    required ForgotOtpRequest request,
  }) async {
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.getforgetOtp,
        method: HttpMethod.post,
        body: request.toJson(),
      ),
      fromJson: (json) => UserAuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> verifyForgotOtp({
    required VerifyForgotOtpRequest request,
  }) async {
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.verifyForgotOtp,
        method: HttpMethod.post,
        body: request.toJson(),
      ),
      fromJson: (json) => UserAuthResponse.fromJson(json),
    );
  }

  Future<ApiResponse<UserAuthResponse>> resetPassword({
    required ResetPasswordRequest request,
  }) async {
    return await apiService.send<UserAuthResponse>(
      ApiRequest(
        endpoint: apiEndpoints.resetPassword,
        method: HttpMethod.post,
        body: request.toJson(),
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

  Future<ApiResponse<UploadImageResponseModel>> uploadImage({
    required UploadImageRequest request,
  }) async {
    return await apiService.uploadImage<UploadImageResponseModel>(
      endpoint: ApiEndpoints().profileUpload,
      filePath: request.filePath,
      imageType: request.imageType,
      guestId: "",
      isGuest: "false",
      fromJson:
          (Map<String, dynamic> json) =>
              UploadImageResponseModel.fromJson(json),
    );
  }
}
