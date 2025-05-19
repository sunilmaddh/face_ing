// To parse this JSON data, do
//
//     final uploadImageResponseModel = uploadImageResponseModelFromJson(jsonString);

import 'dart:convert';

UploadImageResponseModel uploadImageResponseModelFromJson(String str) =>
    UploadImageResponseModel.fromJson(json.decode(str));

String uploadImageResponseModelToJson(UploadImageResponseModel data) =>
    json.encode(data.toJson());

class UploadImageResponseModel {
  String? message;
  String? userId;
  String? success;
  String? imagePath;

  UploadImageResponseModel({
    this.message,
    this.userId,
    this.success,
    this.imagePath,
  });

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) =>
      UploadImageResponseModel(
        message: json["message"] ?? "",
        userId: json["userId"] ?? "",
        success: json["success"] ?? "",
        imagePath: json["imagePath"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "userId": userId,
    "success": success,
    "imagePath": imagePath,
  };
}
