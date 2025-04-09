import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/repository/services/auth_services.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';
import 'package:ntt_data/data/repository/services/profile_upload_services.dart';

class ProfileController extends GetxController {
  final _authController = Get.find<AuthController>();
  RxBool isGenderType = false.obs;
  RxBool isLoading = false.obs;
  RxString selectionType = "".obs;
  Rx<File> profileUrl = File("").obs;
  RxString userID = ''.obs;
  Map<String, dynamic> selectedAnswerList = {};
  List<Map<String, dynamic>> medicalQuestionData = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  Rx<AnlyzeHealthDataResponseModel> anlyzeHealthDataResponseModel =
      AnlyzeHealthDataResponseModel().obs;
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  RxList<MedicalQuestionListModel> medicalQuestionListModel =
      <MedicalQuestionListModel>[].obs;
  final ProfileUploadService _uploadService = ProfileUploadService();
  final _profileService = Get.put(ProfileServices());
  Future<void> getMedicalQeustionList() async {
    isLoading(true);
    try {
      Map<String, dynamic> response =
          await _profileService.getMedicalQeustionList();
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = MedicalQuestionModel.fromJson(response["responseBody"]);
        medicalQuestionListModel.value = result.list!;
        AppSnackbar.show(title: "Success", message: result.message!);
        if (result.success == true) {
          AppNavigation.to(AppRoutes.healthMenu);
        }
      } else if (statusCode == 405) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
      } else {
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.show(title: "Exception", message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> profileCreation({required var dataList}) async {
    isLoading(true);
    try {
      var data = {
        "userDao": {
          "emailId": _authController.errorResponse.value.emailId,
          "userId": _authController.errorResponse.value.userId,
        },
        "perDetailsDao": {
          "userEmail": _authController.errorResponse.value.emailId,
          "password": "",
          "userName": nameController.text,
          "userGender": selectionType.value,
          "userWeight": weightController.text,
          "userHeight": heightController.text,
          "userDOB": dateController.text,
          "userImage": profileUrl.value.path,
        },
        "helthDetailsListDao": dataList,
      };

      debugPrint(data.toString());
      Map<String, dynamic> response = await _profileService.profileCreation(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = MedicalQuestionModel.fromJson(response["responseBody"]);
        medicalQuestionListModel.value = result.list!;
        AppSnackbar.show(title: "Success", message: result.message!);
        if (result.success == true) {
          AppNavigation.to(AppRoutes.congratulationsScreen);
        }
      } else if (statusCode == 405) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
      } else {
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.show(title: "Exception", message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadProfileFromGallery() async {
    var imageUrl = await _uploadService.pickImageFromGallery();
    if (imageUrl != null) {
      profileUrl.value = File(imageUrl.path);
    } else {
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  Future<void> uploadProfileFromCamera() async {
    var imageUrl = await _uploadService.pickImageFromCamera();
    if (imageUrl != null) {
      profileUrl.value = File(imageUrl.path);
      AuthServices().uploadDocument(
        profileUrl.value,
        _authController.userId.value,
      );
    } else {
      Get.snackbar("Upload Failed", "Please try again");
    }
  }
}
