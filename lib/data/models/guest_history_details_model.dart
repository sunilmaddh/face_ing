// To parse this JSON data, do
//
//     final guestHistoryDetailsModel = guestHistoryDetailsModelFromJson(jsonString?);

import 'dart:convert';

GuestHistoryDetailsModel guestHistoryDetailsModelFromJson(String? str) =>
    GuestHistoryDetailsModel.fromJson(json.decode(str!));

String? guestHistoryDetailsModelToJson(GuestHistoryDetailsModel data) =>
    json.encode(data.toJson());

class GuestHistoryDetailsModel {
  String? msg;
  GuestPersonalDetail? guestPersonalDetail;
  GuestHealthAnuraHistory? guestHealthAnuraHistory;
  dynamic guestHealthBinahHistory;
  String? success;

  GuestHistoryDetailsModel({
    this.msg,
    this.guestPersonalDetail,
    this.guestHealthAnuraHistory,
    this.guestHealthBinahHistory,
    this.success,
  });

  factory GuestHistoryDetailsModel.fromJson(Map<String?, dynamic> json) =>
      GuestHistoryDetailsModel(
        msg: json["msg"] ?? "",
        guestPersonalDetail:
            json["guestPersonalDetail"] != null
                ? GuestPersonalDetail.fromJson(json["guestPersonalDetail"])
                : GuestPersonalDetail(),
        guestHealthAnuraHistory:
            json["guestHealthAnuraHistory"] != null
                ? GuestHealthAnuraHistory.fromJson(
                  json["guestHealthAnuraHistory"],
                )
                : GuestHealthAnuraHistory(),
        guestHealthBinahHistory: json["guestHealthBinahHistory"] ?? "",
        success: json["success"] ?? "",
      );

  Map<String?, dynamic> toJson() => {
    "msg": msg,
    "guestPersonalDetail": guestPersonalDetail!.toJson(),
    "guestHealthAnuraHistory": guestHealthAnuraHistory!.toJson(),
    "guestHealthBinahHistory": guestHealthBinahHistory,
    "success": success,
  };
}

class GuestHealthAnuraHistory {
  dynamic userEmail;
  String? age;
  String? gender;
  String? height;
  String? waistCircum;
  String? bMiCalc;
  String? aBsi;
  String? hRbpm;
  String? bPSystolic;
  String? hRvsdnn;
  String? bPrpp;
  String? bPTau;
  String? bPbpm;
  String? tHbCount;
  String? healthScore;
  String? mentalScore;
  String? vitalScore;
  String? physicalScore;
  String? mSi;
  String? bpHeartAttack;
  String? bPStroke;
  String? bPcvd;
  String? risksScore;
  String? sNr;

  GuestHealthAnuraHistory({
    this.userEmail,
    this.age,
    this.gender,
    this.height,
    this.waistCircum,
    this.bMiCalc,
    this.aBsi,
    this.hRbpm,
    this.bPSystolic,
    this.hRvsdnn,
    this.bPrpp,
    this.bPTau,
    this.bPbpm,
    this.tHbCount,
    this.healthScore,
    this.mentalScore,
    this.vitalScore,
    this.physicalScore,
    this.mSi,
    this.bpHeartAttack,
    this.bPStroke,
    this.bPcvd,
    this.risksScore,
    this.sNr,
  });

  factory GuestHealthAnuraHistory.fromJson(Map<String?, dynamic> json) =>
      GuestHealthAnuraHistory(
        userEmail: json["userEmail"] ?? "",
        age: json["age"] ?? "",
        gender: json["gender"] ?? "",
        height: json["height"] ?? "",
        waistCircum: json["waistCircum"] ?? "",
        bMiCalc: json["bMICalc"] ?? "",
        aBsi: json["aBSI"] ?? "",
        hRbpm: json["hRBPM"] ?? "",
        bPSystolic: json["bPSystolic"] ?? "",
        hRvsdnn: json["hRVSDNN"] ?? "",
        bPrpp: json["bPRPP"] ?? "",
        bPTau: json["bPTau"] ?? "",
        bPbpm: json["bPBPM"] ?? "",
        tHbCount: json["tHBCount"] ?? "",
        healthScore: json["healthScore"] ?? "",
        mentalScore: json["mentalScore"] ?? "",
        vitalScore: json["vitalScore"] ?? "",
        physicalScore: json["physicalScore"] ?? "",
        mSi: json["mSI"] ?? "",
        bpHeartAttack: json["bpHeartAttack"] ?? "",
        bPStroke: json["bPStroke"] ?? "",
        bPcvd: json["bPCVD"] ?? "",
        risksScore: json["risksScore"] ?? "",
        sNr: json["sNR"] ?? "",
      );

  Map<String?, dynamic> toJson() => {
    "userEmail": userEmail,
    "age": age,
    "gender": gender,
    "height": height,
    "waistCircum": waistCircum,
    "bMICalc": bMiCalc,
    "aBSI": aBsi,
    "hRBPM": hRbpm,
    "bPSystolic": bPSystolic,
    "hRVSDNN": hRvsdnn,
    "bPRPP": bPrpp,
    "bPTau": bPTau,
    "bPBPM": bPbpm,
    "tHBCount": tHbCount,
    "healthScore": healthScore,
    "mentalScore": mentalScore,
    "vitalScore": vitalScore,
    "physicalScore": physicalScore,
    "mSI": mSi,
    "bpHeartAttack": bpHeartAttack,
    "bPStroke": bPStroke,
    "bPCVD": bPcvd,
    "risksScore": risksScore,
    "sNR": sNr,
  };
}

class GuestPersonalDetail {
  String? email;
  String? name;
  String? gender;
  String? dob;
  String? weight;
  String? height;
  String? termCond;
  int? userId;
  String? guestId;
  String? scannedDate;
  String? age;

  GuestPersonalDetail({
    this.email,
    this.name,
    this.gender,
    this.dob,
    this.weight,
    this.height,
    this.termCond,

    this.userId,
    this.guestId,
    this.scannedDate,
    this.age,
  });

  factory GuestPersonalDetail.fromJson(Map<String?, dynamic> json) =>
      GuestPersonalDetail(
        email: json["email"] ?? "" ?? "",
        name: json["name"] ?? "" ?? "",
        gender: json["gender"] ?? "" ?? "",
        dob: json["dob"] ?? "" ?? "",
        weight: json["weight"] ?? "" ?? "",
        height: json["height"] ?? "" ?? "",
        termCond: json["termCond"] ?? "" ?? "",
        userId: json["userId"] ?? "" ?? 0,
        guestId: json["guestId"] ?? "" ?? "",
        scannedDate: json["scannedDate"] ?? "" ?? "",
        age: json["age"] ?? "" ?? "",
      );

  Map<String?, dynamic> toJson() => {
    "email": email,
    "name": name,
    "gender": gender,
    "dob": dob,
    "weight": weight,
    "height": height,
    "termCond": termCond,
    "userId": userId,
    "guestId": guestId,
    "scannedDate": scannedDate,
    "age": age,
  };
}
