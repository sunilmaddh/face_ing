import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
// Replace with your actual asset paths

class BinahVitalHelper {
  bool isBreathing = false;
  bool isBlood = false;
  bool isHighLow = false;
  bool isStress = false;
  bool isWellnessScore = false;
  bool isLowGood = false;
  String vitalValue = "";
  final bool isSdkType;
  final String vitalName;
  String vitalStatus;

  BinahVitalHelper({
    required this.isSdkType,
    required this.vitalName,
    required this.vitalStatus,
    required this.isLowGood,
    required this.vitalValue,
  }) {
    _initializeFlags();
  }

  void _initializeFlags() {
    if (isSdkType && isLowGood) {
      if (_isBreathingVital()) {
        isBreathing = true;
      } else if (vitalName == "Blood Pressure") {
        isBlood = true;
      } else if (_isHighLowRiskVital()) {
        isHighLow = true;
      } else if (vitalName == "Stress Level") {
        isStress = true;
      } else if (vitalName == "Wellness Score") {
        isWellnessScore = true;
      } else if ((vitalName == "PNS Index" && vitalStatus == "Low") ||
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

  /// Returns image asset based on vitalStatus and internal flags
  String getImageResource(String vitalStatus) {
    switch (vitalStatus.toLowerCase()) {
      case 'low':
        return isBreathing
            ? AppAssets.mediumImage
            : isWellnessScore
            ? AppAssets.veryLowImage
            : isBlood
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.veryHighImage
            : AppAssets.veryLowImage;

      case 'normal':
        return isBreathing
            ? AppAssets.veryHighImage
            : isStress
            ? AppAssets.highImage
            : isBlood
            ? AppAssets.veryHighImage
            : isLowGood
            ? AppAssets.mediumAsset
            : AppAssets.veryHighImage;

      case 'medium':
      case 'mild':
        return AppAssets.mediumImage;

      case 'high':
        return isBreathing
            ? AppAssets.mediumImage
            : isStress
            ? AppAssets.lowImage
            : isBlood
            ? AppAssets.veryLowImage
            : isHighLow
            ? AppAssets.veryLowImage
            : isLowGood
            ? AppAssets.veryHighImage
            : AppAssets.veryLowImage;

      case 'very high':
        return AppAssets.veryLowImage;

      case 'prediabetes risk':
      case 'prediabetes':
        return AppAssets.mediumImage;

      case 'diabetes risk':
      case 'diabetes':
        return AppAssets.veryLowImage;

      default:
        return AppAssets.veryHighImage;
    }
  }

  /// Returns color based on vitalStatus and internal flags
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
            ? const Color(0xFF1BC76D)
            : isBlood
            ? const Color(0xFF1BC76D)
            : isLowGood
            ? const Color(0xFFEEC000)
            : const Color(0xFF1BC76D);

      case 'medium':
      case 'mild':
        return const Color(0xFFEEC000);

      case 'high':
        return isBreathing
            ? const Color(0xFFEEC000)
            : isBlood
            ? const Color(0xFFFA704E)
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

  String getStatus() {
    if (!isNumeric(vitalValue, vitalName)) {
      vitalStatus = "";
    }
    switch (vitalStatus) {
      case 'Diabetes':
        return 'Diabetes risk';
      case 'Drediabetes':
        return 'Prediabetes risk';
      case 'Very low':
      case 'Low':
      case 'Normal':
      case 'Medium':
      case 'High':
      case 'Optimal':
      case 'Very High':
      case 'Prediabetes risk':
      case 'Diabetes risk':
        return vitalStatus;

      default:
        return '';
    }
  }

  bool isNumeric(String value, String name) {
    if (name == "Blood Pressure") {
      final bpParts = value.split('/') ?? [];
      // final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;
      return int.tryParse(bpParts[0]) != null;
    } else {
      return double.tryParse(value) != null;
    }
  }
}
