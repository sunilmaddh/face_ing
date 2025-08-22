import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/data/repository/services/vital_graph_services.dart';

class VitalGraphController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<VitalGraphResponseModel> vitalGraphResponse =
      VitalGraphResponseModel().obs;
  var services = VitalGraphServices();
  Future<void> callVitalGraphDataApi({required var data}) async {
    var data = {};
    Map<String, dynamic> responseData = await services
        .callVitalGraphApiServices(data: data);
    int statusCode = responseData["statusCode"];
    try {
      if (statusCode == 200) {
        var result = responseData[AppConstents.response];
        vitalGraphResponse.value = VitalGraphResponseModel.fromJson(result);
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
