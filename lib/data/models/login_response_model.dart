// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString?);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

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
        message: UtilMethods.stringParser(json["message"]),
        otp: UtilMethods.stringParser(json["otp"]),
        userId: UtilMethods.stringParser(json["userId"]),
        emailId: UtilMethods.stringParser(json["emailId"]),
        sdkInfo:
            json["sdkInfo"] != null
                ? List<dynamic>.from(json["sdkInfo"].map((x) => x))
                : [],
        commonUserDetailsDao:
            json["commonUserDetailsDao"] != null
                ? CommonUserDetailsDao.fromJson(json["commonUserDetailsDao"])
                : CommonUserDetailsDao(),
        success: UtilMethods.boolAsStringParser(json["success"]),
        onBoarded: UtilMethods.boolAsStringParser(json["onBoarded"]),
        otpverified: UtilMethods.boolAsStringParser(json["otpverified"]),
        blocked: UtilMethods.boolAsStringParser(json["blocked"]),
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
  String? userSmokerType;
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
    this.userSmokerType,
  });

  factory CommonUserDetailsDao.fromJson(Map<String?, dynamic> json) =>
      CommonUserDetailsDao(
        userId: UtilMethods.stringParser(json["userId"]),
        userEmail: UtilMethods.stringParser(json["userEmail"]),
        userPersonalDetailId: UtilMethods.stringParser(
          json["userPersonalDetailId"],
        ),
        userName: UtilMethods.stringParser(json["userName"]),
        userGender: UtilMethods.stringParser(json["userGender"]),
        userDob: UtilMethods.stringParser(json["userDOB"]),
        userWeight: UtilMethods.stringParser(json["userWeight"]),
        userHeight: UtilMethods.stringParser(json["userHeight"]),
        userImage: UtilMethods.stringParser(json["userImage"]),
        userSmokerType: UtilMethods.stringParser(json["smokerType"]),
      );
}
