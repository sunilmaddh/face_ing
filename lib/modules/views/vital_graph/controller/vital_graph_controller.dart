import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/data/repository/services/vital_graph_services.dart';

class VitalGraphController extends GetxController {
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
  Future<void> callVitalGraphDataApi({
    required Map<String, dynamic> data,
  }) async {
    Map<String, dynamic> responseData = await services
        .callVitalGraphApiServices(data: data);
    int statusCode = responseData["statusCode"];
    try {
      if (statusCode == 200) {
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
      } else if (statusCode == 403) {
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      } else {
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      }
    } catch (e) {
      AppSnackbar.show(title: "Error", message: e.toString());
    }
  }
}
