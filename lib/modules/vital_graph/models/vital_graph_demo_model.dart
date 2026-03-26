// To parse this JSON data, do
//
//     final vitalGraphDemoModel = vitalGraphDemoModelFromJson(jsonString);

import 'dart:convert';

VitalGraphDemoModel vitalGraphDemoModelFromJson(String str) =>
    VitalGraphDemoModel.fromJson(json.decode(str));

class VitalGraphDemoModel {
  List<String>? wellness;
  List<String>? basicVitalSigns;
  List<String>? bloodlessBloodTests;
  List<String>? risks;
  List<String>? stress;
  List<String>? heartRateVariability;
  List<String>? advancedHeartRateVariability;
  List<WellnessDetail>? wellnessDetails;

  VitalGraphDemoModel({
    this.wellness,
    this.basicVitalSigns,
    this.bloodlessBloodTests,
    this.risks,
    this.stress,
    this.heartRateVariability,
    this.advancedHeartRateVariability,
    this.wellnessDetails,
  });

  factory VitalGraphDemoModel.fromJson(Map<String, dynamic> json) =>
      VitalGraphDemoModel(
        wellness: List<String>.from(json["Wellness"].map((x) => x)),
        basicVitalSigns: List<String>.from(
          json["basic_vital_signs"].map((x) => x),
        ),
        bloodlessBloodTests: List<String>.from(
          json["bloodless_blood_tests"].map((x) => x),
        ),
        risks: List<String>.from(json["risks"].map((x) => x)),
        stress: List<String>.from(json["stress"].map((x) => x)),
        heartRateVariability: List<String>.from(
          json["heart_rate_variability"].map((x) => x),
        ),
        advancedHeartRateVariability: List<String>.from(
          json["advanced_heart_rate_variability"].map((x) => x),
        ),
        wellnessDetails: List<WellnessDetail>.from(
          json["wellnessDetails"].map((x) => WellnessDetail.fromJson(x)),
        ),
      );
}

class WellnessDetail {
  String vitalValue;

  WellnessDetail({required this.vitalValue});

  factory WellnessDetail.fromJson(Map<String, dynamic> json) =>
      WellnessDetail(vitalValue: json["vital_value"]);

  Map<String, dynamic> toJson() => {"vital_value": vitalValue};
}
