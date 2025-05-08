import 'package:ntt_data/data/models/guest_history_details_model.dart';

class ShowGuestHistoryDetails {
  Future<List<Map<String, dynamic>>> fetchHistoryDetails(
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
        "value": guestAnuraHistory.aBsi,
      },
      {
        "key":
            "Hemoglobin A1C Risk"
            "",
        "value": "",
      },

      {"key": "Fasting Blood Glucose Risk", "value": ""},

      {"key": "Cardiovascular Risk Level", "value": ""},

      {"key": "Heart Attack Risk", "value": ""},
      {"key": "Stroke Risk", "value": ""},
      {"key": "Diabetes Risk", "value": ""},
      {"key": "Fatty Liver Disease Risk", "value": ""},
      {"key": "Hypercholesterolemia Risk", "value": ""},
      {"key": "Hypertension Risk", "value": ""},

      {"key": "Overall Metabolic Health Risk", "value": ""},

      {"key": "Hypertriglyceridemia Risk", "value": ""},
      {"key": "Mental Score", "value": ""},

      {"key": "Physical Score", "value": ""},
      {"key": "Physiological Score", "value": ""},
      {"key": "Risk Score", "value": ""},
      {"key": "Vital Signs Score", "value": ""},
      {"key": "Mental Stress Index", "value": ""},
      {"key": "Cardiac Workload", "value": ""},
      {"key": "Vascular Capacity", "value": ""},
      {"key": "Heart Rate Variability", "value": ""},
      {"key": "Facial Skin Age", "value": ""},
      {"key": "Signal-to-Noise Ratio", "value": ""},
    ];

    return listOfData;
  }
}
