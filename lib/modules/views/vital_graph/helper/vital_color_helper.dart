import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_graph_status.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/common_graph_card.dart';
// Replace with your actual asset paths

class VitalColorHelper {
  bool isBreathing = false;
  bool isBlood = false;
  bool isHighLow = false;
  bool isStress = false;
  bool isWellnessScore = false;
  bool isLowGood = false;
  String vitalValue = "";

  final String vitalName;
  String vitalStatus;

  VitalColorHelper({
    required this.vitalName,
    required this.vitalStatus,
    required this.isLowGood,
  }) {
    _initializeFlags();
  }

  void _initializeFlags() {
    if (isLowGood) {
      if (_isBreathingVital()) {
        isBreathing = true;
      } else if (vitalName == "Blood Pressure") {
        isBlood = true;
      } else if (_isHighLowRiskVital()) {
        isHighLow = true;
      } else if (vitalName == "Stress Level") {
        isStress = true;
      } else if (vitalName == "Normalized Stress Index") {
        isStress = true;
      } else if (vitalName == "Wellness Score") {
        isWellnessScore = true;
      } else if ((vitalName == "PNS Index" && vitalStatus == "Low") ||
          (vitalName == "Recovery Ability (PNS Zone)" &&
              vitalStatus == "Low") ||
          (vitalName == "LF/HF" && vitalStatus == "Low") ||
          (vitalName == "ASCVD Risk" && vitalStatus == "High") ||
          (vitalName == "SNS Index" && vitalStatus == "High")) {
        isLowGood = false;
      }
      if ((vitalName == "Mean RRi" && vitalStatus == "Low") ||
          (vitalName == "RMSSD" && vitalStatus == "Low")) {
        isLowGood = false;
      }
    }
  }

  bool _isBreathingVital() {
    return [
      "Breathing Rate",
      "Pulse Rate(Heart Rate)",
      "PRQ",
      "Hemoglobin",
    ].contains(vitalName);
  }

  bool _isHighLowRiskVital() {
    return [
      "High Blood Pressure Risk",
      "High HbA1c Risk",
      "High Fasting Glucose Risk",
      "High Total Cholesterol Risk",
      "Low Hemoglobin Risk",
      "Stress Response (SNS Zone)",
    ].contains(vitalName);
  }

  /// Returns color based on vitalStatus and internal flagss
  Color getColor() {
    switch (vitalStatus.toLowerCase()) {
      case 'low':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isWellnessScore
            ? const Color(0xFFFA704E)
            : isBlood
            ? const Color(0xFFEEC000)
            : isLowGood
            ? const Color(0xFF1BC76D)
            : const Color(0xFFFA704E);

      case 'normal':
        return isBreathing
            ? Color(0xFF1BC76D)
            : isBlood
            ? Color(0xFF1BC76D)
            : isStress
            ? Color(0xff9ED042)
            : isLowGood
            ? Color(0xFFEEC000)
            : Color(0xFF1BC76D);

      case 'medium':
      case 'mild':
        return const Color(0xFFEEC000);

      case 'high':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isBlood
            ? const Color(0xFFFA704E)
            : isStress
            ? Color(0xffED9A33)
            : isHighLow
            ? Color(0xFFFA704E)
            : isLowGood
            ? const Color(0xFF1BC76D)
            : const Color(0xFFFA704E);

      case 'very high':
        return isLowGood ? const Color(0xFFFA704E) : const Color(0xFF1BC76D);
      case 'prediabetes risk':
      case 'prediabetes':
        return const Color(0xFFEEC000);
      case 'diabetes risk':
      case 'diabetes':
        return const Color(0xFFFA704E);

      default:
        return Colors.white;
    }
  }
}

Color getStatusAndIsTypical(
  String vitalName,
  String value,
  List<HealthList> healthList,
) {
  // if (isNumeric(value)) {

  // }

  if (isNumeric(value)) {
    var vitalHelper = VitalColorHelper(
      vitalName: vitalName,
      vitalStatus: VitalGraphStatus().getStatus(vitalName, value),
      isLowGood: stringToBool(healthList.first.isTypeVital ?? "false"),
    );
    return vitalHelper.getColor();
  } else {
    var vitalHelper = VitalColorHelper(
      vitalName: vitalName,
      vitalStatus: value,
      isLowGood: stringToBool(healthList.first.isTypeVital ?? "false"),
    );
    return vitalHelper.getColor();
  }

  // for (int i = 0; i < healthList.length; i++) {
  //   if (isNumeric(value)) {
  //     final double? target = double.tryParse(value);
  //     final double? itemValue = double.tryParse(healthList[i].value ?? "");
  //     if (target == null) return Colors.black;
  //     debugPrint("getStatusAndIsTypical $target ${healthList[i].value}");

  //     if (itemValue != null && target == itemValue) {
  //       var vitalHelper = VitalColorHelper(
  //         vitalName: vitalName,
  //         vitalStatus: healthList[i].status ?? "",
  //         isLowGood: stringToBool(healthList[i].isTypeVital ?? "false"),
  //       );
  //       return vitalHelper.getColor(); // loop stops here
  //     }
  //   } else {
  //     debugPrint("getStatusAndIsTypical $value ${healthList[i].value}");
  //     if (value != null &&
  //         value.isCaseInsensitiveContainsAny(healthList[i].value!)) {
  //       var vitalHelper = VitalColorHelper(
  //         vitalName: vitalName,
  //         vitalStatus: healthList[i].value ?? "",
  //         isLowGood: stringToBool(healthList[i].isTypeVital ?? "false"),
  //       );
  //       return vitalHelper.getColor(); // loop stops here
  //     }
  //   }
  // }

  // return Colors.black; // default if not matched
}

bool stringToBool(String value) {
  return value.toLowerCase() == 'true';
}

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}
