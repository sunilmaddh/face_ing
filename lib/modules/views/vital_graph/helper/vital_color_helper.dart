import 'package:flutter/material.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_graph_status.dart';
// Replace with your actual asset paths

class VitalColorHelper {
  bool isBreathing = false;
  bool isBlood = false;
  bool isDBlood = false;
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
      } else if (vitalName == "Blood Pressure Systolic") {
        isBlood = true;
      } else if (vitalName == "Blood Pressure Daistolic") {
        isDBlood = true;
      } else if (_isHighLowRiskVital()) {
        isHighLow = true;
      } else if (vitalName == "Stress Level") {
        isStress = true;
      } else if (vitalName == "Normalized Stress Index") {
        isStress = true;
      } else if (vitalName == "Wellness Score") {
        isWellnessScore = true;
      } else if (vitalName == "Wellness Score") {
        isWellnessScore = true;
      } else if (vitalName == "SD2" && vitalStatus.toLowerCase() == "high" ||
          vitalName == "SD1" && vitalStatus.toLowerCase() == "low") {
        isLowGood = false;
      } else if ((vitalName == "PNS Index" &&
              vitalStatus.toLowerCase() == "low") ||
          (vitalName == "Recovery Ability (PNS Zone)" &&
              vitalStatus.toLowerCase() == "low") ||
          (vitalName == "LF/HF" && vitalStatus.toLowerCase() == "low") ||
          (vitalName == "ASCVD Risk" && vitalStatus.toLowerCase() == "high") ||
          (vitalName == "SNS Index" && vitalStatus.toLowerCase() == "high")) {
        isLowGood = false;
      }
      if ((vitalName == "Mean RRi" && vitalStatus.toLowerCase() == "low") ||
          (vitalName == "RMSSD" && vitalStatus.toLowerCase() == "low")) {
        isLowGood = false;
      }
    }
  }

  bool _isBreathingVital() {
    return [
      "Breathing Rate",
      "Heart Rate",
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
            : isDBlood
            ? const Color(0xffED9A33)
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
            : isDBlood
            ? const Color(0xffED9A33)
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
  if (AppMethods.isNumeric(value)) {
    String? isTypeVital;
    var status = VitalGraphStatus().getStatus(vitalName, value);
    for (var data in healthList) {
      if (data.isTypeVital == "true") {
        isTypeVital = data.isTypeVital;
      }
    }
    var vitalHelper = VitalColorHelper(
      vitalName: vitalName,
      vitalStatus: status,
      isLowGood: AppMethods.stringToBool(isTypeVital ?? "false"),
    );
    return vitalHelper.getColor();
  } else {
    var vitalHelper = VitalColorHelper(
      vitalName: vitalName,
      vitalStatus: value,
      isLowGood: AppMethods.stringToBool(
        healthList.first.isTypeVital ?? "false",
      ),
    );
    return vitalHelper.getColor();
  }
}
