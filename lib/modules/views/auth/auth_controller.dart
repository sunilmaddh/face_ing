import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/services/auth_services.dart';

class AuthController extends GetxController {
  final _authServices = Get.put(AuthServices());
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  RxString userId = "".obs;
  RxString otp = "".obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailSignController = TextEditingController();
  final passwordSignController = TextEditingController();
  final dateController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;
  RxString date = "".obs;
  var selectedDate = DateTime.now().obs;
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
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

  void selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime minDate = DateTime(1900, 1, 1);
    DateTime maxDate = DateTime(2100, 12, 31); // ✅ Set a valid future max date

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          currentDate.isBefore(maxDate)
              ? currentDate
              : maxDate, // ✅ Ensure within range
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (pickedDate != null) {
      dateController.text = pickedDate.toString();
      print("Selected Date: $pickedDate");
    }
  }

  Future<void> getSingUpOtp() async {
    isLoading(true);
    var data = {
      "emailId": emailSignController.text,
      "password": passwordSignController.text,
      "confirmPassword": confirmPasswordController.text,
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.getSignUpOtp(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        startTimer();
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(
          title: "Success",
          message: errorResponse.value.message!,
        );
        userId.value = errorResponse.value.userId!;
        if (isResendEnabled.value == false) {
          AppNavigation.to(AppRoutes.otpSignupScreen);
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
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifySingUpOtp() async {
    isLoading(true);
    var data = {
      "emailId": emailSignController.text,
      "otp": otp.value,
      "userId": userId.value,
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.verifySignUpOtp(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(
          title: "Success",
          message: errorResponse.value.message!,
        );
        AppNavigation.to(AppRoutes.createAccount);
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

  Future<void> userLogin() async {
    isLoading(true);
    var data = {
      "emailId": emailController.text,
      "password": passwordController.text,
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.userLogin(data: data);
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(
          title: "Success",
          message: errorResponse.value.message!,
        );
        if (errorResponse.value.success == true) {
          AppNavigation.to(AppRoutes.homeScreen);
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

  Future<void> getForgetOtp() async {
    isLoading(true);
    var data = {"emailId": emailSignController.text};
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.getForgotOtp(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
        if (errorResponse.value.success == true) {
          AppNavigation.back();
          AppNavigation.to(AppRoutes.otpForgotScreen);
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

  Future<void> verifyForgotOtp() async {
    isLoading(true);
    var data = {
      "emailId": emailSignController.text,
      "otp": otp.value,
      "userId": userId.value,
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.verifyForgotOtp(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
        if (errorResponse.value.success == true) {
          AppNavigation.to(AppRoutes.loginScreen);
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
}
