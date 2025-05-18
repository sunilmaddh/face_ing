import 'dart:convert';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/guest_history_details_model.dart';
import 'package:ntt_data/data/models/guest_list_response_model.dart';
import 'package:ntt_data/data/models/show_guest_history_details.dart';
import 'package:ntt_data/data/repository/services/geust_services.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class GeustController extends GetxController
    with
        CheckboxStateMixin,
        GenderStateMixin,
        CommonMixin,
        ProgressHandlerMixin {
  final nameTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final dobTextController = TextEditingController();
  RxList<GuestHealthAnuraHistory> guestAnuraHistory =
      <GuestHealthAnuraHistory>[].obs;
  RxList<Map<String, dynamic>> anuraHIstoryDetails =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> binahHIstoryDetails =
      <Map<String, dynamic>>[].obs;
  RxList<GuestList> guestList = <GuestList>[].obs;
  RxString sdkType = "".obs;
  RxString genderType = "".obs;
  RxString geustDob = ''.obs;
  RxBool isTermAccepted = false.obs;
  Future<void> getGeustHistory() async {
    var userID = await StorageHelper.read("userID");
    var data = {"userId": userID};
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      guestList.clear();
      // var jsonString = jsonDecode(resposneData["responseBody"]);
      var data = GuestListResponseModel.fromJson(resposneData["responseBody"]);
      guestList.value = data.guestList!;
    } else if (statusCode == 500) {
      guestList.clear();
    } else {
      guestList.clear();
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> getGeustDetails(String guestID) async {
    var userID = await StorageHelper.read("userID");
    var data = {"userId": userID, "guestId": guestID};

    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustDetailsService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      var data = GuestHistoryDetailsModel.fromJson(
        resposneData["responseBody"],
      );
      anuraHIstoryDetails.value = await ShowGuestHistoryDetails()
          .fetchHistoryAnuraDetails(data.guestHealthAnuraHistory!);

      // binahHIstoryDetails.value = await ShowGuestHistoryDetails()
      //     .fetchHistoryBinahDetails(data.guestHealthBinahHistory!);

      AppNavigation.to(AppRoutes.guestHistoryDetails);

      debugPrint(data.toString());
    } else if (statusCode == 500) {
    } else {}
  }

  Future<void> storeBinahHealthForUser(
    VitalSignsResults vitalSignResult,
  ) async {
    var userID = await StorageHelper.read("userID");
    var data = {
      "userId": userID,
      "binahDetails": {
        "pulseRate":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "respirationRate":
            vitalSignResult
                .getResult(VitalSignTypes.respirationRate)
                ?.value
                .toString(),
        "oxygenSaturation":
            vitalSignResult.getResult(VitalSignTypes.oxygenSaturation)?.value,
        "sdnn":
            vitalSignResult.getResult(VitalSignTypes.sdnn)?.value.toString(),
        "stressLevel":
            vitalSignResult
                .getResult(VitalSignTypes.stressLevel)
                ?.value
                .toString(),
        "rri": vitalSignResult.getResult(VitalSignTypes.rri)?.value.toString(),
        "bloodPressure":
            vitalSignResult
                .getResult(VitalSignTypes.bloodPressure)
                ?.value
                .toString(),
        "stressIndex":
            vitalSignResult
                .getResult(VitalSignTypes.snsIndex)
                ?.value
                .toString(),
        "meanRri":
            vitalSignResult.getResult(VitalSignTypes.meanRri)?.value.toString(),
        "rmssd":
            vitalSignResult.getResult(VitalSignTypes.rmssd)?.value.toString(),
        "sd1": vitalSignResult.getResult(VitalSignTypes.sd1)?.value.toString(),
        "sd2": vitalSignResult.getResult(VitalSignTypes.sd2)?.value.toString(),
        "prq": vitalSignResult.getResult(VitalSignTypes.prq)?.value.toString(),
        "pnsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.pnsIndex)
                ?.value
                .toString(),
        "pnsZone":
            vitalSignResult.getResult(VitalSignTypes.pnsZone)?.value.toString(),
        "snsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.snsIndex)
                ?.value
                .toString(),
        "snsZone":
            vitalSignResult.getResult(VitalSignTypes.snsZone)?.value.toString(),
        "wellnessIndex":
            vitalSignResult
                .getResult(VitalSignTypes.wellnessIndex)
                ?.value
                .toString(),
        "wellnessLevel":
            vitalSignResult
                .getResult(VitalSignTypes.wellnessLevel)
                ?.value
                .toString(),
        "lfhf":
            vitalSignResult.getResult(VitalSignTypes.lfhf)?.value.toString(),
        "hemoglobin":
            vitalSignResult
                .getResult(VitalSignTypes.hemoglobin)
                ?.value
                .toString(),
        "hemoglobinA1C":
            vitalSignResult
                .getResult(VitalSignTypes.hemoglobinA1C)
                ?.value
                .toString(),
        "highHemoglobinA1CRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highHemoglobinA1CRisk)
                ?.value
                .toString(),
        "highBloodPressureRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highBloodPressureRisk)
                ?.value
                .toString(),
        "ascvdRisk":
            vitalSignResult
                .getResult(VitalSignTypes.ascvdRisk)
                ?.value
                .toString(),
        "normalizedStressIndex":
            vitalSignResult
                .getResult(VitalSignTypes.normalizedStressIndex)
                ?.value
                .toString(),
        "heartAge":
            vitalSignResult
                .getResult(VitalSignTypes.heartAge)
                ?.value
                .toString(),
        "highTotalCholesterolRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highTotalCholesterolRisk)
                ?.value
                .toString(),
        "highFastingGlucoseRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highFastingGlucoseRisk)
                ?.value
                .toString(),
        "lowHemoglobinRisk":
            vitalSignResult
                .getResult(VitalSignTypes.lowHemoglobinRisk)
                ?.value
                .toString(),
      },
    };

    debugPrint(data.toString());

    Map<String, dynamic> responseData = await GeustServices()
        .storeBinahHealthForUserService(data: data);
    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      AppSnackbar.show(
        title: "Success",
        message: "Store health data Successfully",
      );
    } else if (statusCode == 500) {
      AppSnackbar.show(
        title: "Erro",
        message: "Something went wrong",
        isError: true,
      );
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wron");
    }
  }

  Future<void> addGuest(VitalSignsResults vitalSignResult) async {
    var userID = await StorageHelper.read("userID");
    var data = {
      "guestDao": {
        "userId": userID,
        "name": nameTextController.text,
        "gender": selectionType.value,
        "dob": dobTextController.text,
        "weight": weightTextController.text,
        "height": heightTextController.text,
      },
      "binahDetails": {
        "pulseRate":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "respirationRate":
            vitalSignResult
                .getResult(VitalSignTypes.respirationRate)
                ?.value
                .toString(),
        "oxygenSaturation":
            vitalSignResult.getResult(VitalSignTypes.oxygenSaturation)?.value,
        "sdnn":
            vitalSignResult.getResult(VitalSignTypes.sdnn)?.value.toString(),
        "stressLevel":
            vitalSignResult
                .getResult(VitalSignTypes.stressLevel)
                ?.value
                .toString(),
        "rri": vitalSignResult.getResult(VitalSignTypes.rri)?.value.toString(),
        "bloodPressure":
            vitalSignResult
                .getResult(VitalSignTypes.bloodPressure)
                ?.value
                .toString(),
        "stressIndex":
            vitalSignResult
                .getResult(VitalSignTypes.snsIndex)
                ?.value
                .toString(),
        "meanRri":
            vitalSignResult.getResult(VitalSignTypes.meanRri)?.value.toString(),
        "rmssd":
            vitalSignResult.getResult(VitalSignTypes.rmssd)?.value.toString(),
        "sd1": vitalSignResult.getResult(VitalSignTypes.sd1)?.value.toString(),
        "sd2": vitalSignResult.getResult(VitalSignTypes.sd2)?.value.toString(),
        "prq": vitalSignResult.getResult(VitalSignTypes.prq)?.value.toString(),
        "pnsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.pnsIndex)
                ?.value
                .toString(),
        "pnsZone":
            vitalSignResult.getResult(VitalSignTypes.pnsZone)?.value.toString(),
        "snsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.snsIndex)
                ?.value
                .toString(),
        "snsZone":
            vitalSignResult.getResult(VitalSignTypes.snsZone)?.value.toString(),
        "wellnessIndex":
            vitalSignResult
                .getResult(VitalSignTypes.wellnessIndex)
                ?.value
                .toString(),
        "wellnessLevel":
            vitalSignResult
                .getResult(VitalSignTypes.wellnessLevel)
                ?.value
                .toString(),
        "lfhf":
            vitalSignResult.getResult(VitalSignTypes.lfhf)?.value.toString(),
        "hemoglobin":
            vitalSignResult
                .getResult(VitalSignTypes.hemoglobin)
                ?.value
                .toString(),
        "hemoglobinA1C":
            vitalSignResult
                .getResult(VitalSignTypes.hemoglobinA1C)
                ?.value
                .toString(),
        "highHemoglobinA1CRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highHemoglobinA1CRisk)
                ?.value
                .toString(),
        "highBloodPressureRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highBloodPressureRisk)
                ?.value
                .toString(),
        "ascvdRisk":
            vitalSignResult
                .getResult(VitalSignTypes.ascvdRisk)
                ?.value
                .toString(),
        "normalizedStressIndex":
            vitalSignResult
                .getResult(VitalSignTypes.normalizedStressIndex)
                ?.value
                .toString(),
        "heartAge":
            vitalSignResult
                .getResult(VitalSignTypes.heartAge)
                ?.value
                .toString(),
        "highTotalCholesterolRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highTotalCholesterolRisk)
                ?.value
                .toString(),
        "highFastingGlucoseRisk":
            vitalSignResult
                .getResult(VitalSignTypes.highFastingGlucoseRisk)
                ?.value
                .toString(),
        "lowHemoglobinRisk":
            vitalSignResult
                .getResult(VitalSignTypes.lowHemoglobinRisk)
                ?.value
                .toString(),
      },
    };
    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices().addGeustService(
      data: data,
    );
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
    } else if (statusCode == 500) {
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> removeGuest({required var guestId}) async {
    var userID = await StorageHelper.read("userID");

    var data = {"userId": userID, "guestId": guestId};

    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices().deleteGuest(
      data: data,
    );
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      AppSnackbar.show(title: "Success", message: "Guest remove successfully");
      getGeustHistory();
    } else if (statusCode == 500) {
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  clearData() {
    nameTextController.clear();
    weightTextController.clear();
    heightTextController.clear();
    dobTextController.clear();
    selectionType.value = "";
    isTermAccepted.value = false;
    isChecked.value = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    guestList.clear();
    clearData();

    super.dispose();
  }
}
