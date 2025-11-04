// To parse this JSON data, do
//
//     final pulseSurveyQuestionListModel = pulseSurveyQuestionListModelFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

PulseSurveyQuestionListModel pulseSurveyQuestionListModelFromJson(String str) =>
    PulseSurveyQuestionListModel.fromJson(json.decode(str));

// String pulseSurveyQuestionListModelToJson(PulseSurveyQuestionListModel data) => json.encode(data.toJson());

class PulseSurveyQuestionListModel {
  List<Question>? questions;
  String? msg;
  String? success;

  PulseSurveyQuestionListModel({this.questions, this.msg, this.success});

  factory PulseSurveyQuestionListModel.fromJson(Map<String, dynamic> json) =>
      PulseSurveyQuestionListModel(
        questions:
            json["Questions"] == null
                ? []
                : List<Question>.from(
                  json["Questions"].map((x) => Question.fromJson(x)),
                ),
        msg: UtilMethods.stringParser(json["msg"]),
        success: UtilMethods.stringParser(json["success"]),
      );
}

class Question {
  String? questionId;
  String? pulseSurveyQuestion;
  String? pulseSurveyQuestionTitle;
  List<String>? pulseSurveyAnswerOptions;
  String? answer;

  Question({
    this.questionId,
    this.pulseSurveyQuestion,
    this.pulseSurveyQuestionTitle,
    this.pulseSurveyAnswerOptions,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: UtilMethods.stringParser(json["questionId"]),
    pulseSurveyQuestion: UtilMethods.stringParser(json["pulseSurveyQuestion"]),
    pulseSurveyQuestionTitle: UtilMethods.stringParser(
      json["pulseSurveyQuestionTitle"],
    ),
    pulseSurveyAnswerOptions:
        json["pulseSurveyAnswerOptions"] == null
            ? []
            : List<String>.from(json["pulseSurveyAnswerOptions"].map((x) => x)),
    answer: UtilMethods.stringParser(json["answer"]),
  );

  // Map<String, dynamic> toJson() => {
  //     "questionId": questionId,
  //     "pulseSurveyQuestion": pulseSurveyQuestion,
  //     "pulseSurveyQuestionTitle": pulseSurveyQuestionTitle,
  //     "pulseSurveyAnswerOptions": List<dynamic>.from(pulseSurveyAnswerOptions.map((x) => x)),
  //     "answer": answer,
  // };
}
