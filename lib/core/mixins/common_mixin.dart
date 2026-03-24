// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/upload_image_response_model.dart';
import 'package:ntt_data/data/services/profile_upload_services.dart';

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
  // ProfileServices profileServices = ProfileServices();
  // ProfileUploadService profileUploadService = ProfileUploadService();
  // AuthServices authServices = AuthServices();
  RxList<HealthDetailList> basicVitalSigns = <HealthDetailList>[].obs;
  RxList<HealthDetailList> bloodlessBloodTests = <HealthDetailList>[].obs;
  RxList<HealthDetailList> risks = <HealthDetailList>[].obs;
  RxList<HealthDetailList> stress = <HealthDetailList>[].obs;
  RxList<HealthDetailList> heartRateVariability = <HealthDetailList>[].obs;
  RxList<HealthDetailList> advancedHeartRateVariability =
      <HealthDetailList>[].obs;

  RxBool imageLoading = false.obs;

  var timerSeconds = 30.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;

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

  bool stringToBool(String? value) {
    if (value == null) return false;

    return value.toLowerCase().trim() == 'true';
  }
}
