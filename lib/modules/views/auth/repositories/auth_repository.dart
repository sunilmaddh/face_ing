import 'dart:core';

import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/modules/views/auth/model/login_response_model.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/modules/views/auth/model/user_create_response_model.dart';
import 'package:ntt_data/modules/views/auth/services/auth_service.dart';

class AuthRepository {
  AuthRepository({required this.authService});
  final AuthService authService;

  Future<ApiResponse<LoginResponseModel>> login({required var data}) async {
    return await authService.userLogin(data: data);
  }

  Future<ApiResponse<UserCreateResponseModel>> createProfile({
    required var data,
  }) async {
    return await authService.profileCreation(data: data);
  }

  Future<ApiResponse<ErrorResponse>> getForgotOtp({required var data}) async {
    return await authService.getForgotOtp(data: data);
  }

  Future<ApiResponse<ErrorResponse>> verifyForgotOtp({
    required var data,
  }) async {
    return await authService.verifyForgotOtp(data: data);
  }

  Future<ApiResponse<ErrorResponse>> resetPassword({required var data}) async {
    return await authService.resetPassword(data: data);
  }

  Future<ApiResponse<MedicalQuestionModels>> getMedicalQuestionList({
    required var data,
  }) async {
    return await authService.getMedicalQeustionList(data: data);
  }

  Future<ApiResponse<Map<String, dynamic>>> uploadUserProfile({
    required String imagePath,
    required String userID,
    required String imageType,
    required String guestId,
    required String isGuest,
  }) async {
    return await authService.uploadDocument(
      imagePath,
      userID,
      imageType,
      guestId,
      isGuest,
    );
  }
}
