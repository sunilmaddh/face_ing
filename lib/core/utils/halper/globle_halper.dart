import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';

class GlobleHalper {
  final Map<String, List<String>> healthCategories = {
    "Basic Vital Signs": [
      "Wellness Score",
      "Breathing Rate",
      "Heart Rate",
      "PRQ",
      "Blood Pressure",
      "Oxygen Saturation",
    ],
    "Bloodless Blood Tests": ["Hemoglobin", "Hemoglobin A1C"],
    "Risks": [
      "ASCVD Risk",
      "Heart Age",
      "High Blood Pressure Risk",
      "High HbA1c Risk",
      "High Fasting Glucose Risk",
      "High Total Cholesterol Risk",
      "Low Hemoglobin Risk",
    ],
    "Stress": ["Stress Level", "Stress Index", "Normalized Stress Index"],
    "Heart Rate Variability": ["HRV SDNN", "Mean RRi", "RMSSD"],
    "Advanced Heart Rate Variability": [
      "Recovery Ability (PNS Zone)",
      "PNS Index",
      "Stress Response (SNS Zone)",
      "SNS Index",
      "SD1",
      "SD2",
      "LF/HF",
    ],
  };

  /// Stores categorized vitals into the controller
  Future<void> storeTabData(
    HealthDetailsResponseModel healthDataList,
    CommonMixin controller,
    isUserType,
  ) async {
    if (healthDataList.healthDetail == null) return;
    final Map<String, List<String>> normalizedCategories = {
      for (var entry in healthCategories.entries)
        entry.key: entry.value.map((e) => e.toLowerCase().trim()).toList(),
    };
    void processVital(HealthDetailList result) {
      final name = (result.vitalName ?? '').toLowerCase().trim();
      if (normalizedCategories["Basic Vital Signs"]!.contains(name)) {
        controller.basicVitalSigns.add(result);
      } else if (normalizedCategories["Bloodless Blood Tests"]!.contains(
        name,
      )) {
        controller.bloodlessBloodTests.add(result);
      } else if (normalizedCategories["Risks"]!.contains(name)) {
        controller.risks.add(result);
      } else if (normalizedCategories["Stress"]!.contains(name)) {
        controller.stress.add(result);
      } else if (normalizedCategories["Heart Rate Variability"]!.contains(
        name,
      )) {
        controller.heartRateVariability.add(result);
      } else if (normalizedCategories["Advanced Heart Rate Variability"]!
          .contains(name)) {
        controller.advancedHeartRateVariability.add(result);
      }
    }

    for (var result in healthDataList.healthDetail!) {
      processVital(result);
    }
  }

  // Main Tabs
  List<String> tabTitles = [
    "All",
    "Basic Vital Signs",
    "Bloodless Blood Tests",
    "Risks",
    "Stress",
    "Heart Rate Variability",
    "Advanced Heart Rate Variability",
  ];

  // Graph Tabs
  List<String> tabGraphTitles = [
    "Wellness",
    "Basic Vital Signs",
    "Bloodless Blood Tests",
    "Risks",
    "Stress",
    "Heart Rate Variability",
    "Advanced Heart Rate Variability",
  ];

  // Wellness Tabs
  List<String> tabWellnessTitles = ["Wellness"];

  // Vital Signs Tabs
  List<String> tabVitalSignTitles = [
    "Breathing Rate",
    "Pulse Rate (Heart Rate)",
    "PRQ",
    "Blood Pressure",
    "Oxygen Saturation",
  ];

  // Bloodless Blood Tests Tabs
  List<String> tabBBTTitles = ["Hemoglobin", "Hemoglobin A1C"];

  // Risk Tabs
  List<String> tabRiskTitles = [
    "ASCVD Risk",
    "High Blood Pressure Risk",
    "High HbA1c Risk",
    "High Fasting Glucose Risk",
    "High Total Cholesterol Risk",
    "Low Hemoglobin Risk",
  ];

  // Stress Tabs
  List<String> tabStressTitles = ["Stress Level"];

  // HRV Basic Tabs
  List<String> tabHRBTitles = ["HRV SDNN"];

  // Advanced HRV Tabs
  List<String> tabAHRVTitles = [
    "PNS Zone",
    "PNS Index",
    "SNS Zone",
    "SNS Index",
    "SD1",
    "SD2",
    "LF/HF",
  ];
}
