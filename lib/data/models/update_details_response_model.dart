// To parse this JSON data, do
//
//     final updateDetailsResponseModel = updateDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

UpdateDetailsResponseModel updateDetailsResponseModelFromJson(String str) =>
    UpdateDetailsResponseModel.fromJson(json.decode(str));

String updateDetailsResponseModelToJson(UpdateDetailsResponseModel data) =>
    json.encode(data.toJson());

class UpdateDetailsResponseModel {
  String? message;
  String? userId;
  String? name;
  String? gender;
  String? dob;
  String? smokerType;
  String? height;
  String? weight;
  String? success;

  UpdateDetailsResponseModel({
    this.message,
    this.userId,
    this.name,
    this.gender,
    this.dob,
    this.smokerType,
    this.height,
    this.weight,
    this.success,
  });

  factory UpdateDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateDetailsResponseModel(
        message: UtilMethods.stringParser(json["message"]),
        userId: UtilMethods.stringParser(json["userId"]),
        name: UtilMethods.stringParser(json["name"]),
        gender: UtilMethods.stringParser(json["gender"]),
        dob: UtilMethods.stringParser(json["dob"]),
        smokerType: UtilMethods.stringParser(json["smokerType"]),
        height: UtilMethods.stringParser(json["height"]),
        weight: UtilMethods.stringParser(json["weight"]),
        success: UtilMethods.stringParser(json["success"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "userId": userId,
    "name": name,
    "gender": gender,
    "dob": dob,
    "smokerType": smokerType,
    "height": height,
    "weight": weight,
    "success": success,
  };
}
