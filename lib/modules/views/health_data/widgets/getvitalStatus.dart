// ignore_for_file: file_names

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';

final _measurementController = Get.find<MeasurementController>();

class Getvitalstatus {
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

  String getWellnessStatus(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'medium';
  }

  String getBreathingRate(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getPulseRate(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getPrq(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getBpSystolic(vitalType, num min, num max) {
    final value = double.tryParse(vitalType.toString());

    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getOxygenSaturation(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);

    if (value == null) return '';
    if (value < min) return 'low';
    if (value >= max) return 'normal';
    return 'normal';
  }

  String getHemoglobin(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType);
    final value = double.tryParse(rawValue.toString());

    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getASCVDRisk(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getPnsZone(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getPnsIndex(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getVitalStatusTwo(vitalType) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value <= 29) return 'low';
    if (value <= 40) return "normal";
    if (value <= 67) return "mild";
    if (value <= 97) return "high";
    if (value > 97) return "very High";
    return 'medium';
  }

  String getVitalStressIndexStatus(vitalType) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value <= 80) return 'low';
    if (value <= 150) return "normal";
    if (value <= 300) return "mild";
    if (value <= 600) return "high";
    if (value >= 601) return "very High";
    return 'medium';
  }

  String getVitSDStatus(vitalType, minValue, maxValue) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < minValue) return 'low';
    if (value <= maxValue) return "normal";
    // if (value <= 600) return "high";
    return 'high';
  }

  String getVitalStatus(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getNormalizedStressLevel() {
    final normalizedStressValueStr = getVitalValue(
      VitalSignTypes.normalizedStressIndex,
    );

    // Parse it to double for evaluation
    final normalizedStressValue = double.tryParse(normalizedStressValueStr);
    String stressLevel = '';
    if (normalizedStressValue != null) {
      if (normalizedStressValue < 29) {
        stressLevel = 'Low';
      } else if (normalizedStressValue < 40) {
        stressLevel = 'Normal';
      } else if (normalizedStressValue < 67) {
        stressLevel = 'Mild';
      } else if (normalizedStressValue < 97) {
        stressLevel = 'High';
      } else {
        stressLevel = 'Very High';
      }
    }

    return stressLevel;
  }

  int getSystolic() {
    final bpValue = getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue.split('/');
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;

    return systolic ?? 0;
  }
}
