import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';

class ProfileController extends GetxController
    with GenderStateMixin, CommonMixin {
  final _authController = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  RxList<UserHealthList> userHealthList = <UserHealthList>[].obs;
  RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;
  Rx<AnlyzeHealthDataResponseModel> anlyzeHealthDataResponseModel =
      AnlyzeHealthDataResponseModel().obs;
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  RxList<MedicalQuestionListModel> medicalQuestionListModel =
      <MedicalQuestionListModel>[].obs;
  final _profileService = Get.put(ProfileServices());
  Future<void> getMedicalQeustionList() async {
    isLoading(true);
    try {
      Map<String, dynamic> response =
          await _profileService.getMedicalQeustionList();
      debugPrint(response["responseBody"].toString());
      int statusCode = response['statusCode'];
      if (statusCode == 200) {
        var result = MedicalQuestionModels.fromJson(response["responseBody"]);
        medicalQuestionListModel.value = result.list!;
        _authController.medicalQuestionListModel.value =
            medicalQuestionListModel.value;
        AppSnackbar.show(title: "Success", message: result.message!);
        if (result.isSuccess == "true") {
          AppNavigation.to(AppRoutes.healthMenu);
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

  Future<void> getUserHistory() async {
    isLoading(true);
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {"userId": userID};

    Map<String, dynamic> responseData = await _profileService
        .getUserHealthHistoryService(data: data);

    isLoading(false);

    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      userHealthList.clear();
      var result = UserHistoryListModel.fromJson(responseData["responseBody"]);

      userHealthList.value = result.userHealthList!;
    } else {
      userHealthList.clear();
    }
  }

  Future<void> getUserHealthDetails({
    required var healthId,
    required var isFullHistory,
  }) async {
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {
      "userId": userID,
      "healthId": healthId,
      "isFullHistory": isFullHistory,
    };

    Map<String, dynamic> responseData = await _profileService
        .getUserHealthDetailsService(data: data);

    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      binahHIstoryDetails.clear();
      var result = HealthDetailsResponseModel.fromJson(
        responseData["responseBody"],
      );
      binahHIstoryDetails.value = result.healthDetail!;
      AppNavigation.to(AppRoutes.userHealthDatails);
    } else {
      binahHIstoryDetails.clear();
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }
}
