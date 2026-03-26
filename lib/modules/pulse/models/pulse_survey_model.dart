// To parse this JSON data, do
//
//     final pulseSurveyModel = pulseSurveyModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

PulseSurveyModel pulseSurveyModelFromJson(String str) =>
    PulseSurveyModel.fromJson(json.decode(str));

// String pulseSurveyModelToJson(PulseSurveyModel data) =>
//     json.encode(data.toJson());

class PulseSurveyModel {
  String? status;
  List<PulseSurveyList>? result;
  List<String>? xAxis;
  List<String>? statusList;
  List<PulseSurveyADay>? pulseSurveyADayList;
  String? msg;
  String? success;

  PulseSurveyModel({
    this.status,
    this.result,
    this.xAxis,
    this.statusList,
    this.msg,
    this.success,
    this.pulseSurveyADayList,
  });

  factory PulseSurveyModel.fromJson(Map<String, dynamic> json) =>
      PulseSurveyModel(
        status: UtilMethods.stringParser(json["status"]),
        pulseSurveyADayList:
            json["title"] == null
                ? []
                : List<PulseSurveyADay>.from(
                  json["title"].map((x) => PulseSurveyADay.fromJson(x)),
                ),
        result:
            json["result"] == null
                ? []
                : List<PulseSurveyList>.from(
                  json["result"].map((x) => PulseSurveyList.fromJson(x)),
                ),
        xAxis:
            json["xAxis"] == null
                ? []
                : List<String>.from(json["xAxis"].map((x) => x)),
        statusList:
            json["statusList"] == null
                ? []
                : List<String>.from(json["statusList"].map((x) => x)),
        msg: UtilMethods.stringParser(json["msg"]),
        success: UtilMethods.stringParser(json["success"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "status": status,
  //   "result": List<dynamic>.from(result.map((x) => x.toJson())),
  //   "xAxis": List<dynamic>.from(xAxis.map((x) => x)),
  //   "statusList": List<dynamic>.from(statusList.map((x) => x)),
  //   "msg": msg,
  //   "success": success,
  // };
}

class PulseSurveyList {
  String? status;
  String? value;
  String? surveyDate;

  PulseSurveyList({this.status, this.value, this.surveyDate});

  factory PulseSurveyList.fromJson(Map<String, dynamic> json) =>
      PulseSurveyList(
        status: UtilMethods.stringParser(json["status"]),
        value: UtilMethods.stringParser(json["value"]),
        surveyDate: UtilMethods.stringParser(json["surveyDate"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "status": status,
  //     "value": value,
  //     "surveyDate": surveyDate.toIso8601String(),
  // };
}

class PulseSurveyADay {
  String? title;
  String? status;

  PulseSurveyADay({this.title, this.status});

  factory PulseSurveyADay.fromJson(Map<String, dynamic> json) =>
      PulseSurveyADay(
        title: UtilMethods.stringParser(json["title"]),
        status: UtilMethods.stringParser(json["status"]),
      );

  Map<String, dynamic> toJson() => {"title": title, "status": status};
}
