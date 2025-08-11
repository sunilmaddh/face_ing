import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/health_data/widgets/getvitalStatus.dart';
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
    if (controller.age.value < 18) {
      AppSnackbar.show(
        title: "Age Restriction",
        message: "You must be 18 or older to continue",
      );
    } else {
      AppNavigation.to(
        AppRoutes.mesurementScreen,
        arguments: {
          "scanType": "add-guest",
          "userName": _guestController.nameTextController.text,
        },
      );
    }
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
    debugPrint(controller.age.value.toString());
    controller.weight.value = double.parse(weight);
    controller.height.value = double.parse(height);
    controller.genderType.value = genderType;
    controller.guestId.value = guestId;
    controller.smokerType.value = smokerType;
    if (controller.age.value < 18) {
      AppSnackbar.show(
        title: "Age Restriction",
        message: "You must be 18 or older to continue",
      );
    } else {
      AppNavigation.to(
        AppRoutes.mesurementScreen,
        arguments: {"scanType": "re-scan", "userName": guestName},
      );
    }
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
    var newDob = await AppMethods().convertDateFormatToYY(dob);
    var data = {
      "guestDao": {
        "userId": userId,
        "name": name,
        "gender": gender,
        "dob": newDob,
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

  final statusHelper = Getvitalstatus();
  Future<Map<String, dynamic>> getBinahVitalData({
    required VitalSignsResults vitalSignResult,
  }) async {
    var binahData = {
      "pulseRate": statusHelper.getVitalValue(VitalSignTypes.pulseRate),
      // vitalSignResult.getResult(VitalSignTypes.pulseRate)?.value.toString(),
      "respirationRate": statusHelper.getVitalValue(
        VitalSignTypes.respirationRate,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.respirationRate)
      //     ?.value
      //     .toString(),
      "oxygenSaturation": statusHelper.getVitalValue(
        VitalSignTypes.oxygenSaturation,
      ),
      // vitalSignResult.getResult(VitalSignTypes.oxygenSaturation)?.value,
      "sdnn": statusHelper.getVitalValue(VitalSignTypes.sdnn),
      //  vitalSignResult.getResult(VitalSignTypes.sdnn)?.value.toString(),
      "stressLevel": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
      // vitalSignResult
      //     .getResult(VitalSignTypes.stressLevel)
      //     ?.value
      //     .toString(),
      "rri": vitalSignResult.getResult(VitalSignTypes.rri)?.value.toString(),
      "bloodPressure": statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
      // vitalSignResult
      //     .getResult(VitalSignTypes.bloodPressure)
      //     ?.value
      //     .toString(),
      "stressIndex": statusHelper.getVitalValue(VitalSignTypes.stressIndex),
      // vitalSignResult
      //     .getResult(VitalSignTypes.stressIndex)
      //     ?.value
      //     .toString(),
      "meanRri": statusHelper.getVitalValue(VitalSignTypes.meanRri),
      // vitalSignResult.getResult(VitalSignTypes.meanRri)?.value.toString(),
      "rmssd": statusHelper.getVitalValue(VitalSignTypes.rmssd),
      // vitalSignResult.getResult(VitalSignTypes.rmssd)?.value.toString(),
      "sd1": statusHelper.getVitalValue(VitalSignTypes.sd1),
      // vitalSignResult.getResult(VitalSignTypes.sd1)?.value.toString(),
      "sd2": statusHelper.getVitalValue(VitalSignTypes.sd2),
      // vitalSignResult.getResult(VitalSignTypes.sd2)?.value.toString(),
      "prq": statusHelper.getVitalValue(VitalSignTypes.prq),
      // vitalSignResult.getResult(VitalSignTypes.prq)?.value.toString(),
      "pnsIndex": statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
      // vitalSignResult.getResult(VitalSignTypes.pnsIndex)?.value.toString(),
      "pnsZone": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
      // vitalSignResult.getResult(VitalSignTypes.pnsZone)?.value.toString(),
      "snsIndex": statusHelper.getVitalValue(VitalSignTypes.snsIndex),
      // vitalSignResult.getResult(VitalSignTypes.snsIndex)?.value.toString(),
      "snsZone": statusHelper.getVitalValue(VitalSignTypes.snsZone),
      // vitalSignResult.getResult(VitalSignTypes.snsZone)?.value.toString(),
      "wellnessIndex": statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
      // vitalSignResult
      //     .getResult(VitalSignTypes.wellnessIndex)
      //     ?.value
      //     .toString(),
      "wellnessLevel": statusHelper.getVitalValue(VitalSignTypes.wellnessLevel),
      // vitalSignResult
      //     .getResult(VitalSignTypes.wellnessLevel)
      //     ?.value
      //     .toString(),
      "lfhf": statusHelper.getVitalValue(VitalSignTypes.lfhf),
      // vitalSignResult.getResult(VitalSignTypes.lfhf)?.value.toString(),
      "hemoglobin": statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
      // vitalSignResult
      //     .getResult(VitalSignTypes.hemoglobin)
      //     ?.value
      //     .toString(),
      "hemoglobinA1C": statusHelper.getVitalValue(VitalSignTypes.hemoglobinA1C),
      // vitalSignResult
      //     .getResult(VitalSignTypes.hemoglobinA1C)
      //     ?.value
      //     .toString(),
      "highHemoglobinA1CRisk": statusHelper.getVitalValue(
        VitalSignTypes.highHemoglobinA1CRisk,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.highHemoglobinA1CRisk)
      //     ?.value
      //     .toString(),
      "highBloodPressureRisk": statusHelper.getVitalValue(
        VitalSignTypes.highBloodPressureRisk,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.highBloodPressureRisk)
      //     ?.value
      //     .toString(),
      "ascvdRisk": statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
      // vitalSignResult.getResult(VitalSignTypes.ascvdRisk)?.value.toString(),
      "normalizedStressIndex": statusHelper.getVitalValue(
        VitalSignTypes.normalizedStressIndex,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.normalizedStressIndex)
      //     ?.value
      //     .toString(),
      "heartAge": statusHelper.getVitalValue(VitalSignTypes.heartAge),
      // vitalSignResult.getResult(VitalSignTypes.heartAge)?.value.toString(),
      "highTotalCholesterolRisk": statusHelper.getVitalValue(
        VitalSignTypes.highTotalCholesterolRisk,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.highTotalCholesterolRisk)
      //     ?.value
      //     .toString(),
      "highFastingGlucoseRisk": statusHelper.getVitalValue(
        VitalSignTypes.highFastingGlucoseRisk,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.highFastingGlucoseRisk)
      //     ?.value
      //     .toString(),
      "lowHemoglobinRisk": statusHelper.getVitalValue(
        VitalSignTypes.lowHemoglobinRisk,
      ),
      // vitalSignResult
      //     .getResult(VitalSignTypes.lowHemoglobinRisk)
      //     ?.value
      //     .toString(),
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

  clearLoading() {
    _guestController.isLoading.value = false;
  }

  static List<String> weightList = List.generate(
    161,
    (index) => (index + 40).toString(),
  );
  static List<String> smokerTypeList = ["Smoker", "Non Smoker"];
  static List<String> heightList = List.generate(
    101,
    (index) => (index + 130).toString(),
  );

  final RegExp dateRegex = RegExp(r'^[0-9/]+$');
}
