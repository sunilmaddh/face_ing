// To parse this JSON data, do
//
//     final userHistoryListModel = userHistoryListModelFromJson(jsonString);

import 'dart:convert';

UserHistoryListModel userHistoryListModelFromJson(String str) =>
    UserHistoryListModel.fromJson(json.decode(str));

String userHistoryListModelToJson(UserHistoryListModel data) =>
    json.encode(data.toJson());

class UserHistoryListModel {
  String? msg;
  String? success;
  List<UserHealthList>? userHealthList;

  UserHistoryListModel({this.msg, this.success, this.userHealthList});

  factory UserHistoryListModel.fromJson(Map<String, dynamic> json) =>
      UserHistoryListModel(
        msg: json["msg"] ?? "",
        success: json["success"] ?? "",
        userHealthList:
            json["userHealthList"] != null
                ? List<UserHealthList>.from(
                  json["userHealthList"].map((x) => UserHealthList.fromJson(x)),
                )
                : [],
      );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
    "userHealthList": List<dynamic>.from(
      userHealthList!.map((x) => x.toJson()),
    ),
  };
}

class UserHealthList {
  String? scanId;
  String? dateOfScan;

  UserHealthList({this.scanId, this.dateOfScan});

  factory UserHealthList.fromJson(Map<String, dynamic> json) => UserHealthList(
    scanId: json["scanId"] ?? "",
    dateOfScan: json["dateOfScan"] ?? "",
  );

  Map<String, dynamic> toJson() => {"scanId": scanId, "dateOfScan": dateOfScan};
}
