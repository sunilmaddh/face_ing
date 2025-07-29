import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';

class GuestHalper {
  final controller = Get.find<MeasurementController>();
  final _guestController = Get.find<GeustController>();
  callMeasurement() {
    _startMeasurement();
  }

  _startMeasurement() async {
    controller.isScanningDone.value = false;
    controller.age.value = await AppMethods().calculateAge(
      _guestController.dobTextController.text,
    );
    debugPrint("Age ${controller.age.value.toString()}");
    controller.weight.value = double.parse(
      _guestController.weightTextController.text,
    );
    controller.height.value = double.parse(
      _guestController.heightTextController.text,
    );
    controller.genderType.value = _guestController.selectionType.value;
    AppNavigation.to(
      AppRoutes.mesurementScreen,
      arguments: {
        "scanType": "add-guest",
        "userName": _guestController.nameTextController.text,
      },
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
  ) {
    _startMeasurementRescan(
      genderType,
      dob,
      weight,
      height,
      smokerType,
      guestId,
      guestName,
    );
  }

  _startMeasurementRescan(
    String genderType,
    String dob,
    String weight,
    String height,
    String smokerType,
    String guestId,
    String guestName,
  ) async {
    controller.isScanningDone.value = false;
    controller.age.value = await AppMethods().calculateAge(dob);
    controller.weight.value = double.parse(weight);
    controller.height.value = double.parse(height);
    controller.genderType.value = genderType;
    controller.guestId.value = guestId;
    controller.smokerType.value = smokerType;
    AppNavigation.to(
      AppRoutes.mesurementScreen,
      arguments: {"scanType": "re-scan", "userName": guestName},
    );
  }

  static bool isValidInput(String input) {
    final regex = RegExp(r'^[a-zA-Z0-9 .]+$');
    return regex.hasMatch(input);
  }

  Future<Map<String, Map<String, dynamic>>> mapData({
    required String userId,
    required String name,
    required String gender,
    required String dob,
    required String weight,
    required String height,
    required String guestImage,

    required VitalSignsResults vitalSignResult,
  }) async {
    var data = {
      "guestDao": {
        "userId": userId,
        "name": name,
        "gender": gender,
        "dob": dob,
        "weight": weight,
        "height": height,
        "smokerType": controller.selectionType.value,
        "guestImage": guestImage,
      },
      "binahDetails": await getBinahVitalData(vitalSignResult: vitalSignResult),
    };
    return data;
  }

  Future<Map<String, dynamic>> userMapData({
    required String userId,
    required String guestId,
    required String isUser,
    required VitalSignsResults vitalSignResult,
  }) async {
    var data = {
      "userId": userId,
      "guestId": guestId,
      "userFlag": isUser,
      "binahDetails": await getBinahVitalData(vitalSignResult: vitalSignResult),
    };
    return data;
  }

  Future<Map<String, dynamic>> getBinahVitalData({
    required VitalSignsResults vitalSignResult,
  }) async {
    var binahData = {
      "pulseRate":
          vitalSignResult.getResult(VitalSignTypes.pulseRate)?.value.toString(),
      "respirationRate":
          vitalSignResult
              .getResult(VitalSignTypes.respirationRate)
              ?.value
              .toString(),
      "oxygenSaturation":
          vitalSignResult.getResult(VitalSignTypes.oxygenSaturation)?.value,
      "sdnn": vitalSignResult.getResult(VitalSignTypes.sdnn)?.value.toString(),
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
              .getResult(VitalSignTypes.stressIndex)
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
          vitalSignResult.getResult(VitalSignTypes.pnsIndex)?.value.toString(),
      "pnsZone":
          vitalSignResult.getResult(VitalSignTypes.pnsZone)?.value.toString(),
      "snsIndex":
          vitalSignResult.getResult(VitalSignTypes.snsIndex)?.value.toString(),
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
      "lfhf": vitalSignResult.getResult(VitalSignTypes.lfhf)?.value.toString(),
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
          vitalSignResult.getResult(VitalSignTypes.ascvdRisk)?.value.toString(),
      "normalizedStressIndex":
          vitalSignResult
              .getResult(VitalSignTypes.normalizedStressIndex)
              ?.value
              .toString(),
      "heartAge":
          vitalSignResult.getResult(VitalSignTypes.heartAge)?.value.toString(),
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
    };

    return binahData;
  }

  clearData() {
    _guestController.nameTextController.clear();
    _guestController.weightTextController.clear();
    _guestController.heightTextController.clear();
    _guestController.dobTextController.clear();
    _guestController.selectionType.value = "";
    _guestController.isTermAccepted.value = false;
    _guestController.isChecked.value = false;
    _guestController.profileUrl.value = File("");
    _guestController.isProfile.value = false;
    controller.smokerTypeController.clear();
    controller.selectionType.value = "";
    _guestController.selectionType.value = "";
  }

  static List<String> weightList = List.generate(
    161,
    (index) => (index + 40).toString(),
  );
  static List<String> smokerTypeList = ["Smoker", "Non Smoker"];
  static List<String> heightList = List.generate(
    121,
    (index) => (index + 130).toString(),
  );

  final RegExp dateRegex = RegExp(r'^[0-9/]+$');
}
