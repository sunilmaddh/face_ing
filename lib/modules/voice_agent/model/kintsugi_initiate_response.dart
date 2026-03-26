// To parse this JSON data, do
//
//     final kintsigiInitiateResponse = kintsigiInitiateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

KintsigiInitiateResponse kintsigiInitiateResponseFromJson(String str) =>
    KintsigiInitiateResponse.fromJson(json.decode(str));

String kintsigiInitiateResponseToJson(KintsigiInitiateResponse data) =>
    json.encode(data.toJson());

class KintsigiInitiateResponse {
  String? success;
  String? msg;
  String? sessionId;

  KintsigiInitiateResponse({this.success, this.msg, this.sessionId});
  factory KintsigiInitiateResponse.fromJson(Map<String, dynamic> json) =>
      KintsigiInitiateResponse(
        success: UtilMethods.stringParser(json["success"]),
        msg: UtilMethods.stringParser(json["msg"]),
        sessionId: UtilMethods.stringParser(json["sessionId"]),
      );
  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "sessionId": sessionId,
  };
}
