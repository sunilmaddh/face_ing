import 'package:ntt_data/core/utils/enum/vital.dart';

extension VitalTypeExtension on String {
  VitalType toVitalType() {
    switch (trim().toLowerCase()) {
      case 'breathing rate':
        return VitalType.breathingRate;
      case 'heart rate':
        return VitalType.heartRate;
      case 'prq':
        return VitalType.prq;
      case 'hemoglobin':
        return VitalType.hemoglobin;
      case 'blood pressure':
        return VitalType.bloodPressure;
      case 'high blood pressure risk':
        return VitalType.highBloodPressureRisk;
      case 'high hba1c risk':
        return VitalType.highHbA1cRisk;
      case 'high fasting glucose risk':
        return VitalType.highFastingGlucoseRisk;
      case 'high total cholesterol risk':
        return VitalType.highTotalCholesterolRisk;
      case 'low hemoglobin risk':
        return VitalType.lowHemoglobinRisk;
      case 'stress response (sns zone)':
        return VitalType.stressResponseSnsZone;
      case 'stress level':
        return VitalType.stressLevel;
      case 'baevsky stress index':
        return VitalType.baevskyStressIndex;
      case 'normalized stress index':
        return VitalType.normalizedStressIndex;
      case 'wellness score':
        return VitalType.wellnessScore;
      case 'pns index':
        return VitalType.pnsIndex;
      case 'recovery ability (pns zone)':
        return VitalType.recoveryAbilityPnsZone;
      case 'lf/hf':
        return VitalType.lfHf;
      case 'ascvd risk':
        return VitalType.ascvdRisk;
      case 'sns index':
        return VitalType.snsIndex;
      case 'sd1':
        return VitalType.sd1;
      case 'sd2':
        return VitalType.sd2;
      case 'mean rri':
        return VitalType.meanRri;
      case 'rmssd':
        return VitalType.rmssd;
      default:
        return VitalType.unknown;
    }
  }
}

extension VitalStatusTypeExtension on String {
  VitalStatusType toVitalStatusType() {
    switch (trim().toLowerCase()) {
      case 'low':
        return VitalStatusType.low;
      case 'normal':
        return VitalStatusType.normal;
      case 'medium':
        return VitalStatusType.medium;
      case 'mild':
        return VitalStatusType.mild;
      case 'high':
        return VitalStatusType.high;
      case 'very high':
        return VitalStatusType.veryHigh;
      case 'prediabetes risk':
        return VitalStatusType.prediabetesRisk;
      case 'prediabetes':
        return VitalStatusType.prediabetes;
      case 'diabetes risk':
        return VitalStatusType.diabetesRisk;
      case 'diabetes':
        return VitalStatusType.diabetes;
      case 'extreme':
        return VitalStatusType.extreme;
      case 'optimal':
        return VitalStatusType.optimal;
      case 'very low':
        return VitalStatusType.veryLow;
      default:
        return VitalStatusType.unknown;
    }
  }
}
