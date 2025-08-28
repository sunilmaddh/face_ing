// To parse this JSON data, do
//
//     final vitalGraphResponseModel = vitalGraphResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

VitalGraphResponseModel vitalGraphResponseModelFromJson(String str) =>
    VitalGraphResponseModel.fromJson(json.decode(str));

class VitalGraphResponseModel {
  String? dateRange;
  AdvancedHeartRateVariability? wellness;
  AdvancedHeartRateVariability? vitalSigns;
  AdvancedHeartRateVariability? bloodlessBloodTests;
  AdvancedHeartRateVariability? risks;
  AdvancedHeartRateVariability? stress;
  AdvancedHeartRateVariability? hrvSddnn;
  AdvancedHeartRateVariability? advancedHeartRateVariability;

  VitalGraphResponseModel({
    this.dateRange,
    this.wellness,
    this.vitalSigns,
    this.bloodlessBloodTests,
    this.risks,
    this.stress,
    this.hrvSddnn,
    this.advancedHeartRateVariability,
  });
  factory VitalGraphResponseModel.fromJson(Map<String, dynamic> json) =>
      VitalGraphResponseModel(
        dateRange: UtilMethods.stringParser(json["dateRange"]),
        wellness: AdvancedHeartRateVariability.fromJson(json["wellness"]),
        vitalSigns: AdvancedHeartRateVariability.fromJson(json["vitalSigns"]),
        bloodlessBloodTests: AdvancedHeartRateVariability.fromJson(
          json["bloodlessBloodTests"],
        ),
        risks: AdvancedHeartRateVariability.fromJson(json["risks"]),
        stress: AdvancedHeartRateVariability.fromJson(json["stress"]),
        hrvSddnn: AdvancedHeartRateVariability.fromJson(json["hrvSddnn"]),
        advancedHeartRateVariability: AdvancedHeartRateVariability.fromJson(
          json["advancedHeartRateVariability"],
        ),
      );
}

class AdvancedHeartRateVariability {
  List<String>? vitalType;
  List<VitalTypeDetail>? vitalTypeDetails;
  AdvancedHeartRateVariability({this.vitalType, this.vitalTypeDetails});

  factory AdvancedHeartRateVariability.fromJson(Map<String, dynamic> json) =>
      AdvancedHeartRateVariability(
        vitalType:
            json["vitalType"] == null
                ? []
                : List<String>.from(json["vitalType"].map((x) => x)),
        vitalTypeDetails:
            json["vitalTypeDetails"] == null
                ? []
                : List<VitalTypeDetail>.from(
                  json["vitalTypeDetails"].map(
                    (x) => VitalTypeDetail.fromJson(x),
                  ),
                ),
      );
}

class VitalTypeDetail {
  List<String> xValues;
  List<HealthList> healthList;
  List<String> yValues;

  VitalTypeDetail({
    required this.xValues,
    required this.healthList,
    required this.yValues,
  });

  factory VitalTypeDetail.fromJson(Map<String, dynamic> json) =>
      VitalTypeDetail(
        xValues:
            json["xValues"] == null
                ? []
                : List<String>.from(json["xValues"].map((x) => x)),
        healthList:
            json["healthList"] == null
                ? []
                : List<HealthList>.from(
                  json["healthList"].map((x) => HealthList.fromJson(x)),
                ),
        yValues:
            json["yValues"] == null
                ? []
                : List<String>.from(json["yValues"].map((x) => x)),
      );
}

class HealthList {
  String? value;
  String? scannedDate;
  String? status;

  HealthList({this.value, this.scannedDate, this.status});

  factory HealthList.fromJson(Map<String, dynamic> json) => HealthList(
    value: UtilMethods.stringParser(json["value"]),
    scannedDate: UtilMethods.stringParser(json["scannedDate"]),
    status: UtilMethods.stringParser(json["status"]),
  );
}
