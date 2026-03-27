import 'package:ntt_data/core/utils/enum/enums.dart';
import 'package:ntt_data/core/utils/enum/gender_enum.dart';
import 'package:ntt_data/core/utils/enum/health_tab_enum.dart';

extension StringOperation on String {
  String toFirstCaps() {
    try {
      return (this).substring(0, 1).toUpperCase() +
            (this).substring(1, (this).length)
        ..toLowerCase();
    } catch (e) {
      return this;
    }
  }
}

extension HealthTabExtension on HealthTab {
  String get title {
    switch (this) {
      case HealthTab.all:
        return "All";
      case HealthTab.basicVitalSigns:
        return "Basic Vital Signs";
      case HealthTab.bloodlessBloodTests:
        return "Bloodless Blood Tests";
      case HealthTab.risks:
        return "Risks";
      case HealthTab.stress:
        return "Stress";
      case HealthTab.heartRateVariability:
        return "Heart Rate Variability";
      case HealthTab.advancedHeartRateVariability:
        return "Advanced Heart Rate Variability";
    }
  }
}

extension HealthCategoryExtension on HealthCategory {
  String get title {
    switch (this) {
      case HealthCategory.basicVitalSigns:
        return "Basic Vital Signs";
      case HealthCategory.bloodlessBloodTests:
        return "Bloodless Blood Tests";
      case HealthCategory.risks:
        return "Risks";
      case HealthCategory.stress:
        return "Stress";
      case HealthCategory.heartRateVariability:
        return "Heart Rate Variability";
      case HealthCategory.advancedHeartRateVariability:
        return "Advanced Heart Rate Variability";
    }
  }

  List<String> get vitals {
    switch (this) {
      case HealthCategory.basicVitalSigns:
        return const [
          "Wellness Score",
          "Breathing Rate",
          "Heart Rate",
          "PRQ",
          "Blood Pressure",
          "Oxygen Saturation",
        ];

      case HealthCategory.bloodlessBloodTests:
        return const ["Hemoglobin", "Hemoglobin A1C"];

      case HealthCategory.risks:
        return const [
          "ASCVD Risk",
          "Heart Age",
          "High Blood Pressure Risk",
          "High HbA1c Risk",
          "High Fasting Glucose Risk",
          "High Total Cholesterol Risk",
          "Low Hemoglobin Risk",
        ];

      case HealthCategory.stress:
        return const [
          "Stress Level",
          "Stress Index",
          "Normalized Stress Index",
        ];

      case HealthCategory.heartRateVariability:
        return const ["HRV SDNN", "Mean RRi", "RMSSD"];

      case HealthCategory.advancedHeartRateVariability:
        return const [
          "Recovery Ability (PNS Zone)",
          "PNS Index",
          "Stress Response (SNS Zone)",
          "SNS Index",
          "SD1",
          "SD2",
          "LF/HF",
        ];
    }
  }

  List<String> get normalizedVitals =>
      vitals.map((e) => e.toLowerCase().trim()).toList();
}

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
    }
  }
}

extension SmkoerExtension on Smoker {
  String get value {
    switch (this) {
      case Smoker.smoker:
        return "Smoker";
      case Smoker.nonSmoker:
        return "No Smoker";
    }
  }
}

extension ImageValidityMessageExt on ImageValidityMessage {
  String get message {
    switch (this) {
      case ImageValidityMessage.valid:
        return "Perfect! Please hold it.";

      case ImageValidityMessage.invalidDeviceOrientation:
        return "Return to portrait mode.";

      case ImageValidityMessage.invalidRoi:
      case ImageValidityMessage.faceTooFar:
        return "Please move your face closer to the camera.";

      case ImageValidityMessage.tiltedHead:
        return "Make sure your head is upright and centered in the frame.";

      case ImageValidityMessage.unevenLight:
        return "Ensure your face is clearly visible with no shadows or bright spots.";

      case ImageValidityMessage.unknown:
        return "Unknown Error";
    }
  }
}
