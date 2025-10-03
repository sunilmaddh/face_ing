import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';

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

  String getBpDiatolic(v) {
    // final value = double.tryParse(vitalType.toString());
    // debugPrint("Systolic value $value");
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 60) return 'low';
    if (value < 70) return 'normal';
    if (value < 80) return 'medium';
    if (value <= 90) return 'high';
    if (value > 90) return 'very high';
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
    if (value == null) return '';
    if (value < 14) return 'low';
    if (value > 18) return 'high';
    return 'normal';
  }

  String getHemoglobinA1C(v) {
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value >= 5.6) return 'prediabetes risk';
    if (value > 6.4) return 'diabetes risk ';
    return 'normal';
  }

  String getASCVDRisk(v) {
    final value = double.tryParse(v);
    if (value == null) return '';
    if (value < 1) return 'low';
    if (value > 30) return 'high';
    return 'normal';
  }

  String getHRVDNVitalStatus(String v) {
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
    debugPrint(v);
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
        return getBpDiatolic(v);
      case "Oxygen Saturation":
        return getOxygenSaturation(v);
      case "Hemoglobin":
        return getHemoglobin(v);
      case "Hemoglobin A1C":
        return getHemoglobinA1C(v);
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

  final Map<String, List<GaugeCondition>> vitalConditions = {
    "Wellness Score": [
      GaugeCondition(min: 1, max: 4, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 4.1,
        max: 7,
        label: "Medium",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 7.1,
        max: 10,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
    "Breathing Rate": [
      GaugeCondition(min: 0, max: 11, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 12,
        max: 20,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 21,
        max: 30,
        label: "High (Bad)",
        color: Color(0xffEEC000),
      ),
    ],
    "Heart Rate": [
      GaugeCondition(min: 0, max: 59, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 60,
        max: 100,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 101,
        max: 160,
        label: "High",
        color: Color(0xffEEC000),
      ),
    ],
    "PRQ": [
      GaugeCondition(min: 0, max: 3.9, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(min: 4, max: 5, label: "Normal", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 5.1,
        max: 10,
        label: "High",
        color: Color(0xffEEC000),
      ),
    ],
    "Blood Pressure Systolic": [
      GaugeCondition(min: 0, max: 99, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 100,
        max: 129,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 130,
        max: 140,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "Blood Pressure Daistolic": [
      GaugeCondition(min: 0, max: 59, label: "Low", color: Color(0xffED9A33)),
      GaugeCondition(
        min: 60,
        max: 70,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 71,
        max: 80,
        label: "Medium",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(min: 81, max: 90, label: "High", color: Color(0xffED9A33)),
      GaugeCondition(
        min: 91,
        max: 120,
        label: "Very High",
        color: Color(0xffFA704E),
      ),
    ],
    "Oxygen Saturation": [
      GaugeCondition(min: 0, max: 94, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 95,
        max: 120,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
    ],
    "Hemoglobin": [
      GaugeCondition(min: 0, max: 13.9, label: "Low", color: Color(0xffEEC000)),
      GaugeCondition(
        min: 14,
        max: 18,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 18.1,
        max: 30,
        label: "High",
        color: Color(0xffEEC000),
      ),
    ],
    "Hemoglobin A1C": [
      GaugeCondition(
        min: 0,
        max: 5.5,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: 5.6,
        max: 6.5,
        label: "Prediabetes risk",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 6.6,
        max: 13,
        label: "Diabetes risk",
        color: Color(0xffFA704E),
      ),
    ],
    "ASCVD Risk": [
      GaugeCondition(min: 0, max: 0.9, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 1,
        max: 30,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 31,
        max: 100,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "HRV SDNN": [
      GaugeCondition(min: 0, max: 49, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 50,
        max: 100,
        label: "Normal",
        color: Color(0xff1BC76D),
      ),
    ],
    "PNS Index": [
      GaugeCondition(
        min: -10,
        max: -1.1,
        label: "Low",
        color: Color(0xffFA704E),
      ),
      GaugeCondition(
        min: -1,
        max: 1,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(min: 1, label: "High", color: Color(0xff1BC76D)),
    ],
    "SNS Index": [
      GaugeCondition(
        min: -10,
        max: -1.1,
        label: "Low",
        color: Color(0xff1BC76D),
      ),
      GaugeCondition(
        min: -1,
        max: 1,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(min: 1, max: 10, label: "High", color: Color(0xffFA704E)),
    ],
    "SD1": [
      GaugeCondition(
        min: 2.5,
        max: 15.1,
        label: "Low",
        color: Color(0xffFA704E),
      ),
      GaugeCondition(
        min: 16,
        max: 48,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 48.1,
        max: 230,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
    "SD2": [
      GaugeCondition(min: 9, max: 51.9, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 52,
        max: 84,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 84.1,
        max: 245,
        label: "High",
        color: Color(0xffFA704E),
      ),
    ],
    "Baevsky Stress Index": [
      GaugeCondition(min: 0, max: 80, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 81,
        max: 150,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 151,
        max: 300,
        label: "Mild",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 301,
        max: 600,
        label: "High",
        color: Color(0xffED9A33),
      ),
      GaugeCondition(
        min: 601,
        max: 1000,
        label: "Very High",
        color: Color(0xffFA704E),
      ),
    ],
    "Normalized Stress Index": [
      GaugeCondition(min: 0, max: 28, label: "Low", color: Color(0xff1BC76D)),
      GaugeCondition(
        min: 29,
        max: 40,
        label: "Normal",
        color: Color(0xff9ED042),
      ),
      GaugeCondition(min: 39, max: 67, label: "Mild", color: Color(0xffEEC000)),
      GaugeCondition(min: 68, max: 97, label: "High", color: Color(0xffED9A33)),
      GaugeCondition(
        min: 98,
        max: 100,
        label: "Very High",
        color: Color(0xffFA704E),
      ),
    ],
    "Mean RRi": [
      GaugeCondition(min: 50, max: 600, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 601,
        max: 1000,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 1001,
        max: 2000,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
    "RMSSD": [
      GaugeCondition(min: 0, max: 24, label: "Low", color: Color(0xffFA704E)),
      GaugeCondition(
        min: 25,
        max: 43,
        label: "Normal",
        color: Color(0xffEEC000),
      ),
      GaugeCondition(
        min: 44,
        max: 100,
        label: "High",
        color: Color(0xff1BC76D),
      ),
    ],
  };

  final Map<String, List<StatusListColor>> statusListWithColor = {
    "Wellness Score": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "Breathing Rate": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Heart Rate": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "PRQ": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Blood Pressure Systolic": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Blood Pressure Daistolic": [
      StatusListColor(status: "Low", color: Color(0xffED9A33)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Oxygen Saturation": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
    ],
    "Hemoglobin": [
      StatusListColor(status: "Low", color: Color(0xffEEC000)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffEEC000)),
    ],
    "Hemoglobin A1C": [
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
      StatusListColor(status: "Prediabetes risk", color: Color(0xffEEC000)),
      StatusListColor(status: "Diabetes risk", color: Color(0xffFA704E)),
    ],
    "ASCVD Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Blood Pressure Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High HbA1c Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Fasting Glucose Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "High Total Cholesterol Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Low Hemoglobin Risk": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Stress Level": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Recovery Ability (PNS Zone)": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "Stress Response (SNS Zone)": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Medium", color: Color(0xffEEC000)),

      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "Normalized Stress Index ": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Baesky Stress Index ": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xff9ED042)),
      StatusListColor(status: "Mild", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffED9A33)),
      StatusListColor(status: "Very High", color: Color(0xffFA704E)),
    ],
    "Mean RRi": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "RMSSD": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "HRV SDNN": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xff1BC76D)),
    ],
    "PNS Index": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "SNS Index": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
    "SD1": [
      StatusListColor(status: "Low", color: Color(0xffFA704E)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xff1BC76D)),
    ],
    "SD2": [
      StatusListColor(status: "Low", color: Color(0xff1BC76D)),
      StatusListColor(status: "Normal", color: Color(0xffEEC000)),
      StatusListColor(status: "High", color: Color(0xffFA704E)),
    ],
  };

  final Map<String, List<GaugeCategory>> categoricalVitals = {
    "High HbA1c Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "High Fasting Glucose Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "High Total Cholesterol Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Low Hemoglobin Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Normal", color: Color(0xff9ED042)),
      GaugeCategory(status: "Mild", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Stress Level": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Normal", color: Color(0xff9ED042)),
      GaugeCategory(status: "Mild", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffED9A33)),
      GaugeCategory(status: "Very High", color: Color(0xffFA704E)),
    ],
    "High Blood Pressure Risk": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
    "Recovery Ability (PNS Zone)": [
      GaugeCategory(status: "Low", color: Color(0xffFA704E)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xff1BC76D)),
    ],
    "Stress Response (SNS Zone)": [
      GaugeCategory(status: "Low", color: Color(0xff1BC76D)),
      GaugeCategory(status: "Medium", color: Color(0xffEEC000)),
      GaugeCategory(status: "High", color: Color(0xffFA704E)),
    ],
  };
}

class GaugeCategory {
  final String status; // e.g., "Low", "Medium", "High"
  final Color color;

  GaugeCategory({required this.status, required this.color});
}

class StatusListColor {
  final String status;
  final Color color;
  StatusListColor({required this.status, required this.color});
}

class GaugeCondition {
  final double? min;
  final double? max;
  final String label;
  final Color color;

  GaugeCondition({
    this.min,
    this.max,
    required this.label,
    required this.color,
  });
}
