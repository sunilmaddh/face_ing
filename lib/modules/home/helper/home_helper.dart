import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/home/controller/home_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class HomeHalper {
  final _measurementController = Get.find<MeasurementController>();
  final _homeController = Get.find<HomeController>();

  void callMeasurement() {
    _startMeasurement();
  }

  void _startMeasurement() async {
    _measurementController.isScanningDone.value = false;
    String genderType = AppPreferences.instance.getGenderType();
    String dobRaw = AppPreferences.instance.getAge();
    String height = AppPreferences.instance.getHeight();
    String weight = AppPreferences.instance.getWeight();
    String name = AppPreferences.instance.getUserName();
    String smokerType = AppPreferences.instance.getSmokerType();
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
        action: () {
          _homeController.getWellnessScore();
        },
      );
    }
  }

  Color getWellnessColor(String status) {
    switch (status.toLowerCase()) {
      case 'low':
        return const Color(0xFFFA704E);
      case 'medium':
      case 'mild':
        return const Color(0xFFEEC000);

      case 'high':
        return const Color(0xFF1BC76D);

      default:
        return Colors.white;
    }
  }

  Color getBloodColor(String status) {
    switch (status.toLowerCase()) {
      case 'low':
        return Color(0xFFEEC000);
      case 'normal':
        return const Color(0xFF1BC76D);

      case 'high':
        return const Color(0xFFFA704E);

      default:
        return Colors.white;
    }
  }
}
