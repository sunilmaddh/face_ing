// To parse this JSON data, do
//
//     final kintsigiRusltResponse = kintsigiRusltResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

KintsigiRusltResponse kintsigiRusltResponseFromJson(String str) =>
    KintsigiRusltResponse.fromJson(json.decode(str));

class KintsigiRusltResponse {
  String? success;
  String? msg;
  Result? result;
  KintsigiRusltResponse({this.success, this.msg, this.result});
  factory KintsigiRusltResponse.fromJson(Map<String, dynamic> json) =>
      KintsigiRusltResponse(
        success: UtilMethods.stringParser(json["success"]),
        msg: UtilMethods.stringParser(json["msg"]),
        result:
            json["result"] == null ? Result() : Result.fromJson(json["result"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "success": success,
  //     "msg": msg,
  //     "result": result.toJson(),
  // };
}

class Result {
  Depression? depression;
  Anxiety? anxiety;
  String? createdAt;
  String? disclaimer;

  Result({this.depression, this.anxiety, this.createdAt, this.disclaimer});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    depression:
        json["depression"] == null
            ? Depression()
            : Depression.fromJson(json["depression"]),
    anxiety:
        json["anxiety"] == null ? Anxiety() : Anxiety.fromJson(json["anxiety"]),
    createdAt: UtilMethods.stringParser(json["createdAt"]),
    disclaimer: UtilMethods.stringParser(json["disclaimer"]),
  );

  // Map<String, dynamic> toJson() => {
  //     "depression": depression.toJson(),
  //     "anxiety": anxiety.toJson(),
  //     "createdAt": createdAt.toIso8601String(),
  //     "disclaimer": disclaimer,
  // };
}

class Anxiety {
  String? aiPrediction;
  String? clinicalData;
  String? gad7Score;

  Anxiety({this.aiPrediction, this.clinicalData, this.gad7Score});

  factory Anxiety.fromJson(Map<String, dynamic> json) => Anxiety(
    aiPrediction: UtilMethods.stringParser(json["aiPrediction"]),
    clinicalData: UtilMethods.stringParser(json["clinicalData"]),
    gad7Score: UtilMethods.stringParser(json["gad7Score"]),
  );

  Map<String, dynamic> toJson() => {
    "aiPrediction": aiPrediction,
    "clinicalData": clinicalData,
    "gad7Score": gad7Score,
  };
}

class Depression {
  String? aiPrediction;
  String? clinicalData;
  String? phq2Score;
  String? phq9Score;

  Depression({
    this.aiPrediction,
    this.clinicalData,
    this.phq2Score,
    this.phq9Score,
  });

  factory Depression.fromJson(Map<String, dynamic> json) => Depression(
    aiPrediction: UtilMethods.stringParser(json["aiPrediction"]),
    clinicalData: UtilMethods.stringParser(json["clinicalData"]),
    phq2Score: UtilMethods.stringParser(json["phq2Score"]),
    phq9Score: UtilMethods.stringParser(json["phq9Score"]),
  );

  Map<String, dynamic> toJson() => {
    "aiPrediction": aiPrediction,
    "clinicalData": clinicalData,
    "phq2Score": phq2Score,
    "phq9Score": phq9Score,
  };
}
