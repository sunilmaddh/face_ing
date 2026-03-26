// To parse this JSON data, do
//
//     final latestWellnessModel = latestWellnessModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

LatestWellnessModel latestWellnessModelFromJson(String str) =>
    LatestWellnessModel.fromJson(json.decode(str));

String latestWellnessModelToJson(LatestWellnessModel data) =>
    json.encode(data.toJson());

class LatestWellnessModel {
  String? wellnessIndex;
  String? wellnessIndexPosOrNeg;
  String? wellnessIndexValueDiff;
  String? wellnessIndexstatus;
  String? bloodPressure;
  String? bloodPressureStatus;
  String? message;
  String? success;

  LatestWellnessModel({
    this.wellnessIndex,
    this.wellnessIndexPosOrNeg,
    this.wellnessIndexValueDiff,
    this.wellnessIndexstatus,
    this.bloodPressure,
    this.bloodPressureStatus,
    this.message,
    this.success,
  });

  factory LatestWellnessModel.fromJson(
    Map<String, dynamic> json,
  ) => LatestWellnessModel(
    wellnessIndex: UtilMethods.stringParser(json["wellnessIndex"]),
    wellnessIndexPosOrNeg: UtilMethods.stringParser(
      json["wellnessIndexPosOrNeg"],
    ),
    wellnessIndexValueDiff: UtilMethods.stringParser(
      json["wellnessIndexValueDiff"],
    ),
    wellnessIndexstatus: UtilMethods.stringParser(json["wellnessIndexstatus"]),
    bloodPressure: UtilMethods.stringParser(json["bloodPressure"]),
    bloodPressureStatus: UtilMethods.stringParser(json["bloodPressureStatus"]),
    message: UtilMethods.stringParser(json["message"]),
    success: UtilMethods.stringParser(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "wellnessIndex": wellnessIndex,
    "wellnessIndexPosOrNeg": wellnessIndexPosOrNeg,
    "wellnessIndexValueDiff": wellnessIndexValueDiff,
    "wellnessIndexstatus": wellnessIndexstatus,
    "bloodPressure": bloodPressure,
    "bloodPressureStatus": bloodPressureStatus,
    "message": message,
    "success": success,
  };
}
