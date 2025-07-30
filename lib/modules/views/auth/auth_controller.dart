import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/login_response_model.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/models/user_create_response_model.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/auth_services.dart';

class AuthController extends GetxController
    with CheckboxStateMixin, RadioStateMixin, CommonMixin {
  final _authServices = Get.put(AuthServices());
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  Rx<LoginResponseModel> loginResponseModel = LoginResponseModel().obs;

  RxList<MedicalQuestionListModel> medicalQuestionListModel =
      <MedicalQuestionListModel>[].obs;
  RxString otp = "".obs;
  RxString userUpdateName = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();
  final passwordForgotController = TextEditingController();
  Rx<UserCreateResponseModel> userCreateModel = UserCreateResponseModel().obs;
  final confirmPasswordController = TextEditingController();
  final RxString smokerType = "".obs;
  var dataList = <Map<String, dynamic>>[].obs;
  RxString emailId = ''.obs;
  RxString selectionGenderType = "".obs;
  RxBool isLoading = false.obs;
  RxString date = "".obs;
  var selectedDate = DateTime.now().obs;

  Future<void> userLogin() async {
    isLoading(true);
    var data = {
      "emailId": emailController.text,
      "password": passwordController.text,
      "sDKType": "BINAH",
    };
    debugPrint(data.toString());
    try {
      Map<String, dynamic> response = await _authServices.userLogin(data: data);
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var header = response["header"];
        var accessToken = header["accesstoken"] ?? "";
        // var refereshToken = header["refreshtoken"];
        debugPrint("Access token ${header["accesstoken"]}");
        if (accessToken != null) {
          await IndoSharedPreference.instance.saveAccessToken(accessToken);
        }

        // await IndoSharedPreference.instance.saveRefreshToken(refereshToken);
        var result = LoginResponseModel.fromJson(response["responseBody"]);
        loginResponseModel.value = result;

        await IndoSharedPreference.instance.saveUserId(
          loginResponseModel.value.userId!,
        );

        if (loginResponseModel.value.success == "true") {
          if (loginResponseModel.value.success == "true" &&
              loginResponseModel.value.onBoarded == "false") {
            await IndoSharedPreference.instance.saveOnBoard(
              loginResponseModel.value.onBoarded!,
            );
            AppNavigation.to(
              AppRoutes.createAccount,
              arguments: {"userId": loginResponseModel.value.userId},
            );
          } else {
            await IndoSharedPreference.instance.saveOnBoard(
              loginResponseModel.value.onBoarded!,
            );
            userImage.value =
                loginResponseModel.value.commonUserDetailsDao!.userImage!;
            userEmail.value =
                loginResponseModel.value.commonUserDetailsDao!.userEmail!;
            userName.value =
                loginResponseModel.value.commonUserDetailsDao!.userName!;

            await IndoSharedPreference.instance.saveUserName(
              loginResponseModel.value.commonUserDetailsDao!.userName!,
            );

            await IndoSharedPreference.instance.saveUserEmail(
              loginResponseModel.value.commonUserDetailsDao!.userEmail!,
            );
            await IndoSharedPreference.instance.saveUserImage(
              loginResponseModel.value.commonUserDetailsDao!.userImage!,
            );

            await IndoSharedPreference.instance.saveGenderType(
              loginResponseModel.value.commonUserDetailsDao!.userGender
                  .toString(),
            );

            await IndoSharedPreference.instance.saveHeight(
              loginResponseModel.value.commonUserDetailsDao!.userHeight
                  .toString(),
            );

            await IndoSharedPreference.instance.saveWeight(
              loginResponseModel.value.commonUserDetailsDao!.userWeight
                  .toString(),
            );
            await IndoSharedPreference.instance.saveAge(
              loginResponseModel.value.commonUserDetailsDao!.userDob.toString(),
            );
            await IndoSharedPreference.instance.saveSmokerType(
              loginResponseModel.value.commonUserDetailsDao!.userSmokerType
                  .toString(),
            );
            GuestHalper().clearLoading();
            AppNavigation.off(AppRoutes.homeScreen);
          }
          clearData();
        } else {
          AppSnackbar.show(
            title: "Error",
            message: loginResponseModel.value.message!,
            isError: true,
          );
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
      // AppSnackbar.show(title: "Exception", message: e.toString());
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
        AppSnackbar.show(
          title: "Error",
          message: errorResponse.value.message!,
          isError: true,
        );
      } else {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: true,
        );
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
      var dob = await AppMethods().convertDateFormatToYY(dateController.text);
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
          "userDOB": dob,
          "userImage": userImage.value,
          "smokerType": smokerType.value,
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
        var result = UserCreateResponseModel.fromJson(response["responseBody"]);
        userCreateModel.value = result;
        IndoSharedPreference.instance.saveOnBoard("true");
        userImage.value =
            userCreateModel.value.commonUserDetailsDao!.userImage.toString();
        userEmail.value =
            userCreateModel.value.commonUserDetailsDao!.userEmail.toString();
        userName.value =
            userCreateModel.value.commonUserDetailsDao!.userName.toString();
        await IndoSharedPreference.instance.saveUserName(
          userCreateModel.value.commonUserDetailsDao!.userName.toString(),
        );
        await IndoSharedPreference.instance.saveUserEmail(
          userCreateModel.value.commonUserDetailsDao!.userEmail.toString(),
        );
        await IndoSharedPreference.instance.saveUserImage(
          userCreateModel.value.commonUserDetailsDao!.userImage.toString(),
        );
        await IndoSharedPreference.instance.saveGenderType(
          userCreateModel.value.commonUserDetailsDao!.userGender.toString(),
        );

        await IndoSharedPreference.instance.saveHeight(
          userCreateModel.value.commonUserDetailsDao!.userHeight.toString(),
        );

        await IndoSharedPreference.instance.saveWeight(
          userCreateModel.value.commonUserDetailsDao!.userWeight.toString(),
        );
        await IndoSharedPreference.instance.saveAge(
          userCreateModel.value.commonUserDetailsDao!.userDob.toString(),
        );
        AppNavigation.to(AppRoutes.congratulationsScreen);
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
    return uploadProfileFromGallery("true", "", "false");
  }

  Future<void> callUploadProfileFromCamera() async {
    return uploadProfileFromCamera("true", "", "false");
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
  }

  Future<void> initializedData() async {
    userName.value = await IndoSharedPreference.instance.getUserName();
    userEmail.value = await IndoSharedPreference.instance.getUserEmail();
    userImage.value = await IndoSharedPreference.instance.getUserImage();
  }
}
