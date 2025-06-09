import 'package:ntt_data/data/models/guest_history_details_model.dart';
import 'package:ntt_data/data/models/user_health_details.dart';

class ShowGuestHistoryDetails {
  Future<List<Map<String, dynamic>>> fetchHistoryAnuraDetails(
    GuestHealthAnuraHistory guestAnuraHistory,
  ) async {
    List<Map<String, dynamic>> listOfData = [
      {"key": "Overall Health Score", "value": guestAnuraHistory.healthScore},
      {"key": "Heart Rate", "value": guestAnuraHistory.hRbpm},
      {"key": "Breathing Rate", "value": guestAnuraHistory.hRbpm},
      {
        "key":
            "Blood Pressure"
            "",
        "value": guestAnuraHistory.bPSystolic,
      },

      {
        "key":
            "Irregular Heartbeat Count"
            "",
        "value": guestAnuraHistory.iHbCount,
      },
      {
        "key":
            "Hemoglobin A1C Risk"
            "",
        "value": guestAnuraHistory.hBa1CRiskProb,
      },

      {
        "key": "Fasting Blood Glucose Risk",
        "value": guestAnuraHistory.mFbgRiskProb,
      },
      {"key": "Cardiovascular Risk Level", "value": guestAnuraHistory.bPcvd},
      {"key": "Heart Attack Risk", "value": guestAnuraHistory.bpHeartAttack},
      {"key": "Stroke Risk", "value": guestAnuraHistory.bPStroke},
      {"key": "Diabetes Risk", "value": guestAnuraHistory.dBtRiskProb},
      {
        "key": "Fatty Liver Disease Risk",
        "value": guestAnuraHistory.fLdRiskProb,
      },
      {
        "key": "Hypercholesterolemia Risk",
        "value": guestAnuraHistory.hDltcRiskProb,
      },
      {"key": "Hypertension Risk", "value": guestAnuraHistory.hPtRiskProb},
      {
        "key": "Overall Metabolic Health Risk",
        "value": guestAnuraHistory.overallMetabolicRiskProb,
      },
      {"key": "Mental Score", "value": guestAnuraHistory.mentalScore},

      {"key": "Physical Score", "value": guestAnuraHistory.physicalScore},
      {"key": "Physiological Score", "value": guestAnuraHistory.physioScore},
      {"key": "Risk Score", "value": guestAnuraHistory.risksScore},
      {"key": "Vital Signs Score", "value": guestAnuraHistory.vitalScore},
      {"key": "Mental Stress Index", "value": guestAnuraHistory.mSi},
      {"key": "Cardiac Workload", "value": guestAnuraHistory.bPrpp},
      {"key": "Vascular Capacity", "value": guestAnuraHistory.bPTau},
      {"key": "Heart Rate Variability", "value": guestAnuraHistory.hRvsdnn},
      {"key": "Facial Skin Age", "value": guestAnuraHistory.age},
      {"key": "Signal-to-Noise Ratio", "value": guestAnuraHistory.sNr},
    ];

    return listOfData;
  }

