import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class HomeHalper {
  final _measurementController = Get.find<MeasurementController>();

  void callMeasurement() {
    _startMeasurement();
  }

  void _startMeasurement() async {
    _measurementController.isScanningDone.value = false;
    String genderType = await IndoSharedPreference.instance.getGenderType();
    String dobRaw = await IndoSharedPreference.instance.getAge();
    String height = await IndoSharedPreference.instance.getHeight();
    String weight = await IndoSharedPreference.instance.getWeight();
    String name = await IndoSharedPreference.instance.getUserName();
    String smokerType = await IndoSharedPreference.instance.getSmokerType();
    _measurementController.weight.value = double.parse(weight);
    _measurementController.height.value = double.parse(height);
    _measurementController.genderType.value = genderType;
    _measurementController.selectionType.value = smokerType;
    _measurementController.age.value = await AppMethods().calculateAge(dobRaw);

    if (_measurementController.age.value < 18) {
      AppSnackbar.show(
        title: "Age Restriction",
        message: "You must be 18 or older to continue",
      );
    } else {
      AppNavigation.to(
        AppRoutes.mesurementScreen,
        arguments: {"scanType": "user", "userName": name},
      );
    }
  }
}
