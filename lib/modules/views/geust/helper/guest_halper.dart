import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/views/binah/handler/vital_sign_helper.dart';
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
      "healthInfoMap": {
        "pulseRate": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pulseRate),
          "vitalConfidece": VitalSignHelper().vitalSignPulseRateConfidence(),
        },
        "respirationRate": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.respirationRate,
          ),
          "vitalConfidence": VitalSignHelper().vitalSignBreathingConfidence(),
        },
        "oxygenSaturation": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.oxygenSaturation,
          ),
          "vitalConfidence": "",
        },
        "sdnn": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sdnn),
          "vitalConfidence": VitalSignHelper().vitalSignSDNNConfidence(),
        },
        "stressLevel": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
          "vitalConfidence": "",
        },
        "rri": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.rri),
          "vitalConfidence": VitalSignHelper().vitalSignRriConfidence(),
        },
        "bloodPressure": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.bloodPressure,
          ),
          "vitalConfidence": "",
        },
        "stressIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.stressIndex),
          "vitalConfidence": "",
        },
        "meanRri": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.meanRri),
          "vitalConfidence": VitalSignHelper().vitalSignMeanRriConfidence(),
        },
        "rmssd": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.rmssd),
          "vitalConfidence": "",
        },
        "sd1": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sd1),
          "vitalConfidence": "",
        },
        "sd2": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sd2),
          "vitalConfidence": "",
        },
        "prq": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.prq),
          "vitalConfidence": VitalSignHelper().vitalSignPrqConfidence(),
        },
        "pnsIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
          "vitalConfidence": "",
        },
        "pnsZone": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
          "vitalConfidence": "",
        },
        "snsIndex": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.snsIndex),
          "vitalConfidence": "",
        },
        "snsZone": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.snsZone),
          "vitalConfidence": "",
        },
        "wellnessIndex": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.wellnessIndex,
          ),
          "vitalConfidence": "",
        },
        "wellnessLevel": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.wellnessLevel,
          ),
          "vitalConfidence": "",
        },
        "lfhf": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.lfhf),
          "vitalConfidence": "",
        },
        "hemoglobin": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
          "vitalConfidence": "",
        },
        "hemoglobinA1C": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.hemoglobinA1C,
          ),
          "vitalConfidence": "",
        },
        "highHemoglobinA1CRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highHemoglobinA1CRisk,
          ),
          "vitalConfidence": "",
        },
        "highBloodPressureRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highBloodPressureRisk,
          ),
          "vitalConfidence": "",
        },
        "ascvdRisk": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
          "vitalConfidence": "",
        },
        "normalizedStressIndex": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.normalizedStressIndex,
          ),
          "vitalConfidence": "",
        },
        "heartAge": {
          "vitalValue": statusHelper.getVitalValue(VitalSignTypes.heartAge),
          "vitalConfidence": "",
        },
        "highTotalCholesterolRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highTotalCholesterolRisk,
          ),
          "vitalConfidence": "",
        },
        "highFastingGlucoseRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.highFastingGlucoseRisk,
          ),
          "vitalConfidence": "",
        },
        "lowHemoglobinRisk": {
          "vitalValue": statusHelper.getVitalValue(
            VitalSignTypes.lowHemoglobinRisk,
          ),
          "vitalConfidence": "",
        },
      },
    };
    // var binahData = {
    //   "pulseRate": statusHelper.getVitalValue(VitalSignTypes.pulseRate),
    //   "respirationRate": statusHelper.getVitalValue(
    //     VitalSignTypes.respirationRate,
    //   ),
    //   "oxygenSaturation": statusHelper.getVitalValue(
    //     VitalSignTypes.oxygenSaturation,
    //   ),
    //   "sdnn": statusHelper.getVitalValue(VitalSignTypes.sdnn),
    //   "stressLevel": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
    //   "rri": statusHelper.getVitalValue(VitalSignTypes.rri),
    //   "bloodPressure": statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
    //   "stressIndex": statusHelper.getVitalValue(VitalSignTypes.stressIndex),
    //   "meanRri": statusHelper.getVitalValue(VitalSignTypes.meanRri),
    //   "rmssd": statusHelper.getVitalValue(VitalSignTypes.rmssd),
    //   "sd1": statusHelper.getVitalValue(VitalSignTypes.sd1),
    //   "sd2": statusHelper.getVitalValue(VitalSignTypes.sd2),
    //   "prq": statusHelper.getVitalValue(VitalSignTypes.prq),
    //   "pnsIndex": statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
    //   "pnsZone": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
    //   "snsIndex": statusHelper.getVitalValue(VitalSignTypes.snsIndex),
    //   "snsZone": statusHelper.getVitalValue(VitalSignTypes.snsZone),
    //   "wellnessIndex": statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
    //   "wellnessLevel": statusHelper.getVitalValue(VitalSignTypes.wellnessLevel),
    //   "lfhf": statusHelper.getVitalValue(VitalSignTypes.lfhf),
    //   "hemoglobin": statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
    //   "hemoglobinA1C": statusHelper.getVitalValue(VitalSignTypes.hemoglobinA1C),
    //   "highHemoglobinA1CRisk": statusHelper.getVitalValue(
    //     VitalSignTypes.highHemoglobinA1CRisk,
    //   ),
    //   "highBloodPressureRisk": statusHelper.getVitalValue(
    //     VitalSignTypes.highBloodPressureRisk,
    //   ),
    //   "ascvdRisk": statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
    //   "normalizedStressIndex": statusHelper.getVitalValue(
    //     VitalSignTypes.normalizedStressIndex,
    //   ),
    //   "heartAge": statusHelper.getVitalValue(VitalSignTypes.heartAge),
    //   "highTotalCholesterolRisk": statusHelper.getVitalValue(
    //     VitalSignTypes.highTotalCholesterolRisk,
    //   ),
    //   "highFastingGlucoseRisk": statusHelper.getVitalValue(
    //     VitalSignTypes.highFastingGlucoseRisk,
    //   ),
    //   "lowHemoglobinRisk": statusHelper.getVitalValue(
    //     VitalSignTypes.lowHemoglobinRisk,
    //   ),
    // };
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
    116,
    (index) => (index + 40).toString(),
  );
  static List<String> smokerTypeList = ["Smoker", "Non Smoker"];
  static List<String> heightList = List.generate(
    101,
    (index) => (index + 130).toString(),
  );

  final RegExp dateRegex = RegExp(r'^[0-9/]+$');
}
