// To parse this JSON data, do
//
//     final medicalQuestionListModel = medicalQuestionListModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

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
        message: UtilMethods.stringParser(json["message"]),
        list:
            json["list"] == null
                ? []
                : List<MedicalQuestionListModel>.from(
                  json["list"].map((x) => MedicalQuestionListModel.fromJson(x)),
                ),
        isSuccess: json["success"],
      );
}

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
        id: UtilMethods.stringParser(json["id"]),
        onBoardingQuestionName: UtilMethods.stringParser(
          json["onBoardingQuestionName"],
        ),
        onBoardingOptions:
            json["onBoardingOptions"] == null
                ? []
                : List<String>.from(json["onBoardingOptions"].map((x) => x)),
        answer: UtilMethods.stringParser(json["answer"]),
      );
}
