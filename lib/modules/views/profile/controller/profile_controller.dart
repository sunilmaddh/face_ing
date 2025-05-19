import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/models/show_guest_history_details.dart';
import 'package:ntt_data/data/models/user_health_details.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';

class ProfileController extends GetxController
    with GenderStateMixin, CommonMixin {
  final _authController = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  RxString userID = ''.obs;
  Map<String, dynamic> selectedAnswerList = {};
  List<Map<String, dynamic>> medicalQuestionData = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  RxList<UserHealthList> userHealthList = <UserHealthList>[].obs;
  RxList<Map<String, dynamic>> binahHIstoryDetails =
      <Map<String, dynamic>>[].obs;

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
    var userID = await StorageHelper.read("userID");
    var data = {"userId": userID};

    Map<String, dynamic> responseData = await _profileService
        .getUserHealthHistoryService(data: data);

    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      userHealthList.clear();
      var result = UserHistoryListModel.fromJson(responseData["responseBody"]);

      userHealthList.value = result.userHealthList!;
    } else {
      userHealthList.clear();
    }
  }

  Future<void> getUserHealthDetails({required var healthId}) async {
    var userID = await StorageHelper.read("userID");
    var data = {"userId": userID, "healthId": healthId};

    Map<String, dynamic> responseData = await _profileService
        .getUserHealthDetailsService(data: data);

    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      binahHIstoryDetails.clear();
      var result = UserHistoryDetailsModel.fromJson(
        responseData["responseBody"],
      );

      ///this is for binah
      binahHIstoryDetails.value = await ShowGuestHistoryDetails()
          .fetchUserHistoryBinahDetails(result.userHealthBinahHistory!);

      ///this is for anura
      // binahHIstoryDetails.value = await ShowGuestHistoryDetails()
      //     .fetchUserHistoryAnuraDetails(result.userHealthAnuraDetail!);
      AppNavigation.to(AppRoutes.userHealthDatails);
    } else {
      binahHIstoryDetails.clear();
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> storeHealthData() async {
    var userID = await StorageHelper.read("userID");
    var data = {};

    Map<String, dynamic> responseData = await ProfileServices()
        .storeUserHealthDataService(data: data);
  }
}
