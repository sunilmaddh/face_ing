import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/data/repository/services/vital_graph_services.dart';

class VitalGraphController extends GetxController {
  RxBool isFilterTypeSelected = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  Rx<VitalGraphResponseModel> vitalGraphResponse =
      VitalGraphResponseModel().obs;
  Rx<AdvancedHeartRateVariability> wellnessGraphResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> vitalSignesponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> bloodlessResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> risksResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> stressResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> hrvResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> ahrvResponse =
      AdvancedHeartRateVariability().obs;
  var services = VitalGraphServices();
  RxString selectedValue = "Weekly".obs;
  RxInt touchedIndex = (-1).obs;
  RxBool isTouched = false.obs;
  RxDouble fontSize = 0.0.obs;
  RxDouble radius = 0.0.obs;
  RxString selectedDate = "".obs;
  RxString isGraphFilterType = "".obs;

  Future<void> callVitalGraphDataApi({
    required Map<String, dynamic> data,
    required bool isFromHistory,
  }) async {
    isLoading(true);

    debugPrint(data.toString());
    Map<String, dynamic> responseData = await services
        .callVitalGraphApiServices(data: data);
    int statusCode = responseData["statusCode"];
    isLoading(false);
    try {
      if (statusCode == 200) {
        await clearData();
        var result = responseData[AppConstents.response];
        vitalGraphResponse.value = VitalGraphResponseModel.fromJson(result);
        wellnessGraphResponse.value = vitalGraphResponse.value.wellness!;
        vitalSignesponse.value = vitalGraphResponse.value.vitalSigns!;
        bloodlessResponse.value = vitalGraphResponse.value.bloodlessBloodTests!;
        risksResponse.value = vitalGraphResponse.value.risks!;
        stressResponse.value = vitalGraphResponse.value.stress!;
        hrvResponse.value = vitalGraphResponse.value.hrvSddnn!;
        ahrvResponse.value =
            vitalGraphResponse.value.advancedHeartRateVariability!;
        hrvResponse.value.vitalTypeDetails!.first.yValues!.clear();

        List<String> li = ["0.0", "75.0", "150.0"];
        hrvResponse.value.vitalTypeDetails!.first.yValues!.addAll(li);
        if (isFromHistory) {
          isFromHistory = false;
        }
      } else if (statusCode == 403) {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: false,
        );
      } else {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: false,
        );
      }
    } catch (e) {
      isLoading(false);
      // AppSnackbar.show(title: "Error", message: e.toString(), isError: false);
    }
  }

  Future<void> clearData() async {
    vitalGraphResponse.value = VitalGraphResponseModel();
    vitalSignesponse.value = AdvancedHeartRateVariability();
    bloodlessResponse.value = AdvancedHeartRateVariability();
    stressResponse.value = AdvancedHeartRateVariability();
    risksResponse.value = AdvancedHeartRateVariability();
    hrvResponse.value = AdvancedHeartRateVariability();
    ahrvResponse.value = AdvancedHeartRateVariability();
  }
}
