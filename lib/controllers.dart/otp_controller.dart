import 'dart:async';
import 'package:get/get.dart';

class OTPController extends GetxController {
  var otp = ''.obs;
  var timerSeconds = 30.obs; // Countdown starts at 30 seconds
  var isResendEnabled = false.obs;
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
    // Add logic to resend OTP via API or SMS
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