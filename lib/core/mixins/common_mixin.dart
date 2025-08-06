import 'dart:async';
import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
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
  RxList<HealthDetailList> basicVitalSigns = <HealthDetailList>[].obs;
  RxList<HealthDetailList> bloodlessBloodTests = <HealthDetailList>[].obs;
  RxList<HealthDetailList> risks = <HealthDetailList>[].obs;
  RxList<HealthDetailList> stress = <HealthDetailList>[].obs;
  RxList<HealthDetailList> heartRateVariability = <HealthDetailList>[].obs;
  RxList<HealthDetailList> advancedHeartRateVariability =
      <HealthDetailList>[].obs;
  Future<void> uploadProfileFromGallery(
    String imageType,
    String guestId,
    String isGuest,
  ) async {
    var imageUrl = await profileUploadService.pickImageFromGallery();
    if (imageUrl != null) {
      isProfile.value = true;
      profileUrl.value = File(imageUrl.path);
      var userID = await IndoSharedPreference.instance.getUserId();
      Map<String, dynamic> responseData = await authServices.uploadDocument(
        profileUrl.value,
        userID,
        imageType,
        guestId,
        isGuest,
      );
      int statusCode = responseData["responseCode"];
      debugPrint("uploadImageResponseModel $statusCode");
      if (statusCode == 200) {
        if (guestId.isNotEmpty) {
          profileUrl.value = File("");
        }
        var result = responseData["response"];
        debugPrint("uploadImageResponseModel ${result}");
        uploadImageResponseModel.value = result;
        userImage.value = uploadImageResponseModel.value.imagePath!;
        debugPrint(
          "uploadImageResponseModel ${uploadImageResponseModel.value}",
        );
        AppSnackbar.show(title: "Success", message: "Profile uploaded");
      }
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  Future<void> uploadProfileFromCamera(
    String imageType,
    String guestId,
    String isGuest,
  ) async {
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
        guestId,
        isGuest,
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

        AppSnackbar.show(title: "Success", message: "Profile uploaded");
      }
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  var timerSeconds = 30.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  // void startTimer() {
  //   isResendEnabled.value = false;
  //   timerSeconds.value = 30;
  //   _timer?.cancel();
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (timerSeconds.value > 0) {
  //       timerSeconds.value--;
  //     } else {
  //       isResendEnabled.value = true;
  //       _timer?.cancel();
  //     }
  //   });
  // }

  @override
  void onInit() {
    // startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  clearHealthCategarie() {
    basicVitalSigns.clear();
    bloodlessBloodTests.clear();
    risks.clear();
    stress.clear();
    heartRateVariability.clear();
    advancedHeartRateVariability.clear();
  }
}
