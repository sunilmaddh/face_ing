import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/helper/globle_halper.dart';
import 'package:ntt_data/data/models/anlyze_health_data_response_model.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/medical_question_model.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/data/models/vital_descriptions_model.dart';
import 'package:ntt_data/modules/views/profile/helper/profile_helper.dart';
import 'package:ntt_data/modules/views/profile/repositories/profile_repository.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class ProfileController extends GetxController
    with RadioStateMixin, CommonMixin {
  ProfileController({required this.profileRepository});
  final ProfileRepository profileRepository;
  RxBool isLoading = false.obs;
  RxBool isVitalDescriptionLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  RxBool isFullStory = false.obs;
  Rx<VitalDescriptionsModel> vitalDescriptionModel =
      VitalDescriptionsModel().obs;
  RxString userUpdateImage = ''.obs;
  final RxString genderType = "".obs;
  final RxString smokerType = "".obs;
  RxBool isLoadingLogout = false.obs;
  RxList<UserHealthList> userHealthList = <UserHealthList>[].obs;
  RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;
  Rx<AnlyzeHealthDataResponseModel> anlyzeHealthDataResponseModel =
      AnlyzeHealthDataResponseModel().obs;
  RxString vitalDesc = "".obs;
  RxList<Widget> tabWidget = <Widget>[].obs;
  RxList<MedicalQuestionListModel> medicalQuestionListModel =
      <MedicalQuestionListModel>[].obs;

  Future<void> getUserHistory() async {
    isLoading(true);
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {"userId": userID, "userFlag": "true"};
    var responseData = await profileRepository.getUserHealthHistory(data: data);
    isLoading(false);
    if (responseData.statusCode == 200) {
      userHealthList.clear();
      var result = responseData.data;
      userHealthList.value = result!.userHealthList!;
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

    var responseData = await profileRepository.getUserHealthDetails(data: data);
    if (responseData.statusCode == 200) {
      binahHIstoryDetails.clear();
      clearHealthCategarie();
      final profileController = Get.find<ProfileController>();
      var result = responseData.data;
      binahHIstoryDetails.value = result!.healthDetail!;
      await GlobleHalper().storeTabData(result, profileController, "");
      AppNavigation.to(AppRoutes.userHealthDatails);
    } else {
      binahHIstoryDetails.clear();
      clearHealthCategarie();
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> updateDetailsUG({required var data, required userFlag}) async {
    var responseData = await profileRepository.updateDetailsUG(data: data);

    if (responseData.statusCode == 200) {
      var data = responseData.data;
      Get.back();

      if (userFlag == "true") {
        var isFullStory = await IndoSharedPreference.instance.getHistoryType();
        await ProfileHelper().storeImage(data!.name!);
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
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> getVitalDescryption({required var vitalKey}) async {
    isVitalDescriptionLoading(true);
    var data = {"vitalKey": vitalKey};
    debugPrint(data.toString());
    var responseData = await profileRepository.getVitalDescription(data: data);

    isVitalDescriptionLoading(false);
    if (responseData.statusCode == 200) {
      var result = responseData.data;
      vitalDescriptionModel.value = result!;
      vitalDesc.value = vitalDescriptionModel.value.vitalDesc.toString();
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> logoutUser() async {
    isLoadingLogout(true);
    var responseData = await profileRepository.logoutUser();
    isLoadingLogout(false);
    if (responseData.statusCode == 200) {
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
