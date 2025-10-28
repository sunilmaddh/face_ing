import 'dart:io';

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:http/src/response.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/data/repository/services/base_api_services.dart';

class AuthServices extends BaseApiService {
  final apiEndpoints = ApiEndpoints();

  Future<Map<String, dynamic>> getSignUpOtp({required var data}) async {
    return await postRequest(apiEndpoints.signUp, data: data);
  }

  Future<Map<String, dynamic>> verifySignUpOtp({required var data}) async {
    return await postRequest(apiEndpoints.verifySignUpOtp, data: data);
  }

  Future<Map<String, dynamic>> profileCreation({required var data}) async {
    return await postRequest(apiEndpoints.continueSignUp, data: data);
  }

  Future<Map<String, dynamic>> userLogin({required var data}) async {
    return await loginPostRequest(apiEndpoints.login, data: data);
  }

  Future<Map<String, dynamic>> getForgotOtp({required var data}) async {
    return await postRequest(apiEndpoints.getforgetOtp, data: data);
  }

  Future<Map<String, dynamic>> verifyForgotOtp({required var data}) async {
    return await postRequest(apiEndpoints.verifyForgotOtp, data: data);
  }

  Future<Map<String, dynamic>> resetPassword({required var data}) async {
    return await postRequest(apiEndpoints.resetPassword, data: data);
  }

  Future<Map<String, dynamic>> getMedicalQeustionList({
    required var data,
  }) async {
    return await postRequest(apiEndpoints.medicalQuestionList, data: data);
  }

  Future<Map<String, dynamic>> uploadDocument(
    File? imagePath,
    String userID,
    String imageType,
    String guestId,
    String isGuest,
  ) async {
    Response? response = await uploadImage(
      apiEndpoints.profileUpload,
      imagePath!.path,
      userID,
      imageType,
      guestId,
      isGuest,
    );
    debugPrint(
      "ResponseCode: ${response!.statusCode}= ResponseBody${response.body}",
    );
    Map<String, dynamic> responseData = {'responseCode': response.statusCode};
    if (response.statusCode == 200) {
      var resjson = response.body;
      responseData.putIfAbsent(
        'response',
        () => uploadImageResponseModelFromJson(resjson),
      );
    } else {
      // AppSnackbar.show(title: "Error", message: response.body.toString());
    }
    return responseData;
  }
}
