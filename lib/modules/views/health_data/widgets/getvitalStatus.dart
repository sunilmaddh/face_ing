import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

final _measurementController = Get.find<MeasurementController>();

class Getvitalstatus {
  String getVitalValue(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    print(value);
    if (value == null) return "";
    if (value is num) {
      final parts = value.toString().split('.');
      if (parts.length == 2) {
        return value.toString();
      }
    }
    if (value is double && value % 1 != 0) return value.toStringAsFixed(2);
    if (value is int) return value.toStringAsFixed(1);
    return value.toString();
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
    debugPrint("Systolic value $value");
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String getOxygenSaturation(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    debugPrint("Systolic value $value");
    if (value == null) return '';
    if (value < min) return 'low';
    if (value >= max) return 'normal';
    return 'normal';
  }

  String getHemoglobin(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType);
    final value = double.tryParse(rawValue.toString());
    debugPrint("Systolic value $value");
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
}
