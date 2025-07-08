import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class GuestHalper {
  final controller = Get.find<MeasurementController>();
  final _guestController = Get.find<GeustController>();
  callMeasurement() {
    _startMeasurement();
  }

  _startMeasurement() async {
    controller.isScanningDone.value = false;
    DateTime parsedDate = DateTime.parse(
      _guestController.dobTextController.text.replaceAll("/", "-"),
    );
    controller.age.value = await AppMethods().calculateAge(parsedDate);
    controller.weight.value = double.parse(
      _guestController.weightTextController.text,
    );
    controller.height.value = double.parse(
      _guestController.heightTextController.text,
    );
    controller.genderType.value = _guestController.selectionType.value;
    _guestController.scanType.value = "guest";
    AppNavigation.off(
      AppRoutes.mesurementScreen,
      arguments: {
        "scanType": "add-guest",
        "userName": _guestController.nameTextController.text,
      },
    );
  }
}
