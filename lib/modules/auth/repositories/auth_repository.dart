import 'dart:core';

import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/auth/models/error_response.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';
import 'package:ntt_data/modules/pulse/models/medical_question_model.dart';
import 'package:ntt_data/modules/auth/models/user_create_response_model.dart';
import 'package:ntt_data/modules/auth/services/auth_service.dart';

class AuthRepository {
  AuthRepository({required this.authService});
  final AuthService authService;

  Future<ApiResponse<LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    return await authService.userLogin(email: email, password: password);
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
    required List<Map<String, dynamic>> healthList,
  }) async {
    return await authService.profileCreation(
      emailId: emailId,
      userId: userId,
      name: name,
      genderType: genderType,
      weight: weight,
      height: height,
      dob: dob,
      userImage: userImage,
      smokerType: smokerType,
      healthList: healthList,
    );
  }

  Future<ApiResponse<UserAuthResponse>> getForgotOtp({
    required String email,
  }) async {
    return await authService.getForgotOtp(email: email);
  }

  Future<ApiResponse<UserAuthResponse>> verifyForgotOtp({
    required String emailId,
    required String otp,
    required String userId,
  }) async {
    return await authService.verifyForgotOtp(
      emailId: emailId,
      otp: otp,
      userId: userId,
    );
  }

  Future<ApiResponse<UserAuthResponse>> resetPassword({
    required String emailId,
    required String password,
    required String confirmPassword,
    required String userId,
  }) async {
    return await authService.resetPassword(
      emailId: emailId,
      password: password,
      confirmPassword: confirmPassword,
      userId: userId,
    );
  }

  Future<ApiResponse<MedicalQuestionModels>> getMedicalQuestionList() async {
    return await authService.getMedicalQeustionList();
  }

  // Future<ApiResponse<Map<String, dynamic>>> uploadUserProfile({
  //   required String imagePath,
  //   required String userID,
  //   required String imageType,
  //   required String guestId,
  //   required String isGuest,
  // }) async {
  //   return await authService.uploadDocument(
  //     imagePath,
  //     userID,
  //     imageType,
  //     guestId,
  //     isGuest,
  //   );
  // }
}
