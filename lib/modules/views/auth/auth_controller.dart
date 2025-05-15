import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/login_response_model.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/auth_services.dart';

class AuthController extends GetxController
    with CheckboxStateMixin, GenderStateMixin, CommonMixin {
  final _authServices = Get.put(AuthServices());
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  Rx<LoginResponseModel> loginResponseModel = LoginResponseModel().obs;

  RxList<MedicalQuestionListModel> medicalQuestionListModel =
      <MedicalQuestionListModel>[].obs;
  RxString otp = "".obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();
  final passwordForgotController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var dataList = <Map<String, dynamic>>[].obs;
  RxString emailId = ''.obs;
  RxBool isLoading = false.obs;
  RxString date = "".obs;
  var selectedDate = DateTime.now().obs;
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  Future<void> userLogin() async {
    isLoading(true);
    var data = {
      "emailId": emailController.text,
      "password": passwordController.text,
      "sDKType": "ANURA",
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.userLogin(data: data);
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var header = response["header"];
        var accessToken = header["accesstoken"];
        var refereshToken = header["refreshtoken"];
        debugPrint("Access token ${header["accesstoken"]}");
        StorageHelper.write("access-token", accessToken);
        StorageHelper.write("refresh-token", refereshToken);
        var result = LoginResponseModel.fromJson(response["responseBody"]);
        loginResponseModel.value = result;
        AppSnackbar.show(
          title: "Success",
          message: loginResponseModel.value.message!,
        );
        StorageHelper.write("userID", loginResponseModel.value.userId!);
        StorageHelper.write("emailId", loginResponseModel.value.emailId!);
        // AppNavigation.to(AppRoutes.homeScreen);
        // clearData();
        if (loginResponseModel.value.success == "true" &&
            loginResponseModel.value.onBoarded == "false") {
          AppNavigation.to(
            AppRoutes.createAccount,
            arguments: {"userId": loginResponseModel.value.userId},
          );
          clearData();
        } else {
          StorageHelper.write(
            "isOnboard",
            loginResponseModel.value.onBoarded.toString(),
          );
          AppNavigation.off(AppRoutes.homeScreen);
        }
      } else if (statusCode == 405) {
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
      } else {
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
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
    var data = {"emailId": forgotEmailController.text};
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.getForgotOtp(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        startTimer();
        var result = ErrorResponse.fromJson(response["responseBody"]);
        errorResponse.value = result;
        AppSnackbar.show(title: "Error", message: errorResponse.value.message!);
        AppNavigation.back();
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
      "emailId": forgotEmailController.text,
      "otp": otp.value,
      "userId": errorResponse.value.userId,
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
        AppSnackbar.show(
          title: "Success",
          message: errorResponse.value.message!,
        );
        if (errorResponse.value.success == true) {
          AppNavigation.to(AppRoutes.resetPassword);
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

  Future<void> resetPassword() async {
    isLoading(true);
    var data = {
      "emailId": forgotEmailController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "userId": errorResponse.value.userId,
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.resetPassword(
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
        if (errorResponse.value.success == true) {
          AppNavigation.to(AppRoutes.loginScreen);
        }
        clearData();
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

  Future<void> getMedicalQuestionList() async {
    isLoading(true);
    try {
      Map<String, dynamic> response = await _authServices
          .getMedicalQeustionList(data: "");
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = MedicalQuestionModels.fromJson(response["responseBody"]);
        medicalQuestionListModel.value = result.list!;
        AppSnackbar.show(title: "Success", message: result.message!);
        if (result.isSuccess == true) {
          AppNavigation.to(AppRoutes.healthMenu);
        }
        // AppSnackbar.show(title: "Success", message: errorResponse.value.message!);
        if (errorResponse.value.success == true) {
          clearData();
          AppNavigation.offAll(AppRoutes.loginScreen);
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

  Future<void> profileCreation() async {
    isLoading(true);
    try {
      var data = {
        "userDao": {
          "emailId": loginResponseModel.value.emailId,
          "userId": loginResponseModel.value.userId,
        },
        "perDetailsDao": {
          "userEmail": loginResponseModel.value.emailId,
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
      Map<String, dynamic> response = await profileServices.profileCreation(
        data: data,
      );
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        AppNavigation.to(AppRoutes.congratulationsScreen);
        // var result = MedicalQuestionModels.fromJson(response["responseBody"]);
        // medicalQuestionListModel.value = result.list!;
        // AppSnackbar.show(title: "Success", message: result.message!);
        // if (result.isSuccess == true) {
        //   AppNavigation.to(AppRoutes.congratulationsScreen);
        // }
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

  Future<void> callUploadProfileFromGallery() async {
    return uploadProfileFromGallery();
  }

  Future<void> callUploadProfileFromCamera() async {
    return uploadProfileFromCamera();
  }

  clearData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isChecked.value = false;
    otp.value = "";
  }

  void storeQuestionAnswer(
    String id,
    String question,
    List<dynamic> selectedAnswers,
  ) {
    if (selectedAnswers.isNotEmpty) {
      // Check if the question already exists
      int index = dataList.indexWhere(
        (element) => element["question"] == question,
      );

      if (index != -1) {
        // Update existing entry
        dataList[index]["answer"] = selectedAnswers;
        dataList[index]["id"] = id; // Optionally update id too
        print("Updated existing entry: ${dataList[index]}");
      } else {
        // Add new entry
        dataList.add({
          "id": id,
          "question": question,
          "answer": selectedAnswers,
        });
        print("Added new entry: ${dataList.last}");
      }
    }

    // print("Updated existing entry: ${dataList.toString()}");
    // healthMenuData.value = dataList.value;
  }
}