  Future<List<Map<String, dynamic>>> fetchUserHistoryAnuraDetails(
    UserHealthAnuraDetail guestAnuraHistory,
  ) async {
    List<Map<String, dynamic>> listOfData = [
      {"key": "Overall Health Score", "value": guestAnuraHistory.healthScore},
      {"key": "Heart Rate", "value": guestAnuraHistory.hRbpm},
      {"key": "Breathing Rate", "value": guestAnuraHistory.hRbpm},
      {
        "key":
            "Blood Pressure"
            "",
        "value": guestAnuraHistory.bPSystolic ?? '5',
      },

      {
        "key":
            "Irregular Heartbeat Count"
            "",
        "value": guestAnuraHistory.iHbCount,
      },
      {
        "key":
            "Hemoglobin A1C Risk"
            "",
        "value": guestAnuraHistory.hBa1CRiskProb,
      },

      {
        "key": "Fasting Blood Glucose Risk",
        "value": guestAnuraHistory.mFbgRiskProb,
      },
      {"key": "Cardiovascular Risk Level", "value": guestAnuraHistory.bPcvd},
      {"key": "Heart Attack Risk", "value": guestAnuraHistory.bpHeartAttack},
      {"key": "Stroke Risk", "value": guestAnuraHistory.bPStroke},
      {"key": "Diabetes Risk", "value": guestAnuraHistory.dBtRiskProb},
      {
        "key": "Fatty Liver Disease Risk",
        "value": guestAnuraHistory.fLdRiskProb,
      },
      {
        "key": "Hypercholesterolemia Risk",
        "value": guestAnuraHistory.hDltcRiskProb,
      },
      {"key": "Hypertension Risk", "value": guestAnuraHistory.hPtRiskProb},
      {
        "key": "Overall Metabolic Health Risk",
        "value": guestAnuraHistory.overallMetabolicRiskProb,
      },
      {"key": "Mental Score", "value": guestAnuraHistory.mentalScore},

      {"key": "Physical Score", "value": guestAnuraHistory.physicalScore},
      {"key": "Physiological Score", "value": guestAnuraHistory.physioScore},
      {"key": "Risk Score", "value": guestAnuraHistory.risksScore},
      {"key": "Vital Signs Score", "value": guestAnuraHistory.vitalScore},
      {"key": "Mental Stress Index", "value": guestAnuraHistory.mSi},
      {"key": "Cardiac Workload", "value": guestAnuraHistory.bPrpp},
      {"key": "Vascular Capacity", "value": guestAnuraHistory.bPTau},
      {"key": "Heart Rate Variability", "value": guestAnuraHistory.hRvsdnn},
      {"key": "Facial Skin Age", "value": guestAnuraHistory.age},
      {"key": "Signal-to-Noise Ratio", "value": guestAnuraHistory.sNr},
    ];

    return listOfData;
  }

  Future<List<Map<String, dynamic>>> fetchHistoryBinahDetails(
    GuestHealthBinahHistory guestBinahHistory,
  ) async {
    List<Map<String, dynamic>> listOfData = [
      {"key": "Wellness Index", "value": guestBinahHistory.wellnessIndex},
      {"key": "Heart Rate", "value": guestBinahHistory.pulseRate},
      {"key": "Breathing Rate", "value": guestBinahHistory.respirationRate},
      {
        "key": "Pulse Respiration Quotient (PRQ)",
        "value": guestBinahHistory.prq,
      },
      {"key": "Oxygen Saturation", "value": guestBinahHistory.oxygenSaturation},
      {"key": "Blood Pressure", "value": guestBinahHistory.bloodPressure},
      {"key": "Hemoglobin", "value": guestBinahHistory.hemoglobin},
      {"key": "HemoglobinA1C", "value": guestBinahHistory.hemoglobinA1C},
      {"key": "ASCVD Risk", "value": guestBinahHistory.ascvdRisk},
      {"key": "Heart Age", "value": guestBinahHistory.heartAge},
      {
        "key": "High Blood Pressure Risk",
        "value": guestBinahHistory.highBloodPressureRisk,
      },
      {
        "key": "High Hemoglobin A1C Risk",
        "value": guestBinahHistory.highHemoglobinA1CRisk,
      },
      {
        "key": "High Fasting Glucose Risk",
        "value": guestBinahHistory.highFastingGlucoseRisk,
      },
      {
        "key": "High Total Cholesterol Risk",
        "value": guestBinahHistory.highTotalCholesterolRisk,
      },
      {
        "key": "Low Hemoglobin Risk",
        "value": guestBinahHistory.lowHemoglobinRisk,
      },
      {"key": "Stress Level", "value": guestBinahHistory.stressLevel},
      {"key": "Stress Index", "value": guestBinahHistory.stressIndex},
      {
        "key": "Normalized Stress Index",
        "value": guestBinahHistory.normalizedStressIndex,
      },
      {"key": "HRV SDNN", "value": guestBinahHistory.sdnn},
      {"key": "Mean R-R Interval", "value": guestBinahHistory.meanRri},
      {"key": "RMSSD", "value": guestBinahHistory.rmssd},
      {"key": "PNS Zone", "value": guestBinahHistory.pnsZone},
      {"key": "PNS Index", "value": guestBinahHistory.pnsIndex},
      {"key": "SNS Index", "value": guestBinahHistory.snsIndex},
      {
        "key": "Standard Deviation 1 - HRV metric",
        "value": guestBinahHistory.sd1,
      },
      {
        "key": "Standard Deviation 2 - HRV metric",
        "value": guestBinahHistory.sd2,
      },
      {"key": "SNS Zone", "value": guestBinahHistory.snsZone},
      {"key": "LF/HF Ratio", "value": guestBinahHistory.lfhf},
    ];

    return listOfData;
  }

