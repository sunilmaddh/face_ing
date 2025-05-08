import 'dart:convert';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/guest_history_details_model.dart';
import 'package:ntt_data/data/models/guest_list_response_model.dart';
import 'package:ntt_data/data/models/show_guest_history_details.dart';
import 'package:ntt_data/data/repository/services/geust_services.dart';

class GeustController extends GetxController
    with CheckboxStateMixin, GenderStateMixin, CommonMixin {
  final nameTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final dobTextController = TextEditingController();
  RxList<GuestHealthAnuraHistory> guestAnuraHistory =
      <GuestHealthAnuraHistory>[].obs;
  RxList<GuestList> guestList = <GuestList>[].obs;
  RxString sdkType = "".obs;
  RxString genderType = "".obs;
  RxString geustDob = ''.obs;
  RxBool isTermAccepted = false.obs;
  Future<void> getGeustHistory() async {
    var data = {"userId": "1000000003"};
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      // var jsonString = jsonDecode(resposneData["responseBody"]);
      var data = GuestListResponseModel.fromJson(resposneData["responseBody"]);
      guestList.value = data.guestList!;
    } else if (statusCode == 500) {
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> getGeustDetails(String guestID) async {
    var data = {"userId": "1000000001", "guestId": guestID};
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustDetailsService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      var data = GuestHistoryDetailsModel.fromJson(
        resposneData["responseBody"],
      );

      guestAnuraHistory.value =
          ShowGuestHistoryDetails().fetchHistoryDetails(
                data.guestHealthAnuraHistory!,
              )
              as List<GuestHealthAnuraHistory>;
      debugPrint(data.toString());
    } else if (statusCode == 500) {
    } else {}
  }

  Future<void> addGuest(VitalSignsResults vitalSignResult) async {
    var data = {
      "guestDao": {
        "userId": "1000000004",
        "name": nameTextController.text,
        "gender": genderType.value,
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
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "oxygenSaturation":
            vitalSignResult.getResult(VitalSignTypes.pulseRate)?.value,
        "sdnn":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "stressLevel":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "rri":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "bloodPressure":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "stressIndex":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "meanRri":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "rmssd":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "sd1":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "sd2":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "prq":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "pnsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "pnsZone":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
                ?.value
                .toString(),
        "snsIndex":
            vitalSignResult
                .getResult(VitalSignTypes.pulseRate)
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
}
