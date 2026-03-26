import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/helper/globle_halper.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';
import 'package:ntt_data/modules/profile/models/vital_descriptions_model.dart';
import 'package:ntt_data/modules/profile/helper/profile_helper.dart';
import 'package:ntt_data/modules/profile/repositories/profile_repository.dart';
import 'package:ntt_data/routes/app_routes.dart';

class ProfileController extends BaseController
    with RadioStateMixin, CommonMixin {
  ProfileController({required this.profileRepository});

  final ProfileRepository profileRepository;

  // 🔹 Local states
  final RxBool isVitalDescriptionLoading = false.obs;
  final RxBool isLoadingLogout = false.obs;

  // 🔹 Controllers
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  // 🔹 UI States
  final RxBool isFullStory = false.obs;
  final RxString genderType = "".obs;
  final RxString smokerType = "".obs;

  final userName = "".obs;
  final userImage = "".obs;
  final userEmail = "".obs;
  final userUpdateName = "".obs;

  // 🔹 Data
  final RxList<UserHealthList> userHealthList = <UserHealthList>[].obs;
  final RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;

  final Rx<VitalDescriptionsModel> vitalDescriptionModel =
      VitalDescriptionsModel().obs;

  final RxString vitalDesc = "".obs;
  final RxList<Widget> tabWidget = <Widget>[].obs;

  final RxString userUpdateImage = ''.obs;

  // ==============================
  // USER HISTORY
  // ==============================
  Future<void> getUserHistory() async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();

      final data = {"userId": userID, "userFlag": "true"};

      final responseData = await profileRepository.getUserHealthHistory(
        data: data,
      );

      if (responseData.statusCode == 200) {
        userHealthList.clear();
        final result = responseData.data;
        userHealthList.value = result?.userHealthList ?? [];
      } else {
        userHealthList.clear();
        setError("Something went wrong");
      }
    } catch (e) {
      userHealthList.clear();
      setError("Something went wrong");
    } finally {
      showLoading(false);
    }
  }

  // ==============================
  // USER HEALTH DETAILS
  // ==============================
  Future<void> getUserHealthDetails({
    required dynamic healthId,
    required dynamic isFullHistory,
  }) async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();

      final data = {
        "userId": userID,
        "healthId": healthId,
        "isFullHistory": isFullHistory,
      };

      final responseData = await profileRepository.getUserHealthDetails(
        data: data,
      );

      if (responseData.statusCode == 200) {
        binahHIstoryDetails.clear();
        clearHealthCategarie();

        final result = responseData.data;
        binahHIstoryDetails.value = result?.healthDetail ?? [];

        await GlobleHalper().storeTabData(
          result ?? HealthDetailsResponseModel(),
          this,
          "",
        );

        navigateTo(AppRoutes.userHealthDatails);
      } else {
        binahHIstoryDetails.clear();
        clearHealthCategarie();
        setError("Something went wrong");
      }
    } catch (e) {
      binahHIstoryDetails.clear();
      clearHealthCategarie();
      setError("Something went wrong");
    } finally {
      showLoading(false);
    }
  }

  // ==============================
  // UPDATE USER / GUEST
  // ==============================
  Future<void> updateDetailsUG({
    required Map<String, dynamic> data,
    required String userFlag,
  }) async {
    showLoading(true);

    try {
      final responseData = await profileRepository.updateDetailsUG(data: data);

      if (responseData.statusCode == 200) {
        final result = responseData.data;

        navigateBack();

        if (userFlag == "true") {
          final isFullStory =
              await IndoSharedPreference.instance.getHistoryType();
          userUpdateName.value = result?.name ?? "";
          await AppMethods.storeUserData(
            name: result?.name ?? "",
            weight: result?.weight ?? "",
            height: result?.height ?? "",
            gender: result?.gender ?? "",
            dob: result?.dob ?? "",
            smokerType: result?.smokerType ?? "",
            email: '',
            userImage: '',
            isFullHistory: isFullStory,
          );
        } else {
          Get.find<GeustController>().getGeustHistory();
        }

        setSuccess("Update details successfully");
        clearProfileData();
      } else {
        setError("Something went wrong");
      }
    } catch (e) {
      setError("Something went wrong");
    } finally {
      showLoading(false);
    }
  }

  // ==============================
  // VITAL DESCRIPTION
  // ==============================
  Future<void> getVitalDescryption({required dynamic vitalKey}) async {
    isVitalDescriptionLoading(true);

    try {
      final data = {"vitalKey": vitalKey};

      final responseData = await profileRepository.getVitalDescription(
        data: data,
      );

      if (responseData.statusCode == 200) {
        final result = responseData.data;

        vitalDescriptionModel.value = result!;
        vitalDesc.value = vitalDescriptionModel.value.vitalDesc.toString();
      } else {
        setError("Something went wrong");
      }
    } catch (e) {
      setError("Something went wrong");
    } finally {
      isVitalDescriptionLoading(false);
    }
  }

  // ==============================
  // LOGOUT
  // ==============================
  Future<void> logoutUser() async {
    isLoadingLogout(true);

    try {
      final responseData = await profileRepository.logoutUser();

      if (responseData.statusCode == 200) {
        AppMethods().logout();
        setSuccess("Successfully logged out");
      } else {
        setError("Something went wrong");
      }
    } catch (e) {
      setError("Something went wrong");
    } finally {
      isLoadingLogout(false);
    }
  }

  Future<void> initializeData() async {
    userName.value = await IndoSharedPreference.instance.getUserName();
    userEmail.value = await IndoSharedPreference.instance.getUserEmail();
    userImage.value = await IndoSharedPreference.instance.getUserImage();
  }

  /// Sends the details to the ProfileController
  ///
  final helper = ProfileHelper();
  Future<void> callUpdateApi({
    required String userId,
    required String guestId,
    required String userFlag,
    required String name,
    required String gender,
    required String dob,
    required String smokerType,
    required String weight,
    required String height,
    required String email,
  }) async {
    final data = await helper.updateDetailsMap(
      userId: userId,
      guestId: guestId,
      userFlag: userFlag,
      name: name,
      gender: gender,
      dob: dob,
      smokerType: smokerType,
      weight: weight,
      height: height,
      email: email,
    );
    await callUpdateUGDetails(data: data, userFlag: userFlag);
  }

  Future<void> callUpdateUGDetails({
    required Map<String, dynamic> data,
    required String userFlag,
  }) async {
    await updateDetailsUG(data: data, userFlag: userFlag);
  }

  // ==============================
  // CLEAR
  // ==============================
  void clearProfileData() {
    nameController.clear();
    weightController.clear();
    heightController.clear();
    genderType.value = "";
    smokerType.value = "";
    dobController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    weightController.dispose();
    heightController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
