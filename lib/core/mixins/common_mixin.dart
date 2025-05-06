import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ntt_data/data/repository/services/auth_services.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';
import 'package:ntt_data/data/repository/services/profile_upload_services.dart';

mixin CommonMixin on GetxController {
  Rx<File> profileUrl = File("").obs;
  RxBool isProfile = false.obs;
  RxString userId = "".obs;
  RxString otp = "".obs;
  ProfileServices profileServices = ProfileServices();
  ProfileUploadService profileUploadService = ProfileUploadService();
  AuthServices authServices = AuthServices();

  Future<void> uploadProfileFromGallery() async {
    var imageUrl = await profileUploadService.pickImageFromGallery();
    if (imageUrl != null) {
      isProfile.value = true;
      profileUrl.value = File(imageUrl.path);
    } else {
      isProfile.value = false;
      Get.snackbar("Upload Failed", "Please try again");
    }
  }

  Future<void> uploadProfileFromCamera() async {
    var imageUrl = await profileUploadService.pickImageFromCamera();
    if (imageUrl != null) {
      isProfile.value = true;
      profileUrl.value = File(imageUrl.path);
      authServices.uploadDocument(profileUrl.value, userId.value);
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
}
