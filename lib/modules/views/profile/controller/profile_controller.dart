import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
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
  RxBool isLoadingLogout = false.obs;
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
      await GlobleHalper().storeTabData(result, profileController, "");
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
    isLoadingLogout(true);
    Map<String, dynamic> responseData =
        await ProfileServices().logoutUserService();
    int statusCode = responseData[AppConstents.statusCode];
    isLoadingLogout(false);
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

  RxString data =
      "<!DOCTYPE html> <html lang='en'> <head>   <meta charset='UTF-8'>   <style>     body {       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;       line-height: 1.6;       padding: 40px;       background-color: #ffffff;       color: #333;     }      h1, h2 {       color: #2c3e50;     }      .highlight {       font-weight: bold;       color: #1a73e8;     }      ul {       margin-left: 20px;     }      .section {       margin-bottom: 30px;     }      .note {       font-style: italic;       color: #666;     }  .responsive {   width: 20%;   height: auto; }  .center {   display: block;   margin-left: auto;   margin-right: auto;   width: 50%; }   </style> </head> <body>    <h1>Wellness Score</h1> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-1.png' alt='Paris' class='center responsive' padding: 40px;  margin-left: 20px; >  <div class='section'>         <p>   The Wellness Score is a  <strong>prediction risk</strong>  score that is used to predict a person's cardiovascular risk for the next 5 to 10 years. The Wellness Score is based on the vital signs measured by our technology, and is designed to serve as a reference when measured at rest, under similar conditions during all of the measurements, and if the score is consistent in repeated measurements over time.  </p>  <p> The higher the wellness score, the lower the cardiovascular risk.   </p>      <div class='section'>     <h2>How is it calculated?</h2>     <p>Your Wellness Score is calculated using your vitals results from any single measurement. The values of each one of the vital sign measurements affect your Wellness Score prediction.</p>           <p>Generally, a lower Heart Rate at rest implies more efficient heart function and better cardiovascular fitness. Therefore, a higher Heart Rate reduces your Wellness Score - even when the heart rate is within the normal range. For example, heart rates that are higher than 65 reduce the wellness score to a  <strong>medium score</strong>  , and values that are higher than 84 reduce the wellness score to a  <strong>low score.</strong> </p> <p> HRV measures the variation in time between heartbeats. The Stress Level that is calculated from this variance also affects your Wellness Score. Thus, Very High and High stress levels are correlated with a  <strong>low score</strong> , while Mild and Normal stress levels are correlated with a  <strong>medium score</strong> . .</p> <img src='https://blr1.digitaloceanspaces.com/faceingrecognize234/uploads/userprofile/welness-score-2.png' alt='Paris' class='center responsive'> <p> Your Oxygen Saturation level measures the amount of oxygen in the blood delivered from the lungs to the rest of the body. A higher level implies a more efficient function, thus, a lower Oxygen Saturation level reduces the Wellness Score. </p>      <p> In addition, High Blood Pressure readings at rest may pose a higher risk of health problems and therefore may reduce the Wellness Score. </p>   </div>   </body> </html>  "
          .obs;
}
