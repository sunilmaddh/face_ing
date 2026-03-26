// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/auth/models/error_response.dart';
import 'package:ntt_data/modules/auth/models/login_response_model.dart';
import 'package:ntt_data/modules/auth/models/user_create_response_model.dart';
import 'package:ntt_data/modules/auth/repositories/auth_repository.dart';
import 'package:ntt_data/modules/pulse/models/medical_question_model.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AuthController extends BaseController
    with CheckboxStateMixin, RadioStateMixin, CommonMixin {
  AuthController({required this.authRepository});

  final AuthRepository authRepository;
  final userAuthResponse = Rxn<UserAuthResponse>();
  final loginResponseModel = Rxn<LoginResponseModel>();
  final userCreateModel = Rxn<UserCreateResponseModel>();
  final medicalQuestionList = <MedicalQuestionListModel>[].obs;
  final dataList = <Map<String, dynamic>>[].obs;
  final userName = "".obs;
  final userImage = "".obs;
  final userEmail = "".obs;

  @override
  RxString otp = ''.obs;

  final userUpdateName = ''.obs;
  final emailId = ''.obs;
  final selectionGenderType = ''.obs;
  final date = ''.obs;
  final smokerType = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final dateController = TextEditingController();
  final forgotEmailController = TextEditingController();
  final passwordForgotController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final selectedDate = DateTime.now().obs;

  static const bool isFullHistory = true;

  Future<void> userLogin() async {
    try {
      showLoading(true);

      final response = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.statusCode != 200 || response.data == null) {
        setError(response.message);
        return;
      }

      final result = response.data!;
      loginResponseModel.value = result;

      final accessToken = response.headers?['accesstoken'] ?? '';
      if (accessToken.isNotEmpty) {
        await IndoSharedPreference.instance.saveAccessToken(accessToken);
      }

      await IndoSharedPreference.instance.saveUserId(result.userId ?? '');

      if (result.success != "true") {
        setError(result.message ?? "Login failed");
        return;
      }

      await IndoSharedPreference.instance.saveOnBoard(result.onBoarded ?? '');

      if (result.onBoarded == "false") {
        setSuccess(result.message ?? "Login successful");
        navigateTo(
          AppRoutes.createAccount,
          arguments: {"userId": result.userId},
        );
        return;
      }

      final user = result.commonUserDetailsDao;
      if (user != null) {
        userImage.value = user.userImage ?? '';
        userEmail.value = user.userEmail ?? '';
        userName.value = user.userName ?? '';

        await AppMethods.storeUserData(
          name: user.userName ?? '',
          weight: user.userWeight ?? '',
          height: user.userHeight ?? '',
          gender: user.userGender ?? '',
          dob: user.userDob ?? '',
          email: user.userEmail ?? '',
          smokerType: user.userSmokerType ?? '',
          userImage: user.userImage ?? '',
          isFullHistory: isFullHistory,
        );
      }
      setSuccess(result.message ?? "Login successful");
      navigateOff(AppRoutes.landingSceen);
      clearData();
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> getForgetOtp() async {
    try {
      showLoading(true);

      final response = await authRepository.getForgotOtp(
        email: forgotEmailController.text.trim(),
      );

      if (response.statusCode != 200 || response.data == null) {
        setError("Something went wrong");
        return;
      }

      userAuthResponse.value = response.data;

      if (userAuthResponse.value?.success == true) {
        navigateBack();
        navigateTo(AppRoutes.otpForgotScreen);
      } else {
        setError(userAuthResponse.value?.message ?? "Something went wrong");
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> verifyForgotOtp() async {
    try {
      showLoading(true);

      final response = await authRepository.verifyForgotOtp(
        emailId: forgotEmailController.text.trim(),
        otp: otp.value,
        userId: userAuthResponse.value?.userId ?? '',
      );

      if (response.statusCode != 200 || response.data == null) {
        setError("Something went wrong");
        return;
      }

      userAuthResponse.value = response.data;

      if (userAuthResponse.value?.success == true) {
        setSuccess(userAuthResponse.value?.message ?? "OTP verified");
        navigateTo(AppRoutes.resetPassword);
      } else {
        setError(userAuthResponse.value?.message ?? "OTP verification failed");
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> resetPassword() async {
    try {
      showLoading(true);

      final response = await authRepository.resetPassword(
        emailId: forgotEmailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        userId: userAuthResponse.value?.userId ?? '',
      );

      if (response.statusCode != 200) {
        setError("Something went wrong");
        return;
      }

      userAuthResponse.value = response.data ?? UserAuthResponse();

      if (userAuthResponse.value?.success == true) {
        setSuccess(userAuthResponse.value?.message ?? "Password reset success");
        navigateTo(AppRoutes.loginScreen);
        clearData();
      } else {
        setError(userAuthResponse.value?.message ?? "Password reset failed");
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> getMedicalQuestionList() async {
    try {
      showLoading(true);

      final response = await authRepository.getMedicalQuestionList();

      if (response.statusCode != 200 || response.data == null) {
        setError("Something went wrong");
        return;
      }

      final result = response.data!;
      medicalQuestionList.assignAll(result.list ?? []);

      if (result.isSuccess == true) {
        setSuccess(result.message ?? "Questions loaded");
        navigateTo(AppRoutes.healthMenu);
      } else {
        setError(result.message ?? "Unable to load questions");
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  Future<void> profileCreation() async {
    try {
      showLoading(true);

      final dob = await AppMethods().convertDateFormatToYY(dateController.text);
      final loginData = loginResponseModel.value;

      final response = await authRepository.createProfile(
        emailId: loginData?.emailId ?? '',
        userId: loginData?.userId ?? '',
        name: nameController.text.trim(),
        genderType: selectionType.value,
        weight: weightController.text.trim(),
        height: heightController.text.trim(),
        dob: dob,
        userImage: userImage.value,
        smokerType: smokerType.value,
        healthList: dataList,
      );

      if (response.statusCode != 200 || response.data == null) {
        setError("Something went wrong");
        return;
      }
      final result = response.data!;
      userCreateModel.value = result;

      await IndoSharedPreference.instance.saveOnBoard("true");

      final user = result.commonUserDetailsDao;
      if (user != null) {
        // userImage.value = user.userImage ?? '';
        // userEmail.value = user.userEmail ?? '';
        // userName.value = user.userName ?? '';

        await AppMethods.storeUserData(
          name: user.userName ?? '',
          weight: user.userWeight ?? '',
          height: user.userHeight ?? '',
          gender: user.userGender ?? '',
          dob: user.userDob ?? '',
          email: user.userEmail ?? '',
          smokerType: user.smokerType ?? '',
          userImage: user.userImage ?? '',
          isFullHistory: isFullHistory,
        );
      }

      setSuccess(result.message ?? "Profile created successfully");
      navigateTo(AppRoutes.congratulationsScreen);
    } catch (e) {
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }

  void storeQuestionAnswer(
    String id,
    String question,
    List<dynamic> selectedAnswers,
  ) {
    if (selectedAnswers.isEmpty) return;

    final item = {"id": id, "question": question, "answer": selectedAnswers};

    final index = dataList.indexWhere((e) => e["question"] == question);

    if (index != -1) {
      dataList[index] = item;
    } else {
      dataList.add(item);
    }

    dataList.refresh();
  }

  void clearData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    forgotEmailController.clear();
    passwordForgotController.clear();
    otp.value = '';
    isChecked.value = false;
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    weightController.clear();
    heightController.clear();
    dateController.clear();
    forgotEmailController.clear();
    passwordForgotController.clear();
    confirmPasswordController.clear();
    userName.value = "";
    userEmail.value = "";
    userImage.value = "";
    super.onClose();
  }
}
