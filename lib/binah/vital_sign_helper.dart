import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_mean_rri.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_prq.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_respiration_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_sdnn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

class VitalSignHelper {
  final _measurementController = Get.find<MeasurementController>();
  String vitalSignPulseRateConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.pulseRate,
    );
    VitalSignPulseRate pulseRate;
    if (vitalSign != null && vitalSign is VitalSignPulseRate) {
      pulseRate = vitalSign;
      debugPrint("Pulse Rate: ${pulseRate.value}");
      print(
        "Confidence Level: ${pulseRate.confidence?.level.toString() ?? "N/A"}",
      );
      return pulseRate.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignBreathingConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.respirationRate,
    );

    if (vitalSign != null && vitalSign is VitalSignRespirationRate) {
      VitalSignRespirationRate respirationRate = vitalSign;
      debugPrint("Pulse Rate: ${respirationRate.value}");
      print(
        "Confidence Level: ${respirationRate.confidence?.level.toString() ?? "N/A"}",
      );
      return respirationRate.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignSDNNConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.sdnn,
    );

    if (vitalSign != null && vitalSign is VitalSignSdnn) {
      VitalSignSdnn sdnn = vitalSign;
      debugPrint("Pulse Rate: ${sdnn.value}");
      print("Confidence Level: ${sdnn.confidence?.level.toString() ?? "N/A"}");
      return sdnn.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignMeanRriConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.meanRri,
    );

    if (vitalSign != null && vitalSign is VitalSignMeanRri) {
      VitalSignMeanRri meanRri = vitalSign;
      debugPrint("Pulse Rate: ${meanRri.value}");
      print(
        "Confidence Level: ${meanRri.confidence?.level.toString() ?? "N/A"}",
      );
      return meanRri.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignPrqConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.pulseRate,
    );

    if (vitalSign != null && vitalSign is VitalSignPrq) {
      VitalSignPrq prq = vitalSign;
      debugPrint("Pulse Rate: ${prq.value}");
      print("Confidence Level: ${prq.confidence?.level.toString() ?? "N/A"}");
      return prq.confidence?.level.toString() ?? "";
    }
    return "";
  }
}
