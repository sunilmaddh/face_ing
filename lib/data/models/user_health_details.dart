// To parse this JSON data, do
//
//     final guestHistoryDetailsModel = guestHistoryDetailsModelFromJson(jsonString??);

import 'dart:convert';

UserHistoryDetailsModel userHistoryDetailsModelFromJson(String str) =>
    UserHistoryDetailsModel.fromJson(json.decode(str));

class UserHistoryDetailsModel {
  String? msg;

  UserHealthAnuraHistory? userHealthAnuraHistory;
  UserHealthBinahHistory? userHealthBinahHistory;
  String? success;

  UserHistoryDetailsModel({
    this.msg,

    this.userHealthAnuraHistory,
    this.userHealthBinahHistory,
    this.success,
  });

  factory UserHistoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserHistoryDetailsModel(
        msg: json["msg"] ?? "",

        userHealthAnuraHistory:
            json["userHealthAnuraHistory"] != null
                ? UserHealthAnuraHistory.fromJson(
                  json["userHealthAnuraHistory"],
                )
                : UserHealthAnuraHistory(),
        userHealthBinahHistory:
            json["userHealthBinahDetail"] != null
                ? UserHealthBinahHistory.fromJson(json["userHealthBinahDetail"])
                : UserHealthBinahHistory(),
        success: json["success"] ?? "",
      );
}

class UserHealthAnuraHistory {
  String? userEmail;
  String? age;
  String? hRbpm;
  String? bPSystolic;
  String? hRvsdnn;
  String? bPrpp;
  String? bPTau;
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
  String? bRbpm;
  String? bpDiastolic;
  String? iHbCount;
  String? hBa1CRiskProb;
  String? mFbgRiskProb;
  String? dBtRiskProb;
  String? fLdRiskProb;
  String? hDltcRiskProb;
  String? hPtRiskProb;
  String? overallMetabolicRiskProb;
  String? tGRiskProb;
  String? physioScore;

  UserHealthAnuraHistory({
    this.userEmail,
    this.age,
    this.hRbpm,
    this.bPSystolic,
    this.hRvsdnn,
    this.bPrpp,
    this.bPTau,
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
    this.bRbpm,
    this.bpDiastolic,
    this.iHbCount,
    this.hBa1CRiskProb,
    this.mFbgRiskProb,
    this.dBtRiskProb,
    this.fLdRiskProb,
    this.hDltcRiskProb,
    this.hPtRiskProb,
    this.overallMetabolicRiskProb,
    this.tGRiskProb,
    this.physioScore,
  });

  factory UserHealthAnuraHistory.fromJson(Map<String, dynamic> json) =>
      UserHealthAnuraHistory(
        userEmail: json["userEmail"] ?? "",
        age: json["age"] ?? "",
        hRbpm: json["hRBPM"] ?? "",
        bPSystolic: json["bPSystolic"] ?? "",
        hRvsdnn: json["hRVSDNN"] ?? "",
        bPrpp: json["bPRPP"] ?? "",
        bPTau: json["bPTau"] ?? "",
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
        bRbpm: json["bRBPM"] ?? "",
        bpDiastolic: json["bpDiastolic"] ?? "",
        iHbCount: json["iHBCount"] ?? "",
        hBa1CRiskProb: json["hBA1CRiskProb"] ?? "",
        mFbgRiskProb: json["mFBGRiskProb"] ?? "",
        dBtRiskProb: json["dBTRiskProb"] ?? "",
        fLdRiskProb: json["fLDRiskProb"] ?? "",
        hDltcRiskProb: json["hDLTCRiskProb"] ?? "",
        hPtRiskProb: json["hPTRiskProb"] ?? "",
        overallMetabolicRiskProb: json["overallMetabolicRiskProb"] ?? "",
        tGRiskProb: json["tGRiskProb"] ?? "",
        physioScore: json["physioScore"] ?? "",
      );
}

