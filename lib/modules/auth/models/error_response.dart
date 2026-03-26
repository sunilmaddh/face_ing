// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

UserAuthResponse errorResponseFromJson(String str) =>
    UserAuthResponse.fromJson(json.decode(str));

class UserAuthResponse {
  String? message, emailId, otp, userId, sdkInfo;

  bool? success, onBoarded;
  UserAuthResponse({
    this.message,
    this.emailId,
    this.otp,
    this.userId,
    this.sdkInfo,
    this.success,
    this.onBoarded,
  });

  factory UserAuthResponse.fromJson(Map<String, dynamic> json) =>
      UserAuthResponse(
        message: json["message"] ?? "",
        emailId: json["emailId"] ?? "",
        otp: json["otp"] ?? "",
        userId: json["userId"] ?? "",
        sdkInfo: json["sdkInfo"] ?? "",
        success: json["success"] ?? false,
        onBoarded: json["onBoarded"] ?? false,
      );
}
