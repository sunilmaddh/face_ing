// To parse this JSON data, do
//
//     final guestListResponseModel = guestListResponseModelFromJson(jsonString);

import 'dart:convert';

GuestListResponseModel guestListResponseModelFromJson(String str) =>
    GuestListResponseModel.fromJson(json.decode(str));

// String guestListResponseModelToJson(GuestListResponseModel data) =>
//     json.encode(data.toJson());

class GuestListResponseModel {
  String? msg;
  int? userId;
  List<GuestList>? guestList;
  String? success;

  GuestListResponseModel({this.msg, this.userId, this.guestList, this.success});

  factory GuestListResponseModel.fromJson(Map<String, dynamic> json) =>
      GuestListResponseModel(
        msg: json["msg"] ?? "",
        userId: json["userId"] ?? 0,
        guestList:
            json["GuestList"] != null
                ? List<GuestList>.from(
                  json["GuestList"].map((x) => GuestList.fromJson(x)),
                )
                : [],
        success: json["success"],
      );
}

class GuestList {
  String? email;
  String? name;
  String? date;
  String? gender;
  String? age;
  String? weight;
  String? height;
  int? userId;
  String? guestId;
  String? dob;

  GuestList({
    this.email,
    this.name,
    this.date,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.userId,
    this.guestId,
    this.dob,
  });

  factory GuestList.fromJson(Map<String, dynamic> json) => GuestList(
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    date: json["date"] ?? "",
    gender: json["gender"] ?? "",
    age: json["age"] ?? "",
    weight: json["weight"] ?? "",
    height: json["height"] ?? "",

    userId: json["userId"] ?? 0,
    guestId: json["guestId"] ?? "",
    dob: json["dob"] ?? "",
  );

  // Map<String, dynamic> toJson() => {
  //   "email": email,
  //   "name": nameValues.reverse[name],
  //   "date": date,
  //   "gender": gender,
  //   "age": age,
  //   "weight": weight,
  //   "height": height,

  //   "userId": userId,
  //   "guestId": guestId,
  //   "dob": dobValues.reverse[dob],
  // };
}
