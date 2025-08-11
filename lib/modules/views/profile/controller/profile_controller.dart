import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/halper/globle_halper.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/data/models/error_response.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/models/update_details_response_model.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/data/models/vital_descriptions_model.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/profile/helper/profile_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/data/repository/services/profile_services.dart';

class ProfileController extends GetxController
    with RadioStateMixin, CommonMixin {
  final _authController = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  RxBool isVitalDescriptionLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Rx<VitalDescriptionsModel> vitalDescriptionModel =
      VitalDescriptionsModel().obs;
  RxString userUpdateImage = ''.obs;
  final RxString genderType = "".obs;
  final RxString smokerType = "".obs;
  RxList<UserHealthList> userHealthList = <UserHealthList>[].obs;
  RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;
  Rx<AnlyzeHealthDataResponseModel> anlyzeHealthDataResponseModel =
      AnlyzeHealthDataResponseModel().obs;
  Rx<ErrorResponse> errorResponse = ErrorResponse().obs;
  RxString vitalDesc = "".obs;
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
    var data = {"userId": userID, "userFlag": "true"};

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
      clearHealthCategarie();
      final profileController = Get.find<ProfileController>();
      var result = HealthDetailsResponseModel.fromJson(
        responseData["responseBody"],
      );

      binahHIstoryDetails.value = result.healthDetail!;
      await GlobleHalper().storeTabData(result, profileController);
      AppNavigation.to(AppRoutes.userHealthDatails);
    } else {
      binahHIstoryDetails.clear();
      clearHealthCategarie();
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> updateDetailsUG({required var data, required userFlag}) async {
    Map<String, dynamic> responseData = await ProfileServices()
        .updateDetailsUGService(data: data);
    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      var data = UpdateDetailsResponseModel.fromJson(
        responseData["responseBody"],
      );

      if (userFlag == "true") {
        var isFullStory = await IndoSharedPreference.instance.getHistoryType();
        await ProfileHelper().storeImage(data.name!);
        await AppMethods.storeUserData(
          name: data.name!,
          weight: data.weight!,
          height: data.height!,
          gender: data.gender!,
          dob: data.dob!,
          smokerType: data.smokerType!,
          email: '',
          userImage: '',
          isFullHistory: isFullStory,
        );
      } else {
        ProfileHelper().callGuestHistoryList();
      }
      AppSnackbar.show(
        title: "Success",
        message: "Update details successfully",
      );
      clearProfileData();
      Get.back();
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> getVitalDescryption({required var vitalKey}) async {
    isVitalDescriptionLoading(true);
    var data = {"vitalKey": vitalKey};
    debugPrint(data.toString());
    Map<String, dynamic> responseData = await ProfileServices()
        .getVitalDescriptionService(data: data);
    int statusCode = responseData[AppConstents.statusCode];
    isVitalDescriptionLoading(false);
    if (statusCode == 200) {
      var result = VitalDescriptionsModel.fromJson(
        responseData["responseBody"],
      );

      vitalDescriptionModel.value = result;
      vitalDesc.value = vitalDescriptionModel.value.vitalDesc.toString();
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> logoutUser() async {
    Map<String, dynamic> responseData =
        await ProfileServices().logoutUserService();
    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      AppMethods().logout();
      AppSnackbar.show(title: "Success", message: "Successfully logged out.");
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  clearProfileData() {
    nameController.clear();
    weightController.clear();
    heightController.clear();
    genderType.value = "";
    smokerType.value = "";
    dobController.clear();
  }
}
