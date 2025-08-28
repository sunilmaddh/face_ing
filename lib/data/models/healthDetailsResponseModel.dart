// To parse this JSON data, do
//
//     final healthDetailsResponseModel = healthDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

HealthDetailsResponseModel healthDetailsResponseModelFromJson(String str) =>
    HealthDetailsResponseModel.fromJson(json.decode(str));

String healthDetailsResponseModelToJson(HealthDetailsResponseModel data) =>
    json.encode(data.toJson());

class HealthDetailsResponseModel {
  String? msg;
  String? success;
  List<HealthDetailList>? healthDetail;

  HealthDetailsResponseModel({this.msg, this.success, this.healthDetail});

  factory HealthDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      HealthDetailsResponseModel(
        msg: UtilMethods.stringParser(json["msg"]),
        success: UtilMethods.stringParser(json["success"]),
        healthDetail:
            json["healthDetail"] == null
                ? []
                : List<HealthDetailList>.from(
                  json["healthDetail"].map((x) => HealthDetailList.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
    "healthDetail": List<dynamic>.from(healthDetail!.map((x) => x.toJson())),
  };
}

class HealthDetailList {
  String? vitalKey;
  String? vitalValue;
  String? vitalStatus;
  String? vitalRange;
  String? isTypeVital;
  String? vitalName;
  String? vitalHeading;
  String? vitalDescription;
  String? vitalUnit;
  String? vitalConfidence;
  List<HealthDetailList>? vitalSubList;
  HealthDetailList({
    this.vitalKey,
    this.vitalValue,
    this.vitalStatus,
    this.vitalRange,
    this.isTypeVital,
    this.vitalName,
    this.vitalHeading,
    this.vitalDescription,
    this.vitalUnit,
    this.vitalSubList,
    this.vitalConfidence,
  });
  factory HealthDetailList.fromJson(Map<String, dynamic> json) =>
      HealthDetailList(
        vitalKey: UtilMethods.stringParser(json["vitalKey"]),
        vitalValue: UtilMethods.stringParser(json["vitalValue"]),
        vitalStatus: UtilMethods.stringParser(json["vitalStatus"]),
        vitalRange: UtilMethods.stringParser(json["vitalRange"]),
        isTypeVital: UtilMethods.stringParser(json["isTypeVital"]),
        vitalName: UtilMethods.stringParser(json["vitalName"]),
        vitalHeading: UtilMethods.stringParser(json["vitalHeading"]),
        vitalDescription: UtilMethods.stringParser(json["vitalDescription"]),
        vitalUnit: UtilMethods.stringParser(json["vitalUnit"]),
        vitalConfidence: UtilMethods.stringParser(json["vitalConfLevel"]),
        vitalSubList:
            json["vitalSubList"] == null
                ? []
                : List<HealthDetailList>.from(
                  json["vitalSubList"]!.map(
                    (x) => HealthDetailList.fromJson(x),
                  ),
                ),
      );

  Map<String, dynamic> toJson() => {
    "vitalKey": vitalKey,
    "vitalValue": vitalValue,
    "vitalStatus": vitalStatus,
    "vitalRange": vitalRange,
    "isTypeVital": isTypeVital,
    "vitalName": vitalName,
    "vitalHeading": vitalHeading,
    "vitalDescription": vitalDescription,
    "vitalUnit": vitalUnit,
  };
}
