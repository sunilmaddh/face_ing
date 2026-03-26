// To parse this JSON data, do
//
//     final aiRecamendationResponse = aiRecamendationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

AiRecamendationResponse aiRecamendationResponseFromJson(String str) =>
    AiRecamendationResponse.fromJson(json.decode(str));

String aiRecamendationResponseToJson(AiRecamendationResponse data) =>
    json.encode(data.toJson());

class AiRecamendationResponse {
  String? resp1;
  String? resp2;
  String? success;
  String? msg;

  AiRecamendationResponse({this.resp1, this.resp2, this.success, this.msg});

  factory AiRecamendationResponse.fromJson(Map<String, dynamic> json) =>
      AiRecamendationResponse(
        resp1: UtilMethods.stringParser(json["resp1"]),
        resp2: UtilMethods.stringParser(json["resp2"]),
        success: UtilMethods.stringParser(json["success"]),
        msg: UtilMethods.stringParser(json["msg"]),
      );

  Map<String, dynamic> toJson() => {
    "resp1": resp1,
    "resp2": resp2,
    "success": success,
    "msg": msg,
  };
}
