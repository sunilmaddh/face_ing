// To parse this JSON data, do
//
//     final vitalGraphResponseModel = vitalGraphResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

// import 'package:ntt_data/core/utils/utils_methods.dart';

// VitalGraphResponseModel vitalGraphResponseModelFromJson(String str) =>
//     VitalGraphResponseModel.fromJson(json.decode(str));

// class VitalGraphResponseModel {
//   String? dateRange;
//   AdvancedHeartRateVariability? wellness;
//   AdvancedHeartRateVariability? vitalSigns;
//   AdvancedHeartRateVariability? bloodlessBloodTests;
//   AdvancedHeartRateVariability? risks;
//   AdvancedHeartRateVariability? stress;
//   AdvancedHeartRateVariability? hrvSddnn;
//   AdvancedHeartRateVariability? advancedHeartRateVariability;

//   VitalGraphResponseModel({
//     this.dateRange,
//     this.wellness,
//     this.vitalSigns,
//     this.bloodlessBloodTests,
//     this.risks,
//     this.stress,
//     this.hrvSddnn,
//     this.advancedHeartRateVariability,
//   });
//   factory VitalGraphResponseModel.fromJson(Map<String, dynamic> json) =>
//       VitalGraphResponseModel(
//         dateRange: UtilMethods.stringParser(json["dateRange"]),
//         wellness: AdvancedHeartRateVariability.fromJson(json["wellness"]),
//         vitalSigns: AdvancedHeartRateVariability.fromJson(json["vitalSigns"]),
//         bloodlessBloodTests: AdvancedHeartRateVariability.fromJson(
//           json["bloodlessBloodTests"],
//         ),
//         risks: AdvancedHeartRateVariability.fromJson(json["risks"]),
//         stress: AdvancedHeartRateVariability.fromJson(json["stress"]),
//         hrvSddnn: AdvancedHeartRateVariability.fromJson(json["hrvSddnn"]),
//         advancedHeartRateVariability: AdvancedHeartRateVariability.fromJson(
//           json["advancedHeartRateVariability"],
//         ),
//       );
// }

// class AdvancedHeartRateVariability {
//   List<String>? vitalType;
//   List<VitalTypeDetail>? vitalTypeDetails;
//   AdvancedHeartRateVariability({this.vitalType, this.vitalTypeDetails});

//   factory AdvancedHeartRateVariability.fromJson(Map<String, dynamic> json) =>
//       AdvancedHeartRateVariability(
//         vitalType:
//             json["vitalType"] == null
//                 ? []
//                 : List<String>.from(json["vitalType"].map((x) => x)),
//         vitalTypeDetails:
//             json["vitalTypeDetails"] == null
//                 ? []
//                 : List<VitalTypeDetail>.from(
//                   json["vitalTypeDetails"].map(
//                     (x) => VitalTypeDetail.fromJson(x),
//                   ),
//                 ),
//       );
// }

// class VitalTypeDetail {
//   List<String> xValues;
//   List<HealthList> healthList;
//   List<String> yValues;

//   VitalTypeDetail({
//     required this.xValues,
//     required this.healthList,
//     required this.yValues,
//   });

//   factory VitalTypeDetail.fromJson(Map<String, dynamic> json) =>
//       VitalTypeDetail(
//         xValues:
//             json["xValues"] == null
//                 ? []
//                 : List<String>.from(json["xValues"].map((x) => x)),
//         healthList:
//             json["healthList"] == null
//                 ? []
//                 : List<HealthList>.from(
//                   json["healthList"].map((x) => HealthList.fromJson(x)),
//                 ),
//         yValues:
//             json["yValues"] == null
//                 ? []
//                 : List<String>.from(json["yValues"].map((x) => x)),
//       );
// }

// class HealthList {
//   String? value;
//   String? scannedDate;
//   String? status;
//   String? isTypeVital;
//   List<String>? vitalType = [];
//   HealthList({
//     this.value,
//     this.scannedDate,
//     this.status,
//     this.isTypeVital,
//     this.vitalType,
//   });

//   factory HealthList.fromJson(Map<String, dynamic> json) => HealthList(
//     value: UtilMethods.stringParser(json["value"]),
//     scannedDate: UtilMethods.stringParser(json["scannedDate"]),
//     status: UtilMethods.stringParser(json["status"]),
//     isTypeVital: UtilMethods.stringParser(json["isTypeVital"]),
//   );
// }

// To parse this JSON data, do
//
//     final vitalGraphResponseModel = vitalGraphResponseModelFromJson(jsonString);

VitalGraphResponseModel vitalGraphResponseModelFromJson(String str) =>
    VitalGraphResponseModel.fromJson(json.decode(str));

// String vitalGraphResponseModelToJson(VitalGraphResponseModel data) =>
//     json.encode(data.toJson());

class VitalGraphResponseModel {
  String? dateRange;
  AdvancedHeartRateVariability? wellness;
  AdvancedHeartRateVariability? vitalSigns;
  AdvancedHeartRateVariability? bloodlessBloodTests;
  AdvancedHeartRateVariability? risks;
  AdvancedHeartRateVariability? stress;
  AdvancedHeartRateVariability? hrvSddnn;
  AdvancedHeartRateVariability? advancedHeartRateVariability;
  String? success;
  String? msg;

  VitalGraphResponseModel({
    this.dateRange,
    this.wellness,
    this.vitalSigns,
    this.bloodlessBloodTests,
    this.risks,
    this.stress,
    this.hrvSddnn,
    this.advancedHeartRateVariability,
    this.success,
    this.msg,
  });

