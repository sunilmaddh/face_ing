import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/data/models/add_geust_request_model.dart';
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

        // userImage.value = uploadImageResponseModel.value.imagePath!;
      }
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  var timerSeconds = 30.obs; // Countdown starts at 30 seconds
  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  void setOTP(String value) {
    otp.value = value;
  }

  void verifyOTP() {
    print("Entered OTP: ${otp.value}");
    // Add OTP verification logic here
  }

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

  void resendOTP() {
    print("Resending OTP...");
    startTimer();
  }

  @override
  void onInit() {
    startTimer(); // Start timer on screen load
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Future<String> storeBinahData(VitalSignsResults vitalSignResult) async {
  //   BinahDetails binahDetails = BinahDetails(
  //     pulseRate: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     respirationRate:
  //         vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     oxygenSaturation:
  //         vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     sdnn: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     stressLevel: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     rri: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     bloodPressure: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     stressIndex: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     meanRri: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     rmssd: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     sd1: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     sd2: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     prq: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     pnsIndex: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     pnsZone: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     snsIndex: vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
  //     snsZone: vitalSignResult.getResult(VitalSignTypes.snsZone)!.value,
  //     wellnessIndex:
  //         vitalSignResult.getResult(VitalSignTypes.wellnessIndex)!.value,
  //     wellnessLevel:
  //         vitalSignResult.getResult(VitalSignTypes.wellnessLevel)!.value,
  //     lfhf: vitalSignResult.getResult(VitalSignTypes.lfhf)!.value,
  //     hemoglobin: vitalSignResult.getResult(VitalSignTypes.hemoglobin)!.value,
  //     hemoglobinA1C:
  //         vitalSignResult.getResult(VitalSignTypes.hemoglobinA1C)!.value,
  //     highHemoglobinA1CRisk:
  //         vitalSignResult
  //             .getResult(VitalSignTypes.highHemoglobinA1CRisk)!
  //             .value,
  //     highBloodPressureRisk:
  //         vitalSignResult
  //             .getResult(VitalSignTypes.highBloodPressureRisk)!
  //             .value,
  //     ascvdRisk: vitalSignResult.getResult(VitalSignTypes.ascvdRisk)!.value,
  //     normalizedStressIndex:
  //         vitalSignResult
  //             .getResult(VitalSignTypes.normalizedStressIndex)!
  //             .value,
  //     heartAge: vitalSignResult.getResult(VitalSignTypes.heartAge)!.value,
  //     highTotalCholesterolRisk:
  //         vitalSignResult
  //             .getResult(VitalSignTypes.highTotalCholesterolRisk)!
  //             .value,
  //     highFastingGlucoseRisk:
  //         vitalSignResult
  //             .getResult(VitalSignTypes.highFastingGlucoseRisk)!
  //             .value,
  //     lowHemoglobinRisk:
  //         vitalSignResult.getResult(VitalSignTypes.lowHemoglobinRisk)!.value,
  //   );
  //   var data = jsonEncode(binahDetails.toJson());
  //   return data;
  // }
  // }
  Future<Map<String, dynamic>> sentBinahData(
    VitalSignsResults vitalSignResult,
  ) async {
    var data = {
      "pulseRate": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "respirationRate":
          vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "oxygenSaturation":
          vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "sdnn": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "stressLevel": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "rri": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "bloodPressure":
          vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "stressIndex": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "meanRri": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "rmssd": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "sd1": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "sd2": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "prq": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "pnsIndex": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "pnsZone": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "snsIndex": vitalSignResult.getResult(VitalSignTypes.pulseRate)!.value,
      "snsZone": vitalSignResult.getResult(VitalSignTypes.snsZone)!.value,
      "wellnessIndex":
          vitalSignResult.getResult(VitalSignTypes.wellnessIndex)!.value,
      "wellnessLevel":
          vitalSignResult.getResult(VitalSignTypes.wellnessLevel)!.value,
      "lfhf": vitalSignResult.getResult(VitalSignTypes.lfhf)!.value,
      "hemoglobin": vitalSignResult.getResult(VitalSignTypes.hemoglobin)!.value,
      "hemoglobinA1C":
          vitalSignResult.getResult(VitalSignTypes.hemoglobinA1C)!.value,
      "highHemoglobinA1CRisk":
          vitalSignResult
              .getResult(VitalSignTypes.highHemoglobinA1CRisk)!
              .value,
      "highBloodPressureRisk":
          vitalSignResult
              .getResult(VitalSignTypes.highBloodPressureRisk)!
              .value,
      "ascvdRisk": vitalSignResult.getResult(VitalSignTypes.ascvdRisk)!.value,
      "normalizedStressIndex":
          vitalSignResult
              .getResult(VitalSignTypes.normalizedStressIndex)!
              .value,
      "heartAge": vitalSignResult.getResult(VitalSignTypes.heartAge)!.value,
      "highTotalCholesterolRisk":
          vitalSignResult
              .getResult(VitalSignTypes.highTotalCholesterolRisk)!
              .value,
      "highFastingGlucoseRisk":
          vitalSignResult
              .getResult(VitalSignTypes.highFastingGlucoseRisk)!
              .value,
      "lowHemoglobinRisk":
          vitalSignResult.getResult(VitalSignTypes.lowHemoglobinRisk)!.value,
    };
    return data;
  }

  Future<AnuraDetails> storeAnuraData() async {
    AnuraDetails anuraDetails = AnuraDetails(
      age: 0,
      gender: "",
      height: "",
      waistCircum: "",
      bMiCalc: "",
      aBsi: "",
      hRbpm: "",
      bPSystolic: "",
      hRvsdnn: "",
      bPrpp: "",
      bPTau: "",
      bPbpm: "",
      tHbCount: "",
      healthScore: "",
      mentalScore: "",
      vitalScore: "",
      physicalScore: "",
      mSi: "",
      bpHeartAttack: "",
      bPStroke: "",
      bPcvd: "",
      risksScore: "",
      sNr: "",
    );
    return anuraDetails;
  }

  // sentReturnData({
  //   required AnuraDetails anuraDetails,
  //   required VitalSignsResults vitalSignResultDetails,
  //   required GuestDao geustDto,
  // }) async {
  //   AnuraDetails anuraDetails = await storeAnuraData();
  //   BinahDetails binahDetails = await storeBinahData(vitalSignResultDetails);
  //   GuestDao guestDao = await storeGeustData("", "", "", "", "", "");
  //   AddGeustRequestModel addGeustRequestModel = AddGeustRequestModel(
  //     guestDao: guestDao,
  //     anuraDetails: anuraDetails,
  //     binahDetails: binahDetails,
  //   );
  //   addGeustRequestModelToJson(addGeustRequestModel);
  // }

  Future<GuestDao> storeGeustData(
    String userId,
    String name,
    String gender,
    String dob,
    String weight,
    String height,
  ) async {
    GuestDao guestDao = GuestDao(
      userId: "",
      email: "",
      name: "",
      gender: "",
      dob: "",
      weight: "",
      height: "",
      image: "",
    );

    return guestDao;
  }
}
