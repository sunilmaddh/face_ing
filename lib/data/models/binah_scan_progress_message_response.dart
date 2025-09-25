// To parse this JSON data, do
//
//     final binahScanProgressMessageResponse = binahScanProgressMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

BinahScanProgressMessageResponse binahScanProgressMessageResponseFromJson(
  String str,
) => BinahScanProgressMessageResponse.fromJson(json.decode(str));

class BinahScanProgressMessageResponse {
  List<String>? scannedMessage;
  String? msg;
  String? success;

  BinahScanProgressMessageResponse({
    this.scannedMessage,
    this.msg,
    this.success,
  });

  factory BinahScanProgressMessageResponse.fromJson(
    Map<String, dynamic> json,
  ) => BinahScanProgressMessageResponse(
    scannedMessage:
        json["scannedMessage"] == null
            ? []
            : List<String>.from(json["scannedMessage"].map((x) => x)),
    msg: UtilMethods.stringParser(json["msg"]),
    success: UtilMethods.stringParser(json["success"]),
  );
}