  factory VitalGraphResponseModel.fromJson(Map<String, dynamic> json) =>
      VitalGraphResponseModel(
        dateRange: UtilMethods.stringParser(json["dateRange"]),
        wellness:
            json["wellness"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(json["wellness"]),
        vitalSigns: AdvancedHeartRateVariability.fromJson(json["vitalSigns"]),
        bloodlessBloodTests:
            json["bloodlessBloodTests"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(
                  json["bloodlessBloodTests"],
                ),
        risks:
            json["risks"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(json["risks"]),
        stress:
            json["stress"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(json["stress"]),
        hrvSddnn:
            json["hrvSddnn"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(json["hrvSddnn"]),
        advancedHeartRateVariability:
            json["advancedHeartRateVariability"] == null
                ? AdvancedHeartRateVariability()
                : AdvancedHeartRateVariability.fromJson(
                  json["advancedHeartRateVariability"],
                ),
        success: UtilMethods.stringParser(json["success"]),
        msg: UtilMethods.stringParser(json["msg"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "dateRange": dateRange,
  //   "wellness": wellness.toJson(),
  //   "vitalSigns": vitalSigns.toJson(),
  //   "bloodlessBloodTests": bloodlessBloodTests.toJson(),
  //   "risks": risks.toJson(),
  //   "stress": stress.toJson(),
  //   "hrvSddnn": hrvSddnn.toJson(),
  //   "advancedHeartRateVariability": advancedHeartRateVariability.toJson(),
  //   "success": success,
  //   "msg": msg,
  // };
}

class AdvancedHeartRateVariability {
  List<VitalTypeDetail>? vitalTypeDetails;
  AdvancedHeartRateVariability({this.vitalTypeDetails});
  factory AdvancedHeartRateVariability.fromJson(Map<String, dynamic> json) =>
      AdvancedHeartRateVariability(
        vitalTypeDetails:
            json["vitalTypeDetails"] == null
                ? []
                : List<VitalTypeDetail>.from(
                  json["vitalTypeDetails"].map(
                    (x) => VitalTypeDetail.fromJson(x),
                  ),
                ),
      );

  // Map<String, dynamic> toJson() => {
  //   "vitalTypeDetails": List<dynamic>.from(
  //     vitalTypeDetails.map((x) => x.toJson()),
  //   ),
  // };
}

class VitalTypeDetail {
  List<String>? xValues;
  String? vitalName;
  String? vitalValue;
  String? vitalUnit;
  String? vitalMaxValue;
  List<String>? vitalStatusList;
  List<String>? vitalRange;
  String? vitalAvgValue;
  List<HealthList>? healthList;
  List<String>? yValues;

  VitalTypeDetail({
    this.xValues,
    this.vitalName,
    this.vitalValue,
    this.vitalMaxValue,
    this.vitalUnit,
    this.vitalStatusList,
    this.vitalRange,
    this.vitalAvgValue,
    this.healthList,
    this.yValues,
  });

  factory VitalTypeDetail.fromJson(Map<String, dynamic> json) =>
      VitalTypeDetail(
        xValues:
            json["xValues"] == null
                ? []
                : List<String>.from(json["xValues"].map((x) => x)),
        vitalName: UtilMethods.stringParser(json["vitalName"]),
        vitalValue: UtilMethods.stringParser(json["vitalValue"]),
        vitalUnit: UtilMethods.stringParser(json["vitalUnit"]),
        vitalStatusList:
            json["vitalStatusList"] == null
                ? []
                : List<String>.from(json["vitalStatusList"].map((x) => x)),
        vitalRange:
            json["vitalRange"] == null
                ? []
                : List<String>.from(json["vitalRange"].map((x) => x)),
        vitalAvgValue: UtilMethods.stringParser(json["vitalAvgValue"]),
        healthList:
            json["healthList"] == null
                ? []
                : List<HealthList>.from(
                  json["healthList"].map((x) => HealthList.fromJson(x)),
                ),
        vitalMaxValue: UtilMethods.stringParser(json["vitalMaxValue"]),
        yValues:
            json["yValues"] == null
                ? []
                : List<String>.from(json["yValues"].map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //     "xValues": List<dynamic>.from(xValues.map((x) => x)),
  //     "vitalName": vitalName,
  //     "vitalValue": vitalValue,
  //     "vitalUnit": vitalUnit,
  //     "vitalStatusList": List<dynamic>.from(vitalStatusList.map((x) => x)),
  //     "vitalRange": List<dynamic>.from(vitalRange.map((x) => x)),
  //     "vitalAvgValue": vitalAvgValue,
  //     "healthList": List<dynamic>.from(healthList.map((x) => x.toJson())),
  //     "yValues": List<dynamic>.from(yValues.map((x) => x)),
  // };
}

class HealthList {
  String? value;
  String? scannedDate;
  String? status;
  String? isTypeVital;
  String? vitalType;
  HealthList({
    this.value,
    this.scannedDate,
    this.status,
    this.isTypeVital,
    this.vitalType,
  });

  factory HealthList.fromJson(Map<String, dynamic> json) => HealthList(
    value: UtilMethods.stringParser(json["value"]),
    scannedDate: UtilMethods.stringParser(json["scannedDate"]),
    status: UtilMethods.stringParser(json["status"]),
    isTypeVital: UtilMethods.stringParser(json["isTypeVital"]),
  );
}
