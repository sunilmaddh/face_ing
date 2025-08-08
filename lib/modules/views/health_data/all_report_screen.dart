import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/enum/health_data_enum.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/health_data/widgets/common_health_asset.dart';
import 'package:ntt_data/modules/views/health_data/widgets/getvitalStatus.dart';
import 'package:ntt_data/widgets/indo_common_card.dart';

class AllReportScreen extends StatefulWidget {
  AllReportScreen({super.key});

  @override
  State<AllReportScreen> createState() => _AllReportScreenState();
}

class _AllReportScreenState extends State<AllReportScreen>
    with SingleTickerProviderStateMixin {
  final _measurementController = Get.find<MeasurementController>();
  final _geustController = Get.find<GeustController>();
  // Dummy implementations, replace with your actual method
  String getVitalValue(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "";
    if (value is num) return value.toStringAsFixed(1);
    return value.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _geustController.addGuest(_measurementController.vitalsResults.value);
  }

  // Helper to build IndoCommonCard with less repetition
  Widget buildCard({
    required String vitalName,
    String? vitalValue,
    String? vitalCondition,
    String? vitalMass,
    required String vitalStatus,
    String? imageAsset,
    required String vitalHeading,
    required String vitalDescription,
    bool isExpand = false,
    bool isVitalActive = true,
    Widget expandedWidget = const SizedBox(),
  }) {
    return IndoCommonCard(
      imageAsset: imageAsset ?? '',
      isVitalActive: isVitalActive,
      vitalName: vitalName,
      vitalValue: vitalValue ?? 'N/A',
      vitalCondition: vitalCondition ?? '',
      vitalMass: vitalMass ?? "",
      vitalStatus: vitalStatus,
      vitalHeading: vitalHeading,
      vitalDescription: vitalDescription,
      isExpand: isExpand,
      expandedWidget: expandedWidget,
    );
  }

  final statusHelper = Getvitalstatus();
  List<Widget> allVitalSigns() {
    final bpValue = statusHelper.getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue?.split('/') ?? [];
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;
    final diastolic = bpParts.length > 1 ? int.tryParse(bpParts[1]) : null;

    return [
      buildCard(
        vitalName: HealthDataEnum.wellnessScore.name,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getWellnessStatus(
          VitalSignTypes.wellnessIndex,
          5,
          7,
        ),
        vitalHeading: HealthDataEnum.wellnessScore.name,
        vitalDescription: HealthDataEnum.wellnessScore.description,
        vitalMass: '',
        imageAsset: CommonHealthAsset().getWellnessAsset(
          statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
        ),
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getBreathingRateAsset(
          statusHelper.getBreathingRate(VitalSignTypes.respirationRate, 12, 20),
        ),
        vitalName: AppConstents.breathingRate,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.respirationRate),
        vitalCondition: 'Avg 12 - 20',
        vitalStatus: statusHelper.getBreathingRate(
          VitalSignTypes.respirationRate,
          12,
          20,
        ),
        vitalHeading: WellnessMetricHeading.breathingRate,
        vitalDescription: WellnessMetricDescriptionsLong.breathRate,
        vitalMass: 'rpm',
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPulseRateAsset(
          statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
        ),
        vitalName: AppConstents.pulseRate,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: statusHelper.getPulseRate(
          VitalSignTypes.pulseRate,
          60,
          100,
        ),
        vitalHeading: WellnessMetricHeading.pulseRate,
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        vitalName: AppConstents.bloodPressure,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: '',
        vitalMass: "mmHg",
        vitalStatus: statusHelper.getBpSystolic(systolic, 100, 129),
        vitalHeading: WellnessMetricHeading.bloodPressureDiastolic,
        vitalDescription: WellnessMetricDescriptionsLong.bpSystolic,

        imageAsset: CommonHealthAsset().getSystolicBPAsset(
          statusHelper.getBpSystolic(systolic, 100, 129),
        ),
      ),

      buildCard(
        imageAsset: CommonHealthAsset().getOxygenSaturationAsset(
          statusHelper.getOxygenSaturation(
            VitalSignTypes.oxygenSaturation,
            94,
            95,
          ),
        ),
        vitalName: AppConstents.oxygenSaturation,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.oxygenSaturation),
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: statusHelper.getOxygenSaturation(
          VitalSignTypes.oxygenSaturation,
          95,
          95,
        ),
        vitalHeading: WellnessMetricHeading.oxygenSaturation,
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  List<Widget> bloodlessBloodTests() {
    bool isMale = false;
    var hemoglobinMin = 0.0;
    var hemoglobinMax = 0.0;
    if (_geustController.selectionType.isNotEmpty) {
      isMale = _geustController.selectionType.value == "Male";
    } else {
      isMale = _measurementController.genderType.toLowerCase() == 'male';
    }
    hemoglobinMin = isMale ? 14.0 : 12.0;
    hemoglobinMax = isMale ? 18.0 : 16.0;

    final a1cValueStr = statusHelper.getVitalValue(
      VitalSignTypes.hemoglobinA1C,
    );
    final a1cValue = double.tryParse(a1cValueStr ?? '');

    String a1cStatus = 'low'; // default for safety
    String a1cConditionText = '';

    if (a1cValue != null) {
      if (a1cValue <= 5.6) {
        a1cStatus = 'low';
        a1cConditionText = 'Normal';
      } else if (a1cValue <= 6.4) {
        a1cStatus = 'medium';
        a1cConditionText = 'Prediabetes risk';
      } else {
        a1cStatus = 'high';
        a1cConditionText = 'Diabetes risk';
      }
    }

    return [
      buildCard(
        imageAsset: CommonHealthAsset().getHemoglobinAsset(
          statusHelper.getHemoglobin(
            VitalSignTypes.hemoglobin,
            hemoglobinMin,
            hemoglobinMax,
          ),
        ),
        vitalName: AppConstents.hemoglobin,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
        vitalCondition: "",
        vitalMass: "g/dL",
        vitalStatus: statusHelper.getHemoglobin(
          VitalSignTypes.hemoglobin,
          hemoglobinMin,
          hemoglobinMax,
        ),

        vitalHeading: WellnessMetricHeading.hemoglobin,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getHbA1cAsset(a1cStatus),
        vitalName: AppConstents.hemoglobinA1C,
        vitalValue: a1cValueStr,
        vitalCondition: '', // 👈 status text like Prediabetes risk
        vitalMass: "%",
        vitalStatus: a1cConditionText,
        vitalHeading: WellnessMetricHeading.hemoglobinA1C,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobinA1C,
      ),
    ];
  }

  List<Widget> allCards() {
    return [...allVitalSigns(), ...bloodlessBloodTests()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Health data report",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: allCardsWithSpacing()),
      ),
    );
  }

  // Helper method to add vertical spacing between cards
  List<Widget> withSpacing(List<Widget> cards) {
    final spacedList = <Widget>[];
    for (var card in cards) {
      spacedList.add(card);
      spacedList.add(const SizedBox(height: 20));
    }
    return spacedList;
  }

  List<Widget> allCardsWithSpacing() {
    return withSpacing(allCards());
  }
}

// Dummy description classes
class WellnessMetricDescriptions {
  static const wellnessScore = "Wellness Score";
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
  static const RRiData = "RRi Data ";
}

class WellnessMetricDescriptionsLong {
  static const breathRate =
      "The breathing rate is the number of breaths you take per minute (rpm).";

  static const wellnessScore =
      "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years.";

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
  static const LfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";
  static const lfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";

  static const rriData =
      "The RR interval is the time between the \"R\" peaks of successive heartbeats, in milliseconds.";
}
