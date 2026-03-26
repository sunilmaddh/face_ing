// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

String addGeustRequestModelToJson(AddGeustRequestModel data) =>
    json.encode(data.toJson());

class AddGeustRequestModel {
  GuestDao guestDao;
  AnuraDetails anuraDetails;
  BinahDetails binahDetails;

  AddGeustRequestModel({
    required this.guestDao,
    required this.anuraDetails,
    required this.binahDetails,
  });

  Map<String, dynamic> toJson() => {
    "guestDao": guestDao.toJson(),
    "anuraDetails": anuraDetails.toJson(),
    "binahDetails": binahDetails.toJson(),
  };
}

class AnuraDetails {
  int age;
  String gender;
  String height;
  String waistCircum;
  String bMiCalc;
  String aBsi;
  String hRbpm;
  String bPSystolic;
  String hRvsdnn;
  String bPrpp;
  String bPTau;
  String bPbpm;
  String tHbCount;
  String healthScore;
  String mentalScore;
  String vitalScore;
  String physicalScore;
  String mSi;
  String bpHeartAttack;
  String bPStroke;
  String bPcvd;
  String risksScore;
  String sNr;

  AnuraDetails({
    required this.age,
    required this.gender,
    required this.height,
    required this.waistCircum,
    required this.bMiCalc,
    required this.aBsi,
    required this.hRbpm,
    required this.bPSystolic,
    required this.hRvsdnn,
    required this.bPrpp,
    required this.bPTau,
    required this.bPbpm,
    required this.tHbCount,
    required this.healthScore,
    required this.mentalScore,
    required this.vitalScore,
    required this.physicalScore,
    required this.mSi,
    required this.bpHeartAttack,
    required this.bPStroke,
    required this.bPcvd,
    required this.risksScore,
    required this.sNr,
  });

  Map<String, dynamic> toJson() => {
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

class BinahDetails {
  int pulseRate;
  String respirationRate;
  String oxygenSaturation;
  String sdnn;
  String stressLevel;
  String rri;
  String bloodPressure;
  String stressIndex;
  String meanRri;
  String rmssd;
  String sd1;
  String sd2;
  String prq;
  String pnsIndex;
  String pnsZone;
  String snsIndex;
  String snsZone;
  String wellnessIndex;
  String wellnessLevel;
  String lfhf;
  String hemoglobin;
  String hemoglobinA1C;
  String highHemoglobinA1CRisk;
  String highBloodPressureRisk;
  String ascvdRisk;
  String normalizedStressIndex;
  String heartAge;
  String highTotalCholesterolRisk;
  String highFastingGlucoseRisk;
  int lowHemoglobinRisk;

  BinahDetails({
    required this.pulseRate,
    required this.respirationRate,
    required this.oxygenSaturation,
    required this.sdnn,
    required this.stressLevel,
    required this.rri,
    required this.bloodPressure,
    required this.stressIndex,
    required this.meanRri,
    required this.rmssd,
    required this.sd1,
    required this.sd2,
    required this.prq,
    required this.pnsIndex,
    required this.pnsZone,
    required this.snsIndex,
    required this.snsZone,
    required this.wellnessIndex,
    required this.wellnessLevel,
    required this.lfhf,
    required this.hemoglobin,
    required this.hemoglobinA1C,
    required this.highHemoglobinA1CRisk,
    required this.highBloodPressureRisk,
    required this.ascvdRisk,
    required this.normalizedStressIndex,
    required this.heartAge,
    required this.highTotalCholesterolRisk,
    required this.highFastingGlucoseRisk,
    required this.lowHemoglobinRisk,
  });

  Map<String, dynamic> toJson() => {
    "pulseRate": pulseRate,
    "respirationRate": respirationRate,
    "oxygenSaturation": oxygenSaturation,
    "sdnn": sdnn,
    "stressLevel": stressLevel,
    "rri": rri,
    "bloodPressure": bloodPressure,
    "stressIndex": stressIndex,
    "meanRri": meanRri,
    "rmssd": rmssd,
    "sd1": sd1,
    "sd2": sd2,
    "prq": prq,
    "pnsIndex": pnsIndex,
    "pnsZone": pnsZone,
    "snsIndex": snsIndex,
    "snsZone": snsZone,
    "wellnessIndex": wellnessIndex,
    "wellnessLevel": wellnessLevel,
    "lfhf": lfhf,
    "hemoglobin": hemoglobin,
    "hemoglobinA1C": hemoglobinA1C,
    "highHemoglobinA1CRisk": highHemoglobinA1CRisk,
    "highBloodPressureRisk": highBloodPressureRisk,
    "ascvdRisk": ascvdRisk,
    "normalizedStressIndex": normalizedStressIndex,
    "heartAge": heartAge,
    "highTotalCholesterolRisk": highTotalCholesterolRisk,
    "highFastingGlucoseRisk": highFastingGlucoseRisk,
    "lowHemoglobinRisk": lowHemoglobinRisk,
  };
}

class GuestDao {
  String userId;
  String email;
  String name;
  String gender;
  String dob;
  String weight;
  String height;
  String image;

  GuestDao({
    required this.userId,
    required this.email,
    required this.name,
    required this.gender,
    required this.dob,
    required this.weight,
    required this.height,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "name": name,
    "gender": gender,
    "dob": dob,
    "weight": weight,
    "height": height,
    "image": image,
  };
}
