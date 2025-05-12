// To parse this JSON data, do
//
//     final medicalQuestionListModel = medicalQuestionListModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final medicalQuestionListModel = medicalQuestionListModelFromJson(jsonString);

MedicalQuestionModels medicalQuestionListModelFromJson(String str) =>
    MedicalQuestionModels.fromJson(json.decode(str));

class MedicalQuestionModels {
  String? message;
  List<MedicalQuestionListModel>? list;
  String? isSuccess;

  MedicalQuestionModels({this.message, this.list, this.isSuccess});

  factory MedicalQuestionModels.fromJson(Map<String, dynamic> json) =>
      MedicalQuestionModels(
        message: json["message"] ?? "",
        list:
            json["list"] == null
                ? []
                : List<MedicalQuestionListModel>.from(
                  json["list"].map((x) => MedicalQuestionListModel.fromJson(x)),
                ),
        isSuccess: json["isSuccess"],
      );
}

// class ListElement {
//   String id;
//   String onBoardingQuestionName;
//   List<String> onBoardingOptions;
//   dynamic answer;

//   ListElement({
//     required this.id,
//     required this.onBoardingQuestionName,
//     required this.onBoardingOptions,
//     required this.answer,
//   });

//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//     id: json["id"],
//     onBoardingQuestionName: json["onBoardingQuestionName"],
//     onBoardingOptions: List<String>.from(
//       json["onBoardingOptions"].map((x) => x),
//     ),
//     answer: json["answer"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "onBoardingQuestionName": onBoardingQuestionName,
//     "onBoardingOptions": List<dynamic>.from(onBoardingOptions.map((x) => x)),
//     "answer": answer,
//   };
// }

class MedicalQuestionListModel {
  String? id;
  String? onBoardingQuestionName;
  List<String>? onBoardingOptions;
  String? answer;

  MedicalQuestionListModel({
    this.id,
    this.onBoardingQuestionName,
    this.onBoardingOptions,
    this.answer,
  });

  factory MedicalQuestionListModel.fromJson(Map<String, dynamic> json) =>
      MedicalQuestionListModel(
        id: json["id"] ?? "",
        onBoardingQuestionName: json["onBoardingQuestionName"] ?? "",
        onBoardingOptions:
            json["onBoardingOptions"] == null
                ? []
                : List<String>.from(json["onBoardingOptions"].map((x) => x)),
        answer: json["answer"],
      );
}