  Future<List<Map<String, dynamic>>> fetchUserHistoryBinahDetails(
    UserHealthBinahHistory guestBinahHistory,
  ) async {
    List<Map<String, dynamic>> listOfData = [
      {"key": "Wellness Index", "value": guestBinahHistory.wellnessIndex},
      {"key": "Heart Rate", "value": guestBinahHistory.pulseRate},
      {"key": "Breathing Rate", "value": guestBinahHistory.respirationRate},
      {
        "key": "Pulse Respiration Quotient (PRQ)",
        "value": guestBinahHistory.prq,
      },
      {"key": "Oxygen Saturation", "value": guestBinahHistory.oxygenSaturation},
      {"key": "Blood Pressure", "value": guestBinahHistory.bloodPressure},
      {"key": "Hemoglobin", "value": guestBinahHistory.hemoglobin},
      {"key": "HemoglobinA1C", "value": guestBinahHistory.hemoglobinA1C},
      {"key": "ASCVD Risk", "value": guestBinahHistory.ascvdRisk},
      {"key": "Heart Age", "value": guestBinahHistory.heartAge},
      {
        "key": "High Blood Pressure Risk",
        "value": guestBinahHistory.highBloodPressureRisk,
      },
      {
        "key": "High Hemoglobin A1C Risk",
        "value": guestBinahHistory.highHemoglobinA1CRisk,
      },
      {
        "key": "High Fasting Glucose Risk",
        "value": guestBinahHistory.highFastingGlucoseRisk,
      },
      {
        "key": "High Total Cholesterol Risk",
        "value": guestBinahHistory.highTotalCholesterolRisk,
      },
      {
        "key": "Low Hemoglobin Risk",
        "value": guestBinahHistory.lowHemoglobinRisk,
      },
      {"key": "Stress Level", "value": guestBinahHistory.stressLevel},
      {"key": "Stress Index", "value": guestBinahHistory.stressIndex},
      {
        "key": "Normalized Stress Index",
        "value": guestBinahHistory.normalizedStressIndex,
      },
      {"key": "HRV SDNN", "value": guestBinahHistory.sdnn},
      {"key": "Mean R-R Interval", "value": guestBinahHistory.meanRri},
      {"key": "RMSSD", "value": guestBinahHistory.rmssd},
      {"key": "PNS Zone", "value": guestBinahHistory.pnsZone},
      {"key": "PNS Index", "value": guestBinahHistory.pnsIndex},
      {"key": "SNS Index", "value": guestBinahHistory.snsIndex},
      {
        "key": "Standard Deviation 1 - HRV metric",
        "value": guestBinahHistory.sd1,
      },
      {
        "key": "Standard Deviation 2 - HRV metric",
        "value": guestBinahHistory.sd2,
      },
      {"key": "SNS Zone", "value": guestBinahHistory.snsZone},
      {"key": "LF/HF Ratio", "value": guestBinahHistory.lfhf},
    ];

    return listOfData;
  }
}
