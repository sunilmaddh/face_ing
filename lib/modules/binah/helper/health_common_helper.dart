import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/binah/widgets/getvitalStatus.dart';

class HealthCommonHelper {
  final _measurementController = Get.find<MeasurementController>();
  final _geustController = Get.find<GeustController>();

  double homoGlobinMin() {
    bool isMale = false;
    double hemoglobinMin = 0.0;

    if (_geustController.selectionType.isNotEmpty) {
      isMale = _geustController.selectionType.value == "Male";
    } else {
      isMale = _measurementController.genderType.toLowerCase() == 'male';
    }
    return hemoglobinMin = isMale ? 14.0 : 12.0;
  }

  double homoGlobinMax() {
    bool isMale = false;
    double hemoglobinMax = 0.0;
    if (_geustController.selectionType.isNotEmpty) {
      isMale = _geustController.selectionType.value == "Male";
    } else {
      isMale = _measurementController.genderType.toLowerCase() == 'male';
    }

    return hemoglobinMax = isMale ? 18.0 : 16.0;
  }
}

final statusHelper = Getvitalstatus();

class HomoGlobinA1C {
  final String a1cValueStr;
  final double? a1cValue;

  HomoGlobinA1C()
    : a1cValueStr = statusHelper.getVitalValue(VitalSignTypes.hemoglobinA1C),
      a1cValue = double.tryParse(
        statusHelper.getVitalValue(VitalSignTypes.hemoglobinA1C),
      );

  String get a1cStatus {
    if (a1cValue == null) return 'low';
    if (a1cValue! <= 5.6) return 'low';
    if (a1cValue! < 5.7) return 'low';
    if (a1cValue! <= 6.4) return 'medium';
    return 'high';
  }

  String get a1cConditionText {
    if (a1cValue == null) return '';
    if (a1cValue! <= 5.6) return 'Normal';
    if (a1cValue! < 5.7) return 'Normal';
    if (a1cValue! <= 6.4) return 'Prediabetes risk';
    return 'Diabetes risk';
  }
}

class WellnessMetricDescriptions {
  static const wellnessScore = "Wellness Score";
  // ignore: constant_identifier_names
  static const BreathingRate = "Breathing Rate";
  static const bloodPressureDiastolic = "Blood Pressure";
  static const pulseRate = "Pulse Rate";
  static const prq = "PRQ";
  static const oxygenSaturation = "Oxygen Saturation";
  static const hemoglobin = "Hemoglobin";
  static const hemoglobinA1C = "Hemoglobin A1C";
  static const highBloodPressureRisk = "High Blood Pressure Risk";
  static const highHbA1cRisk = "High HbA1c Risk";
  static const highFastingGlucoseRisk = "High Fasting Glucose Risk";
  static const highTotalCholesterolRisk = "High Total Cholesterol Risk";
  static const lowHemoglobinRisk = "Low Hemoglobin Risk";
  static const ascvdRisk = "ASCVD Risk";
  static const heartAge = "Heart Age";
  static const stressIndex = "Stress Index";
  static const stressLevel = "Stress Level";
  static const hrvSdnn = "HRV SDNN";
  static const meanRRi = "Mean RRi";
  static const rmssd = "RMSSD";
  static const recoveryAbility = "Recovery Ability";
  static const pnsIndex = "PNS Index";
  static const snsIndex = "SNS Index";
  static const snsZone = "SNS Zone";
  static const sd1 = "SD1";
  static const sd2 = "SD2";
  static const lfhf = "LF/HF";
  // ignore: constant_identifier_names
  static const RRiData = "RRi Data ";
}

class WellnessMetricDescriptionsLong {
  static const breathRate =
      "The breathing rate is the number of breaths you take per minute (rpm).";

  static const wellnessScore =
      "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years.";

  // ignore: constant_identifier_names
  static const RRiData = "The number of breaths you take per minute.";

  static const pulseRate = "The number of times your heart beats per minute.";

  static const prq =
      "The Pulse-Respiration Quotient (PRQ) is a measure of the ratio of a person’s pulse rate (measured in beats per minute) to their respiratory rate (measured in breaths per minute).";

  static const bpSystolic =
      "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.";

  static const bpDiastolic =
      "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.";

  static const oxygenSaturation =
      "Oxygen Saturation, or SpO2, is a measure of how much oxygen the red blood cells are carrying from the lungs to the rest of the body.";

  static const hemoglobin =
      "Hemoglobin is a protein in a person’s red blood cells that carries oxygen to the human body's organs and tissues and transports carbon dioxide from your organs and tissues back to your lungs.";

  static const hemoglobinA1C =
      "Hemoglobin A1C (or HbA1c) represents the average blood glucose (sugar) level for the last two to three months.";

  static const ascvdRisk =
      "ASCVD (Atherosclerotic Cardiovascular Disease) Risk estimates the likelihood of experiencing an atherosclerotic cardiovascular event within 10 years.";

  static const heartAge =
      "The Framingham Heart Age estimates the biological age of the heart based on cardiovascular health.";

  static const highBloodPressureRisk =
      "The High Blood Pressure Risk result indicates whether your blood pressure exceeds preset systolic/diastolic values.";

  static const highHbA1cRisk =
      "The High Hemoglobin A1c Risk (HbA1c) result indicates whether your Hemoglobin A1c level exceeds a preset threshold.";

  static const highFastingGlucoseRisk =
      "The High Fasting Glucose Risk result indicates whether your glucose level exceeds a preset threshold after at least 8 hours of fasting.";

  static const highTotalCholesterolRisk =
      "The High Total Cholesterol Risk result indicates whether your total cholesterol level exceeds a preset threshold.";

  static const lowHemoglobinRisk =
      "The Low Hemoglobin Risk result indicates whether your hemoglobin level is below a preset threshold.";

  static const stressLevel = "The body's reaction to a challenge or demand.";

  static const stressIndex =
      "Stress is the body's reaction to a challenge or demand.";

  static const normalizedStressIndex =
      "The Normalized Stress Level is calculated from the Stress Index and scaled to a range of 0 to 100.";

  static const hrvSDNN =
      "SDNN is a calculated parameter of Heart Rate Variability (HRV) that represents the standard deviation of normal-to-normal R-R-intervals.";

  static const meanRRi =
      "Mean RRi is the average time between the RR intervals (RRi) in milliseconds.";

  static const rmssd =
      "An important measure of the Heart Rate Variability. RMSSD is the root mean square of successive RR interval differences.";

  static const recoveryAbility =
      "The Recovery Ability that is also known as “rest and digest'' response refers to the body’s ability to recover, accumulate energy, and regulate bodily functions after stressful occurrences.";

  static const pnsIndex =
      "The PNS Index calculation is based on the following three parameters: Mean RRi, RMSSD, and SD1, and is used to indicate the body’s Recovery Ability zones.";

  static const snsIndex =
      "The SNS index is calculated based on the following three parameters: Heart Rate, Baevsky’s stress index, SD2, and is used to set the stress response zone.";
  static const snsZone =
      "The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.";

  static const stressResponse =
      "The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.";

  static const sd1 =
      "SD1 is a poincaré plot standard deviation perpendicular to the line of identity.";

  static const sd2 =
      "SD2 is a poincaré plot standard deviation along the line of identity.";
  // ignore: constant_identifier_names
  static const LfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";
  static const lfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";

  static const rriData =
      "The RR interval is the time between the \"R\" peaks of successive heartbeats, in milliseconds.";
}
