import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/utils/enum/vital.dart';
import 'package:ntt_data/core/utils/extensions/vital_extension.dart';

class BinahVitalHelper {
  bool isBreathing = false;
  bool isBlood = false;
  bool isHighLow = false;
  bool isStress = false;
  bool isWellnessScore = false;
  bool isLowGood = false;
  String vitalValue = '';
  final bool isSdkType;
  final String vitalName;
  String vitalStatus;

  late final VitalType vitalType;
  late final VitalStatusType vitalStatusType;

  BinahVitalHelper({
    required this.isSdkType,
    required this.vitalName,
    required this.vitalStatus,
    required this.isLowGood,
    required this.vitalValue,
  }) {
    vitalType = vitalName.toVitalType();
    vitalStatusType = vitalStatus.toVitalStatusType();
    _initializeFlags();
  }

  void _initializeFlags() {
    if (isSdkType && isLowGood) {
      if (_isBreathingVital()) {
        isBreathing = true;
      } else if (vitalType == VitalType.bloodPressure) {
        isBlood = true;
      } else if (_isHighLowRiskVital()) {
        isHighLow = true;
      } else if (_isStressVital()) {
        isStress = true;
      } else if (vitalType == VitalType.wellnessScore) {
        isWellnessScore = true;
      } else if (_shouldMakeLowGoodFalseForSpecialCases()) {
        isLowGood = false;
      } else if (_shouldMakeStressTrueForSdNormal()) {
        isStress = true;
      }

      if (_shouldMakeLowGoodFalseForLowMetrics()) {
        isLowGood = false;
      }
    }
  }

  bool _isBreathingVital() {
    return {
      VitalType.breathingRate,
      VitalType.heartRate,
      VitalType.prq,
      VitalType.hemoglobin,
    }.contains(vitalType);
  }

  bool _isHighLowRiskVital() {
    return {
      VitalType.highBloodPressureRisk,
      VitalType.highHbA1cRisk,
      VitalType.highFastingGlucoseRisk,
      VitalType.highTotalCholesterolRisk,
      VitalType.lowHemoglobinRisk,
      VitalType.stressResponseSnsZone,
    }.contains(vitalType);
  }

  bool _isStressVital() {
    return {
      VitalType.stressLevel,
      VitalType.baevskyStressIndex,
      VitalType.normalizedStressIndex,
    }.contains(vitalType);
  }

  bool _shouldMakeLowGoodFalseForSpecialCases() {
    return (vitalType == VitalType.pnsIndex &&
            vitalStatusType == VitalStatusType.low) ||
        (vitalType == VitalType.recoveryAbilityPnsZone &&
            vitalStatusType == VitalStatusType.low) ||
        (vitalType == VitalType.lfHf &&
            vitalStatusType == VitalStatusType.low) ||
        (vitalType == VitalType.ascvdRisk &&
            vitalStatusType == VitalStatusType.high) ||
        (vitalType == VitalType.snsIndex &&
            vitalStatusType == VitalStatusType.high) ||
        (vitalType == VitalType.sd1 &&
            vitalStatusType == VitalStatusType.low) ||
        (vitalType == VitalType.sd2 && vitalStatusType == VitalStatusType.high);
  }

  bool _shouldMakeStressTrueForSdNormal() {
    return (vitalType == VitalType.sd1 &&
            vitalStatusType == VitalStatusType.normal) ||
        (vitalType == VitalType.sd2 &&
            vitalStatusType == VitalStatusType.normal);
  }

  bool _shouldMakeLowGoodFalseForLowMetrics() {
    return (vitalType == VitalType.meanRri &&
            vitalStatusType == VitalStatusType.low) ||
        (vitalType == VitalType.rmssd &&
            vitalStatusType == VitalStatusType.low);
  }

  String getImageResource(String vitalStatus) {
    final status = vitalStatus.toVitalStatusType();

    switch (status) {
      case VitalStatusType.low:
        return isBreathing
            ? AppAssets.mediumImage
            : isWellnessScore
            ? AppAssets.veryLowImage
            : isBlood
            ? AppAssets.mediumImage
            : isLowGood
            ? AppAssets.veryHighImage
            : AppAssets.veryLowImage;

      case VitalStatusType.normal:
        return isBreathing
            ? AppAssets.veryHighImage
            : isStress
            ? AppAssets.highImage
            : isBlood
            ? AppAssets.veryHighImage
            : isLowGood
            ? AppAssets.mediumImage
            : AppAssets.veryHighImage;

      case VitalStatusType.medium:
      case VitalStatusType.mild:
        return AppAssets.mediumImage;

      case VitalStatusType.high:
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

      case VitalStatusType.veryHigh:
        return AppAssets.veryLowImage;

      case VitalStatusType.prediabetesRisk:
      case VitalStatusType.prediabetes:
        return AppAssets.mediumImage;

      case VitalStatusType.diabetesRisk:
      case VitalStatusType.diabetes:
      case VitalStatusType.extreme:
        return AppAssets.veryLowImage;

      case VitalStatusType.optimal:
      case VitalStatusType.veryLow:
      case VitalStatusType.unknown:
        return AppAssets.veryHighImage;
    }
  }

  Color getColor() {
    switch (vitalStatusType) {
      case VitalStatusType.low:
        return isBreathing
            ? AppColors.warning
            : isWellnessScore
            ? AppColors.danger
            : isBlood
            ? AppColors.warning
            : isLowGood
            ? AppColors.success
            : AppColors.danger;

      case VitalStatusType.normal:
        return isBreathing
            ? AppColors.success
            : isBlood
            ? AppColors.success
            : isLowGood
            ? AppColors.warning
            : AppColors.success;

      case VitalStatusType.medium:
      case VitalStatusType.mild:
        return AppColors.warning;

      case VitalStatusType.high:
        return isBreathing
            ? AppColors.warning
            : isBlood
            ? AppColors.danger
            : isLowGood
            ? AppColors.success
            : AppColors.danger;

      case VitalStatusType.veryHigh:
        return isLowGood ? AppColors.danger : AppColors.success;

      case VitalStatusType.prediabetesRisk:
      case VitalStatusType.prediabetes:
        return AppColors.warning;

      case VitalStatusType.diabetesRisk:
      case VitalStatusType.diabetes:
        return AppColors.danger;

      case VitalStatusType.extreme:
      case VitalStatusType.optimal:
      case VitalStatusType.veryLow:
      case VitalStatusType.unknown:
        return AppColors.white;
    }
  }

  String getStatus() {
    if (!isNumeric(vitalValue, vitalName)) {
      return '';
    }

    switch (vitalStatusType) {
      case VitalStatusType.diabetes:
        return AppStrings.diabetesRisk;

      case VitalStatusType.prediabetes:
        return AppStrings.prediabetesRisk;

      case VitalStatusType.low:
      case VitalStatusType.normal:
      case VitalStatusType.medium:
      case VitalStatusType.high:
      case VitalStatusType.veryHigh:
      case VitalStatusType.optimal:
      case VitalStatusType.prediabetesRisk:
      case VitalStatusType.diabetesRisk:
        return vitalStatus;

      default:
        return '';
    }
  }
}

bool isNumeric(String value, String name) {
  if (name.toVitalType() == VitalType.bloodPressure) {
    final bpParts = value.split('/');
    if (bpParts.isEmpty) return false;
    return int.tryParse(bpParts[0].trim()) != null;
  } else {
    return double.tryParse(value.trim()) != null;
  }
}
