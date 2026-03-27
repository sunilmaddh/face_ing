import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/storage/secure_storage.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/helper/globle_halper.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/requets/update_details_request.dart';
import 'package:ntt_data/modules/profile/models/requets/user_health_details_request.dart';
import 'package:ntt_data/modules/profile/models/requets/user_history_request.dart';
import 'package:ntt_data/modules/profile/models/requets/vital_description_request.dart';
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
  final RxBool imageProfileLoading = false.obs;

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
      final userID = AppPreferences.instance.getUserId();

      final request = UserHistoryRequest(userId: userID, userFlag: "true");

      final responseData = await profileRepository.getUserHealthHistory(
        data: request,
      );

      if (responseData.statusCode == 200) {
        userHealthList.clear();
        final result = responseData.data;
        userHealthList.value = result?.userHealthList ?? [];
      } else {
        userHealthList.clear();
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      userHealthList.clear();
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> getUserHealthDetails({
    required dynamic healthId,
    required dynamic isFullHistory,
  }) async {
    showLoading(true);

    try {
      final userID = AppPreferences.instance.getUserId();

      final request = UserHealthDetailsRequest(
        userId: userID,
        healthId: healthId,
        isFullHistory: isFullHistory,
      );

      final responseData = await profileRepository.getUserHealthDetails(
        data: request,
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
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      binahHIstoryDetails.clear();
      clearHealthCategarie();
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> updateDetailsUG({
    required UpdateDetailsRequest data,
    required String userFlag,
  }) async {
    showLoading(true);

    try {
      final responseData = await profileRepository.updateDetailsUG(data: data);
      if (responseData.statusCode == 200) {
        final result = responseData.data;
        navigateBack();
        if (userFlag == "true") {
          final isFullStory = AppPreferences.instance.getHistoryType();
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
        setSuccess(ValidationStrings.updateDetailsSuccess);
        clearProfileData();
      } else {
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> getVitalDescryption({required dynamic vitalKey}) async {
    isVitalDescriptionLoading(true);

    try {
      final request = VitalDescriptionRequest(vitalKey: vitalKey);

      final responseData = await profileRepository.getVitalDescription(
        data: request,
      );

      if (responseData.statusCode == 200) {
        final result = responseData.data;

        vitalDescriptionModel.value = result!;
        vitalDesc.value = vitalDescriptionModel.value.vitalDesc.toString();
      } else {
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      isVitalDescriptionLoading(false);
    }
  }

  Future<void> logoutUser() async {
    isLoadingLogout(true);
    try {
      final responseData = await profileRepository.logoutUser();
      if (responseData.statusCode == 200) {
        SecureStorageService.instance.clearAll;
        AppMethods().logout();
        setSuccess(ValidationStrings.logoutSucess);
      } else {
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      isLoadingLogout(false);
    }
  }

  Future<void> initializeData() async {
    userName.value = AppPreferences.instance.getUserName();
    userEmail.value = AppPreferences.instance.getUserEmail();
    userImage.value = AppPreferences.instance.getUserImage();
  }

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
    final request = await helper.updateDetailsRequest(
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
    await callUpdateUGDetails(request: request, userFlag: userFlag);
  }

  Future<void> callUpdateUGDetails({
    required UpdateDetailsRequest request,
    required String userFlag,
  }) async {
    await updateDetailsUG(data: request, userFlag: userFlag);
  }

  Future<void> uploadProfile({required String imagePath}) async {
    imageProfileLoading(true);
    try {
      var response = await profileRepository.uploadImage(
        filePath: imagePath,
        imageType: "",
      );
      if (response.success) {
        final result = response.data;
        userImage.value = result?.imagePath ?? "";
        AppPreferences.instance.saveUserImage(result?.imagePath ?? "");
        imageProfileLoading(false);
      } else {
        imageProfileLoading(false);
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      setError(e.toString());
      debugPrint(e.toString());
      imageProfileLoading(false);
    } finally {
      imageProfileLoading(false);
    }
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