class UserHealthBinahHistory {
  String? userEmail;
  String? pulseRate;
  String? respirationRate;
  String? oxygenSaturation;
  String? sdnn;
  String? stressLevel;
  // String? rri;
  String? bloodPressure;
  String? stressIndex;
  String? meanRri;
  String? rmssd;
  String? sd1;
  String? sd2;
  String? prq;
  String? pnsIndex;
  String? pnsZone;
  String? snsIndex;
  String? snsZone;
  String? wellnessIndex;
  String? wellnessLevel;
  String? lfhf;
  String? hemoglobin;
  String? hemoglobinA1C;
  String? highHemoglobinA1CRisk;
  String? highBloodPressureRisk;
  String? ascvdRisk;
  String? normalizedStressIndex;
  String? heartAge;
  String? highTotalCholesterolRisk;
  String? highFastingGlucoseRisk;
  String? lowHemoglobinRisk;

  UserHealthBinahHistory({
    this.userEmail,
    this.pulseRate,
    this.respirationRate,
    this.oxygenSaturation,
    this.sdnn,
    this.stressLevel,
    // this.rri,
    this.bloodPressure,
    this.stressIndex,
    this.meanRri,
    this.rmssd,
    this.sd1,
    this.sd2,
    this.prq,
    this.pnsIndex,
    this.pnsZone,
    this.snsIndex,
    this.snsZone,
    this.wellnessIndex,
    this.wellnessLevel,
    this.lfhf,
    this.hemoglobin,
    this.hemoglobinA1C,
    this.highHemoglobinA1CRisk,
    this.highBloodPressureRisk,
    this.ascvdRisk,
    this.normalizedStressIndex,
    this.heartAge,
    this.highTotalCholesterolRisk,
    this.highFastingGlucoseRisk,
    this.lowHemoglobinRisk,
  });

  factory UserHealthBinahHistory.fromJson(Map<String, dynamic> json) =>
      UserHealthBinahHistory(
        userEmail: json["userEmail"] ?? "",
        pulseRate: json["pulseRate"] ?? "",
        respirationRate: json["respirationRate"] ?? "",
        oxygenSaturation: json["oxygenSaturation"] ?? "",
        sdnn: json["sdnn"] ?? "",
        stressLevel: json["stressLevel"] ?? "",
        // rri: json["rri"] ?? "",
        bloodPressure: json["bloodPressure"] ?? "",
        stressIndex: json["stressIndex"] ?? "",
        meanRri: json["meanRri"] ?? "",
        rmssd: json["rmssd"] ?? "",
        sd1: json["sd1"] ?? "",
        sd2: json["sd2"] ?? "",
        prq: json["prq"] ?? "",
        pnsIndex: json["pnsIndex"] ?? "",
        pnsZone: json["pnsZone"] ?? "",
        snsIndex: json["snsIndex"] ?? "",
        snsZone: json["snsZone"] ?? "",
        wellnessIndex: json["wellnessIndex"] ?? "",
        wellnessLevel: json["wellnessLevel"] ?? "",
        lfhf: json["lfhf"] ?? "",
        hemoglobin: json["hemoglobin"] ?? "",
        hemoglobinA1C: json["hemoglobinA1C"] ?? "",
        highHemoglobinA1CRisk: json["highHemoglobinA1CRisk"] ?? "",
        highBloodPressureRisk: json["highBloodPressureRisk"] ?? "",
        ascvdRisk: json["ascvdRisk"] ?? "",
        normalizedStressIndex: json["normalizedStressIndex"] ?? "",
        heartAge: json["heartAge"] ?? "",
        highTotalCholesterolRisk: json["highTotalCholesterolRisk"] ?? "",
        highFastingGlucoseRisk: json["highFastingGlucoseRisk"] ?? "",
        lowHemoglobinRisk: json["lowHemoglobinRisk"] ?? "",
      );
}
