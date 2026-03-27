import 'dart:core';

import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/modules/auth/models/error_response.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';
import 'package:ntt_data/modules/auth/models/requests/forgot_otp_request.dart';
import 'package:ntt_data/modules/auth/models/requests/login_request.dart';
import 'package:ntt_data/modules/auth/models/requests/medical_question_answer_request.dart';
import 'package:ntt_data/modules/auth/models/requests/per_details_doa_request.dart';
import 'package:ntt_data/modules/auth/models/requests/profile_creation_request.dart';
import 'package:ntt_data/modules/auth/models/requests/reset_password_request.dart';
import 'package:ntt_data/modules/auth/models/requests/upload_image_request.dart';
import 'package:ntt_data/modules/auth/models/requests/user_doa_request.dart';
import 'package:ntt_data/modules/auth/models/requests/verify_otp_request.dart';
import 'package:ntt_data/modules/auth/models/user_create_response_model.dart';
import 'package:ntt_data/modules/auth/services/auth_service.dart';
import 'package:ntt_data/modules/pulse/models/medical_question_model.dart';

class AuthRepository {
  AuthRepository({required this.authService});

  final AuthService authService;

  Future<ApiResponse<LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(emailId: email, password: password);

    return await authService.userLogin(request: request);
  }

  Future<ApiResponse<UserCreateResponseModel>> createProfile({
    required String emailId,
    required String userId,
    required String name,
    required String genderType,
    required String weight,
    required String height,
    required String dob,
    required String userImage,
    required String smokerType,
    required List<MedicalQuestionAnswerRequest> healthList,
  }) async {
    final request = ProfileCreationRequest(
      userDao: UserDaoRequest(emailId: emailId, userId: userId),
      perDetailsDao: PerDetailsDaoRequest(
        userEmail: emailId,
        userName: name,
        userGender: genderType,
        userWeight: weight,
        userHeight: height,
        userDOB: dob,
        userImage: userImage,
        smokerType: smokerType,
      ),
      helthDetailsListDao: healthList,
    );

    return await authService.profileCreation(request: request);
  }

  Future<ApiResponse<UserAuthResponse>> getForgotOtp({
    required String email,
  }) async {
    final request = ForgotOtpRequest(emailId: email);

    return await authService.getForgotOtp(request: request);
  }

  Future<ApiResponse<UserAuthResponse>> verifyForgotOtp({
    required String emailId,
    required String otp,
    required String userId,
  }) async {
    final request = VerifyForgotOtpRequest(
      emailId: emailId,
      otp: otp,
      userId: userId,
    );

    return await authService.verifyForgotOtp(request: request);
  }

  Future<ApiResponse<UserAuthResponse>> resetPassword({
    required String emailId,
    required String password,
    required String confirmPassword,
    required String userId,
  }) async {
    final request = ResetPasswordRequest(
      emailId: emailId,
      password: password,
      confirmPassword: confirmPassword,
      userId: userId,
    );

    return await authService.resetPassword(request: request);
  }

  Future<ApiResponse<UploadImageResponseModel>> uploadImage({
    required String filePath,
    required String imageType,
  }) async {
    final request = UploadImageRequest(
      filePath: filePath,
      imageType: imageType,
    );

    return await authService.uploadImage(request: request);
  }

  Future<ApiResponse<MedicalQuestionModels>> getMedicalQuestionList() async {
    return await authService.getMedicalQeustionList();
  }
}
