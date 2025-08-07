import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';

class GlobleHalper {
  /// Categories map with names EXACTLY matching JSON
  final Map<String, List<String>> healthCategories = {
    "Basic Vital Signs": [
      "Wellness Score",
      "Breathing Rate",
      "Pulse Rate(Heart Rate)", // ✅ Fixed to match JSON
      "PRQ",
      "Blood Pressure",
      "Oxygen Saturation", // ✅ Added from JSON
    ],
    "Bloodless Blood Tests": ["Hemoglobin", "Hemoglobin A1C"],
    "Risks": [
      "ASCVD Risk",
      "Heart Age",
      "High Blood Pressure Risk",
      "High HbA1c Risk", // ✅ Fixed to match JSON
      "High Fasting Glucose Risk",
      "High Total Cholesterol Risk",
      "Low Hemoglobin Risk",
    ],
    "Stress": ["Stress Level", "Stress Index", "Normalized Stress Index"],
    "Heart Rate Variability": [
      "HRV SDNN",
      "Mean RRi", // ✅ Fixed to match JSON
      "RMSSD",
    ],
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
  ) async {
    if (healthDataList.healthDetail == null) return;

    // 1️⃣ Normalize category map to lowercase for safe matching
    final Map<String, List<String>> normalizedCategories = {
      for (var entry in healthCategories.entries)
        entry.key: entry.value.map((e) => e.toLowerCase().trim()).toList(),
    };

    // 2️⃣ Create counters for debug summary
    int basicCount = 0;
    int bloodlessCount = 0;
    int risksCount = 0;
    int stressCount = 0;
    int hrvCount = 0;
    int advHrvCount = 0;
    int unclassifiedCount = 0;

    // 3️⃣ Recursive function to classify vitals
    void processVital(HealthDetailList result) {
      final name = (result.vitalName ?? '').toLowerCase().trim();

      if (normalizedCategories["Basic Vital Signs"]!.contains(name)) {
        controller.basicVitalSigns.add(result);
        print('   Basic Vital Signs: $name');
        basicCount++;
      } else if (normalizedCategories["Bloodless Blood Tests"]!.contains(
        name,
      )) {
        controller.bloodlessBloodTests.add(result);
        print('   bloodlessCount: $name');
        bloodlessCount++;
      } else if (normalizedCategories["Risks"]!.contains(name)) {
        controller.risks.add(result);
        print('   risksCount: $name');
        risksCount++;
      } else if (normalizedCategories["Stress"]!.contains(name)) {
        controller.stress.add(result);
        print('   stressCount: $name');
        stressCount++;
      } else if (normalizedCategories["Heart Rate Variability"]!.contains(
        name,
      )) {
        controller.heartRateVariability.add(result);
        print('   hrvCount: $name');
        hrvCount++;
      } else if (normalizedCategories["Advanced Heart Rate Variability"]!
          .contains(name)) {
        controller.advancedHeartRateVariability.add(result);
        print('   advHrvCount: $name');
        advHrvCount++;
      } else {
        unclassifiedCount++;
        print('⚠️ Unclassified vital: ${result.vitalName}');
      }

      // ✅ Recursively process sub-vitals if they exist
      // if (result.vitalSubList != null) {
      //   for (var sub in result.vitalSubList!) {
      //     processVital(sub);
      //   }
      // }
    }

    // 4️⃣ Process all top-level health details
    for (var result in healthDataList.healthDetail!) {
      processVital(result);
    }

    // 5️⃣ Debug summary log
    print('✅ Categorization Summary:');
    print('   Basic Vital Signs: $basicCount');
    print('   Bloodless Blood Tests: $bloodlessCount');
    print('   Risks: $risksCount');
    print('   Stress: $stressCount');
    print('   Heart Rate Variability: $hrvCount');
    print('   Advanced Heart Rate Variability: $advHrvCount');
    print('   ⚠️ Unclassified: $unclassifiedCount');
    print('✅ Categorization Summary:');
    print(
      '   Basic Vital Signs: ${controller.basicVitalSigns.first.vitalName}',
    );
    print(
      '   Bloodless Blood Tests: ${controller.bloodlessBloodTests.first.vitalName}',
    );
    print('   Risks: ${controller.risks.first.vitalName}');
    print('   Stress: ${controller.stress.first.vitalName}');
    print(
      '   Heart Rate Variability: ${controller.heartRateVariability.first.vitalName}',
    );
    print(
      '   Advanced Heart Rate Variability: ${controller.advancedHeartRateVariability.first.vitalName}',
    );
    print('   ⚠️ Unclassified: ${controller.basicVitalSigns.first.vitalName}');
  }
}
