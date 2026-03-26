// To parse this JSON data, do
//
//     final vitalDescriptionsModel = vitalDescriptionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

VitalDescriptionsModel vitalDescriptionsModelFromJson(String str) =>
    VitalDescriptionsModel.fromJson(json.decode(str));

String vitalDescriptionsModelToJson(VitalDescriptionsModel data) =>
    json.encode(data.toJson());

class VitalDescriptionsModel {
  String? msg;
  String? success;
  String? vitalDesc;

  VitalDescriptionsModel({this.msg, this.success, this.vitalDesc});

  factory VitalDescriptionsModel.fromJson(Map<String, dynamic> json) =>
      VitalDescriptionsModel(
        msg: UtilMethods.stringParser(json["msg"]),
        success: UtilMethods.stringParser(json["success"]),
        vitalDesc: UtilMethods.stringParser(json["vitalDesc"]),
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
    "vitalDesc": vitalDesc,
  };
}
