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
  String? key;
  String? maxValue;
  String? minValue;
  String? actualValue;
  String? status;
  String? range;
  String? emoji;
  String? name;
  String? healthLine;
  String? desc;
  String? detail;

  HealthDetailList({
    this.key,
    this.maxValue,
    this.minValue,
    this.actualValue,
    this.status,
    this.range,
    this.emoji,
    this.name,
    this.healthLine,
    this.desc,
    this.detail,
  });

  factory HealthDetailList.fromJson(Map<String, dynamic> json) =>
      HealthDetailList(
        key: UtilMethods.stringParser(json["key"]),
        maxValue: UtilMethods.stringParser(json["maxValue"]),
        minValue: UtilMethods.stringParser(json["minValue"]),
        actualValue: UtilMethods.stringParser(json["actualValue"]),
        status: UtilMethods.stringParser(json["status"]),
        range: UtilMethods.stringParser(json["range"]),
        emoji: UtilMethods.stringParser(json["emoji"]),
        name: UtilMethods.stringParser(json["name"]),
        healthLine: UtilMethods.stringParser(json["healthLine"]),
        desc: UtilMethods.stringParser(json["desc"]),
        detail: UtilMethods.stringParser(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "maxValue": maxValue,
    "minValue": minValue,
    "actualValue": actualValue,
    "status": status,
    "range": range,
    "emoji": emoji,
    "name": name,
    "healthLine": healthLine,
    "desc": desc,
    "detail": detail,
  };
}
