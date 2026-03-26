import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/helper/globle_halper.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/modules/geust/models/guest_history_details_model.dart';
import 'package:ntt_data/modules/geust/models/guest_list_response_model.dart';
import 'package:ntt_data/modules/geust/repositoriese/guest_repository.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';
import 'package:ntt_data/routes/app_routes.dart';

class GeustController extends BaseController
    with
        CheckboxStateMixin,
        RadioStateMixin,
        CommonMixin,
        ProgressHandlerMixin {
  GeustController({required this.guestRepository});

  final GuestRepository guestRepository;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final dobTextController = TextEditingController();

  final RxList<Widget> tabWidget = <Widget>[].obs;

  final RxList<GuestHealthAnuraHistory> guestAnuraHistory =
      <GuestHealthAnuraHistory>[].obs;
  final RxList<Map<String, dynamic>> anuraHIstoryDetails =
      <Map<String, dynamic>>[].obs;
  final RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;
  final RxList<UserHealthList> guestHealthList = <UserHealthList>[].obs;
  final RxBool isHomeLoading = false.obs;
  final RxList<GuestList> guestList = <GuestList>[].obs;
  final RxString sdkType = "".obs;
  final RxString genderType = "".obs;
  final RxString geustDob = ''.obs;
  final RxString guestId = "".obs;
  final RxBool isTermAccepted = false.obs;
  final RxString guestImage = "".obs;
  final RxList<HealthDetailList> healthDetailsList = <HealthDetailList>[].obs;
  final RxList<GuestList> filteredItems = <GuestList>[].obs;
  final RxBool isFullStory = false.obs;

  Future<void> getGeustHistory() async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final responseData = await guestRepository.getGeustHistory(
        userId: userID,
      );

      if (responseData.statusCode == 200) {
        guestList.clear();
        filteredItems.clear();
        profileUrl.value = File("");
        isProfile.value = false;

        final data = responseData.data;
        guestList.value = data?.guestList ?? <GuestList>[];
      } else if (responseData.statusCode == 500) {
        guestList.clear();
        filteredItems.clear();
      } else {
        guestList.clear();
        filteredItems.clear();
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      guestList.clear();
      filteredItems.clear();
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> getGeustDetails(
    String guestID,
    String scanId,
    bool isFullHistory,
  ) async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final responseData = await guestRepository.getGeustDetails(
        userId: userID,
        guestId: guestID,
        scanId: scanId,
        isFullHistory: isFullHistory,
      );

      if (responseData.statusCode == 200) {
        clearHealthCategarie();

        final data = responseData.data;
        healthDetailsList.value = data?.healthDetail ?? <HealthDetailList>[];

        await GlobleHalper().storeTabData(
          data ?? HealthDetailsResponseModel(),
          this,
          "guest",
        );

        navigateTo(AppRoutes.guestHistoryDetails);
      } else if (responseData.statusCode == 500) {
        clearHealthCategarie();
      } else {
        clearHealthCategarie();
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      clearHealthCategarie();
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> storeBinahHealthForUser(
    VitalSignsResults vitalSignResult, {
    required String guestId,
    required String isUser,
  }) async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final data = await GuestHelper().userMapData(
        userId: userID,
        guestId: guestId,
        isUser: isUser,
        vitalSignResult: vitalSignResult,
      );

      final responseData = await guestRepository.storeBinahHealthForUser(
        data: data,
      );

      if (responseData.statusCode == 200) {
        setSuccess("Store health data successfully");
      } else {
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> addGuest(VitalSignsResults vitalSignResult) async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final data = await GuestHelper().mapData(
        userId: userID,
        name: nameTextController.text.trim(),
        gender: selectionType.value,
        dob: dobTextController.text.trim(),
        weight: weightTextController.text.trim(),
        height: heightTextController.text.trim(),
        guestImage: guestImage.value,
        vitalSignResult: vitalSignResult,
        email: emailTextController.text.trim(),
        smokerType: Get.find<MeasurementController>().smokerType.value,
      );

      final responseData = await guestRepository.addGeust(data: data);

      if (responseData.statusCode == 200) {
        guestImage.value = "";
        setSuccess("Guest added successfully");
      } else {
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> removeGuest({required dynamic guestId}) async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final responseData = await guestRepository.deleteGuest(
        userId: userID,
        guestId: guestId,
      );

      if (responseData.statusCode == 200) {
        setSuccess("Guest removed successfully");
        await getGeustHistory();
      } else {
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> getGuestHealthHistory() async {
    showLoading(true);

    try {
      final userID = await IndoSharedPreference.instance.getUserId();
      final responseData = await guestRepository.getUserHealthHistory(
        userId: userID,
        isUser: 'false',
        guestId: guestId.value,
      );

      if (responseData.statusCode == 200) {
        guestHealthList.clear();
        final result = responseData.data;
        guestHealthList.value = result?.userHealthList ?? <UserHealthList>[];

        navigateTo(
          AppRoutes.guestHealthHistoryList,
          arguments: {"guestId": guestId.value},
        );
      } else {
        guestHealthList.clear();
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      guestHealthList.clear();
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  void search(String query) {
    if (query.trim().isEmpty) {
      filteredItems.clear();
      return;
    }

    filteredItems.value =
        guestList.where((item) {
          final name = item.name ?? "";
          return name.toLowerCase().contains(query.toLowerCase());
        }).toList();
  }

  Future<void> startMeasurement() async {
    final helper = GuestHelper();

    final age = await helper.calculateAge(dobTextController.text);

    if (!helper.isAdult(age)) {
      setError("You must be 18 or older to continue");
      return;
    }
    Get.find<MeasurementController>()
      ..age.value = age
      ..weight.value = double.parse(weightTextController.text)
      ..height.value = double.parse(heightTextController.text)
      ..genderType.value = selectionType.value;
    navigateTo(
      AppRoutes.mesurementScreen,
      arguments: {"scanType": "add-guest", "userName": nameTextController.text},
    );
  }

  callReScanMeasurement(
    String genderType,
    String dob,
    String weight,
    String height,
    String smokerType,
    String guestId,
    String guestName,
  ) async {
    final helper = GuestHelper();

    final age = await helper.calculateAge(dob);

    if (!helper.isAdult(age)) {
      setError("You must be 18 or older to continue");
      return;
    }

    Get.find<MeasurementController>()
      ..isScanningDone.value = false
      ..age.value = age
      ..weight.value = double.parse(weight)
      ..height.value = double.parse(height)
      ..genderType.value = genderType
      ..guestId.value = guestId
      ..smokerType.value = smokerType;
    navigateTo(
      AppRoutes.mesurementScreen,
      arguments: {"scanType": "add-guest", "userName": nameTextController.text},
    );
  }

  Future<void> uploadProfile({required String imagePath}) async {
    try {
      var response = await guestRepository.uploadImage(
        filePath: imagePath,
        imageType: "",
      );
      if (response.success) {
        final result = response.data;
        // userImage.value = result?.imagePath ?? "";
        // IndoSharedPreference.instance.saveUserImage(result?.imagePath ?? "");
        // debugPrint("Result $result ${userUpdateImage.value}");
      } else {
        setError("Something went wrong");
      }
    } catch (e) {
      setError(e.toString());
      debugPrint(e.toString());
    }
  }

  void clearGuestForm() {
    nameTextController.clear();
    emailTextController.clear();
    weightTextController.clear();
    heightTextController.clear();
    dobTextController.clear();

    guestImage.value = "";
    isTermAccepted.value = false;
    selectionType.value = "";
  }

  @override
  void onClose() {
    // nameTextController.dispose();
    // emailTextController.dispose();
    // weightTextController.dispose();
    // heightTextController.dispose();
    // dobTextController.dispose();

    guestList.clear();
    filteredItems.clear();
    guestHealthList.clear();
    // GuestHelper().clearData();

    super.onClose();
  }
}
