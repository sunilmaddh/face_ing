import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

final _measurementController = Get.find<MeasurementController>();

class VitalGraphStatus {
  String getVitalValue(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "";
    if (value is double) return value.toStringAsFixed(1);
    if (value is int) return value.toString();
    return value.toString();
  }

  String getVitalStringStatus(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    return result!.value.toString().toLowerCase();
  }

  String getWellnessStatus(String v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 5) return 'low';
    if (value > 7) return 'high';
    return 'medium';
  }

  String getBreathingRate(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 12) return 'low';
    if (value > 20) return 'high';
    return 'normal';
  }

  String getPulseRate(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 60) return 'low';
    if (value > 100) return 'high';
    return 'normal';
  }

  String getPrq(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 4) return 'low';
    if (value > 5) return 'high';
    return 'normal';
  }

  String getBpSystolic(v) {
    // final value = double.tryParse(vitalType.toString());
    // debugPrint("Systolic value $value");
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 100) return 'low';
    if (value > 129) return 'high';
    return 'normal';
  }

  String getOxygenSaturation(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    debugPrint("Systolic value $value");
    if (value == null) return '';
    if (value < 94) return 'low';
    if (value >= 95) return 'normal';
    return 'normal';
  }

  String getHemoglobin(v) {
    // final rawValue = getVitalValue(vitalType);
    // final value = double.tryParse(rawValue.toString());
    final value = double.tryParse(v);
    debugPrint("Systolic value $value");
    if (value == null) return '';
    if (value < 5.7) return 'low';
    if (value > 6.4) return 'high';
    return 'normal';
  }

  String getASCVDRisk(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 1) return 'low';
    if (value > 30) return 'high';
    return 'normal';
  }

  String getHRVDNVitalStatus(String v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 50) return 'low';
    if (value > 100) return 'high';
    return 'normal';
  }

  String getMeanRriVitalStatus(String v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 600) return 'low';
    if (value > 1000) return 'high';
    return 'normal';
  }

  String getRMSDVitalStatus(String v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 25) return 'low';
    if (value > 43) return 'high';
    return 'normal';
  }

  String getPnsZone(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < -1) return 'low';
    if (value > 1) return 'high';
    return 'normal';
  }

  String getPnsIndex(v) {
    // final rawValue = getVitalValue(vitalType ?? 0);
    // final value = double.tryParse(rawValue);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < -1) return 'low';
    if (value > 1) return 'high';
    return 'normal';
  }

  String getVitalStressIndexStatus(v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value <= 80) return 'low';
    if (value <= 150) return "normal";
    if (value <= 300) return "mild";
    if (value <= 600) return "high";
    if (value >= 601) return "very High";
    return 'medium';
  }

  String getVitalNormilizedStressIndexStatus(v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);

    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value <= 29) return 'low';
    if (value <= 40) return "normal";
    if (value <= 67) return "mild";
    if (value <= 97) return "high";
    if (value > 97) return "very High";
    return 'medium';
  }

  String getVitSD1Status(v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 16) return 'low';
    if (value <= 48) return "normal";
    // if (value <= 600) return "high";
    return 'high';
  }

  String getVitSD2Status(v) {
    // final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 52) return 'low';
    if (value <= 84) return "normal";
    // if (value <= 600) return "high";
    return 'high';
  }

  String getStatus(String vitalName, String v) {
    switch (vitalName) {
      case "Wellness Score":
        return getWellnessStatus(v);
      case "Breathing Rate":
        return getBreathingRate(v);
      case "Heart Rate":
        return getPulseRate(v);
      case "PRQ":
        return getPrq(v);
      case "Blood Pressure Systolic":
        return getBpSystolic(v);
      case "Blood Pressure Daistolic":
        return getBpSystolic(v);
      case "Oxygen Saturation":
        return getOxygenSaturation(v);
      case "Hemoglobin":
        return getHemoglobin(v);
      case "Hemoglobin A1C":
        return getHemoglobin(v);
      case "ASCVD Risk":
        return getASCVDRisk(v);
      case "Normalized Stress Index":
        return getVitalNormilizedStressIndexStatus(v);
      case "Baesky Stress Index":
        return getVitalStressIndexStatus(v);
      case "Mean RRi":
        return getMeanRriVitalStatus(v);
      case "RMSSD":
        return getRMSDVitalStatus(v);
      case "HRV SDNN":
        return getHRVDNVitalStatus(v);
      case "PNS Index":
        return getPnsIndex(v);
      case "SNS Index":
        return getPnsIndex(v);
      case "SD1":
        return getVitSD1Status(v);
      case "SD2":
        return getVitSD2Status(v);
      default:
        return "";
    }
  }
}
