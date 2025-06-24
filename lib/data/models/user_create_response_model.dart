import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

UserCreateResponseModel userCreateResponseModelFromJson(String str) =>
    UserCreateResponseModel.fromJson(json.decode(str));

String userCreateResponseModelToJson(UserCreateResponseModel data) =>
    json.encode(data.toJson());

class UserCreateResponseModel {
  String? message;
  String? userId;
  String? emailId;
  CommonUserDetailsDao? commonUserDetailsDao;
  String? success;

  UserCreateResponseModel({
    this.message,
    this.userId,
    this.emailId,
    this.commonUserDetailsDao,
    this.success,
  });

  factory UserCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      UserCreateResponseModel(
        message: UtilMethods.stringParser(json["message"]),
        userId: UtilMethods.stringParser(json["userId"]),
        emailId: UtilMethods.stringParser(json["emailId"]),
        commonUserDetailsDao:
            json["commonUserDetailsDao"] != null
                ? CommonUserDetailsDao.fromJson(json["commonUserDetailsDao"])
                : CommonUserDetailsDao(),
        success: UtilMethods.boolAsStringParser(json["success"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "userId": userId,
    "emailId": emailId,
    "commonUserDetailsDao": commonUserDetailsDao!.toJson(),
    "success": success,
  };
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
  String? smokerType;

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
    this.smokerType,
  });

  factory CommonUserDetailsDao.fromJson(Map<String, dynamic> json) =>
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
        smokerType: UtilMethods.stringParser(json["smokerType"]),
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userEmail": userEmail,
    "userPersonalDetailId": userPersonalDetailId,
    "userName": userName,
    "userGender": userGender,
    "userDOB": userDob,
    "userWeight": userWeight,
    "userHeight": userHeight,
    "userImage": userImage,
    "smokerType": smokerType,
  };
}
