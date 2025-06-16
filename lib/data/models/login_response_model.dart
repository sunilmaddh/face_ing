// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString?);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String? str) =>
    LoginResponseModel.fromJson(json.decode(str.toString()));

class LoginResponseModel {
  String? message;
  String? otp;
  String? userId;
  String? emailId;
  List<dynamic>? sdkInfo;
  CommonUserDetailsDao? commonUserDetailsDao;
  String? success;
  String? onBoarded;
  String? otpverified;
  String? blocked;

  LoginResponseModel({
    this.message,
    this.otp,
    this.userId,
    this.emailId,
    this.sdkInfo,
    this.commonUserDetailsDao,
    this.success,
    this.onBoarded,
    this.otpverified,
    this.blocked,
  });

  factory LoginResponseModel.fromJson(Map<String?, dynamic> json) =>
      LoginResponseModel(
        message: json["message"] ?? "",
        otp: json["otp"] ?? "",
        userId: json["userId"] ?? "",
        emailId: json["emailId"] ?? "",
        sdkInfo:
            json["sdkInfo"] != null
                ? List<dynamic>.from(json["sdkInfo"].map((x) => x))
                : [],
        commonUserDetailsDao:
            json["commonUserDetailsDao"] != null
                ? CommonUserDetailsDao.fromJson(json["commonUserDetailsDao"])
                : CommonUserDetailsDao(),
        success: json["success"] ?? "false",
        onBoarded: json["onBoarded"] ?? "false",
        otpverified: json["otpverified"] ?? "false",
        blocked: json["blocked"] ?? "false",
      );
}

class CommonUserDetailsDao {
  String? userId;
  String? userEmail;
  String? userPersonalDetailId;
  String? userName;
  String? userGender;
  String? userDob;
  String? userWeight;
  String? userHeight;
  String? userImage;

  CommonUserDetailsDao({
    this.userId,
    this.userEmail,
    this.userPersonalDetailId,
    this.userName,
    this.userGender,
    this.userDob,
    this.userWeight,
    this.userHeight,
    this.userImage,
  });

  factory CommonUserDetailsDao.fromJson(Map<String?, dynamic> json) =>
      CommonUserDetailsDao(
        userId: json["userId"] ?? "",
        userEmail: json["userEmail"] ?? "",
        userPersonalDetailId: json["userPersonalDetailId"] ?? "",
        userName: json["userName"] ?? "",
        userGender: json["userGender"] ?? "",
        userDob: json["userDOB"] ?? "",
        userWeight: json["userWeight"] ?? "",
        userHeight: json["userHeight"] ?? "",
        userImage: json["userImage"] ?? "",
      );
}
