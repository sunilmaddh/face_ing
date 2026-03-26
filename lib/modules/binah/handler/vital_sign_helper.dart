import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_mean_rri.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_prq.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_respiration_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_rri.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_sdnn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';

class VitalSignHelper {
  final _measurementController = Get.find<MeasurementController>();
  String vitalSignPulseRateConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.pulseRate,
    );
    VitalSignPulseRate pulseRate;
    if (vitalSign != null && vitalSign is VitalSignPulseRate) {
      pulseRate = vitalSign;

      debugPrint(
        "pulse Rate Confidence Level: ${pulseRate.confidence?.level.toString() ?? "N/A"}",
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

      debugPrint(
        "Breathing rate Confidence Level: ${respirationRate.confidence?.level.toString() ?? "N/A"}",
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

      debugPrint(
        "SDNN Confidence Level: ${sdnn.confidence?.level.toString() ?? "N/A"}",
      );
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
      debugPrint(
        "MeanRri Confidence Level: ${meanRri.confidence?.level.toString() ?? "N/A"}",
      );
      return meanRri.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignPrqConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.prq,
    );
    if (vitalSign != null && vitalSign is VitalSignPrq) {
      VitalSignPrq prq = vitalSign;
      return prq.confidence?.level.toString() ?? "";
    }
    return "";
  }

  String vitalSignRriConfidence() {
    VitalSign? vitalSign = _measurementController.vitalsResults.value.getResult(
      VitalSignTypes.rri,
    );
    if (vitalSign != null && vitalSign is VitalSignRri) {
      VitalSignRri rri = vitalSign;

      return rri.confidence?.level.toString() ?? "";
    }
    return "";
  }
}

class MeasurementHelper {
  final List<String> scanMessageList;
  MeasurementHelper({required this.scanMessageList});

  final List<RangeValues> ranges = [
    RangeValues(0, 15),
    RangeValues(16, 30),
    RangeValues(31, 45),
    RangeValues(46, 60),
    RangeValues(61, 75),
    RangeValues(76, 90),
    RangeValues(91, 100),
  ];

  String getProgressMessage(int progress) {
    for (int i = 0; i < ranges.length; i++) {
      if (progress >= ranges[i].start && progress <= ranges[i].end) {
        return scanMessageList[i];
      }
    }
    return ""; // default if out-of-range
  }
}
