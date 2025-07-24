import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
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
    _measurementController.weight.value = double.parse(weight);
    _measurementController.height.value = double.parse(height);
    _measurementController.genderType.value = genderType;
    String cleanDob =
        dobRaw
            .replaceAll("/", "-")
            .replaceAll(RegExp(r'[^\x00-\x7F]'), '')
            .trim();
    _measurementController.age.value = await AppMethods().calculateAge(dobRaw);
    AppNavigation.to(
      AppRoutes.mesurementScreen,
      arguments: {"scanType": "user", "userName": "fff"},
    );
  }
}
