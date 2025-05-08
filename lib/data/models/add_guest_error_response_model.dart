// To parse this JSON data, do
//
//     final addGuestErrorResponseModel = addGuestErrorResponseModelFromJson(jsonString);

import 'dart:convert';

AddGuestErrorResponseModel addGuestErrorResponseModelFromJson(String str) =>
    AddGuestErrorResponseModel.fromJson(json.decode(str));

String addGuestErrorResponseModelToJson(AddGuestErrorResponseModel data) =>
    json.encode(data.toJson());

class AddGuestErrorResponseModel {
  String? msg;
  String? success;

  AddGuestErrorResponseModel({this.msg, this.success});

  factory AddGuestErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      AddGuestErrorResponseModel(
        msg: json["msg"] ?? "",
        success: json["success"] ?? "",
      );

  Map<String, dynamic> toJson() => {"msg": msg, "success": success};
}
