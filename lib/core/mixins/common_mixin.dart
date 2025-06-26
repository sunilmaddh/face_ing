import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/data/repository/services/auth_services.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';
import 'package:ntt_data/data/repository/services/profile_upload_services.dart';

mixin CommonMixin on GetxController {
  Rx<File> profileUrl = File("").obs;
  RxBool isProfile = false.obs;
  RxString userId = "".obs;
  RxString otp = "".obs;
  RxString userImage = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  Rx<UploadImageResponseModel> uploadImageResponseModel =
      UploadImageResponseModel().obs;
  ProfileServices profileServices = ProfileServices();
  ProfileUploadService profileUploadService = ProfileUploadService();
  AuthServices authServices = AuthServices();

  Future<void> uploadProfileFromGallery(String imageType) async {
    var imageUrl = await profileUploadService.pickImageFromGallery();
    if (imageUrl != null) {
      isProfile.value = true;
      profileUrl.value = File(imageUrl.path);
      var userID = await IndoSharedPreference.instance.getUserId();
      Map<String, dynamic> responseData = await authServices.uploadDocument(
        profileUrl.value,
        userID,
        imageType,
      );
      int statusCode = responseData["responseCode"];
      debugPrint("uploadImageResponseModel $statusCode");
      if (statusCode == 200) {
        var result = responseData["response"];
        debugPrint("uploadImageResponseModel ${result}");
        uploadImageResponseModel.value = result;
        userImage.value = uploadImageResponseModel.value.imagePath!;
        debugPrint(
          "uploadImageResponseModel ${uploadImageResponseModel.value}",
        );
      }
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  Future<void> uploadProfileFromCamera(String imageType) async {
    var imageUrl = await profileUploadService.pickImageFromCamera();
    if (imageUrl != null) {
      isProfile.value = true;
      profileUrl.value = File(imageUrl.path);
      var userID = await IndoSharedPreference.instance.getUserId();
      debugPrint("uploadImageResponseModel $imageUrl");
      Map<String, dynamic> responseData = await authServices.uploadDocument(
        profileUrl.value,
        userID,
        imageType,
      );
      int statusCode = responseData["responseCode"];
      debugPrint("uploadImageResponseModel $statusCode");
      if (statusCode == 200) {
        var result = responseData["response"];
        debugPrint("uploadImageResponseModel $result");

        uploadImageResponseModel.value = result;
        userImage.value = uploadImageResponseModel.value.imagePath!;
        debugPrint(
          "uploadImageResponseModel ${uploadImageResponseModel.value}",
        );
      }
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  var timerSeconds = 30.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  void startTimer() {
    isResendEnabled.value = false;
    timerSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        isResendEnabled.value = true;
        _timer?.cancel();
      }
    });
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
