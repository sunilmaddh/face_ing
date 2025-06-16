// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) =>
    ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) =>
    json.encode(data.toJson());

class ErrorResponseModel {
  String? message;
  String? otpverified;
  String? onBoarded;
  String? blocked;
  String? success;

  ErrorResponseModel({
    this.message,
    this.otpverified,
    this.onBoarded,
    this.blocked,
    this.success,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        message: json["message"] ?? "",
        otpverified: json["otpverified"] ?? "",
        onBoarded: json["onBoarded"] ?? "",
        blocked: json["blocked"] ?? "",
        success: json["success"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "otpverified": otpverified,
    "onBoarded": onBoarded,
    "blocked": blocked,
    "success": success,
  };
}
