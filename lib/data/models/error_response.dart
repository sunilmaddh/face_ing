// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

class ErrorResponse {
  String? message, emailId, otp, userId, sdkInfo;

  bool? success, onBoarded;
  ErrorResponse({
    this.message,
    this.emailId,
    this.otp,
    this.userId,
    this.sdkInfo,
    this.success,
    this.onBoarded,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"] ?? "",
    emailId: json["emailId"] ?? "",
    otp: json["otp"] ?? "",
    userId: json["userId"] ?? "",
    sdkInfo: json["sdkInfo"] ?? "",
    success: json["success"] ?? false,
    onBoarded: json["onBoarded"] ?? false,
  );
}
