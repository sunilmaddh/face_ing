// To parse this JSON data, do
//
//     final kintsigiQuestionariesResponse = kintsigiQuestionariesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ntt_data/core/utils/utils_methods.dart';

KintsigiQuestionariesResponse kintsigiQuestionariesResponseFromJson(
  String str,
) => KintsigiQuestionariesResponse.fromJson(json.decode(str));

class KintsigiQuestionariesResponse {
  String? success;
  String? msg;
  List<Questionnaire>? questionnaires;

  KintsigiQuestionariesResponse({this.success, this.msg, this.questionnaires});

  factory KintsigiQuestionariesResponse.fromJson(Map<String, dynamic> json) =>
      KintsigiQuestionariesResponse(
        success: UtilMethods.stringParser(json["success"]),
        msg: UtilMethods.stringParser(json["msg"]),
        questionnaires:
            json["questionnaires"] == null
                ? []
                : List<Questionnaire>.from(
                  json["questionnaires"].map((x) => Questionnaire.fromJson(x)),
                ),
      );
}

class Questionnaire {
  String? type;
  List<QuestionOfKintsugi>? questions;

  Questionnaire({required this.type, required this.questions});

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
    type: UtilMethods.stringParser(json["type"]),
    questions:
        json["questions"] == null
            ? []
            : List<QuestionOfKintsugi>.from(
              json["questions"].map((x) => QuestionOfKintsugi.fromJson(x)),
            ),
  );
}

class QuestionOfKintsugi {
  String? question;
  List<Option>? options;

  QuestionOfKintsugi({required this.question, required this.options});

  factory QuestionOfKintsugi.fromJson(Map<String, dynamic> json) =>
      QuestionOfKintsugi(
        question: UtilMethods.stringParser(json["question"]),
        options:
            json["options"] == null
                ? []
                : List<Option>.from(
                  json["options"].map((x) => Option.fromJson(x)),
                ),
      );
}

class Option {
  int? value;
  String? response;

  Option({required this.value, required this.response});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    value: UtilMethods.intParser(json["value"]),
    response: UtilMethods.stringParser(json["response"]),
  );
}
