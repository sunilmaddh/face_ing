// To parse this JSON data, do
//
//     final signupLoginResponseModel = signupLoginResponseModelFromJson(jsonString);

import 'dart:convert';

SignupLoginResponseModel signupLoginResponseModelFromJson(String str) =>
    SignupLoginResponseModel.fromJson(json.decode(str));

class SignupLoginResponseModel {
  String? message;
  String? otp;
  String? userId;
  String? emailId;
  List<SdkInfo>? sdkInfo;
  CommonUserDetailsDao? commonUserDetailsDao;
  bool? success;

  SignupLoginResponseModel({
    this.message,
    this.otp,
    this.userId,
    this.emailId,
    this.sdkInfo,
    this.commonUserDetailsDao,
    this.success,
  });

  factory SignupLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupLoginResponseModel(
        message: json["message"] ?? "",
        otp: json["otp"] ?? "",
        userId: json["userId"] ?? "",
        emailId: json["emailId"] ?? "",
        sdkInfo:
            json["sdkInfo"] != null
                ? []
                : List<SdkInfo>.from(
                  json["sdkInfo"].map((x) => SdkInfo.fromJson(x)),
                ),
        commonUserDetailsDao: CommonUserDetailsDao.fromJson(
          json["commonUserDetailsDao"],
        ),
        success: json["success"] ?? false,
      );
}

class CommonUserDetailsDao {
  String? userId;
  String? userEmail;
  String? userPersonalDetailId;
  String? userName;
  String? userGender;
  String? userDob;
  double? userWeight;
  double? userHeight;
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

  factory CommonUserDetailsDao.fromJson(Map<String, dynamic> json) =>
      CommonUserDetailsDao(
        userId: json["userId"] ?? "",
        userEmail: json["userEmail"] ?? "",
        userPersonalDetailId: json["userPersonalDetailId"] ?? "",
        userName: json["userName"] ?? "",
        userGender: json["userGender"] ?? "",
        userDob: json["userDOB"] ?? "",
        userWeight: json["userWeight"]?.toDouble(),
        userHeight: json["userHeight"]?.toDouble(),
        userImage: json["userImage"] ?? "",
      );
}

class SdkInfo {
  String? primaryId;
  String? sdkId;
  String? sdkName;

  SdkInfo({this.primaryId, this.sdkId, this.sdkName});

  factory SdkInfo.fromJson(Map<String, dynamic> json) => SdkInfo(
    primaryId: json["primaryId"] ?? "",
    sdkId: json["sdkId"] ?? "",
    sdkName: json["sdkName"] ?? "",
  );
}
