// To parse this JSON data, do
//
//     final anlyzeHealthDataResponseModel = anlyzeHealthDataResponseModelFromJson(jsonString);

import 'dart:convert';

AnlyzeHealthDataResponseModel anlyzeHealthDataResponseModelFromJson(
  String str,
) => AnlyzeHealthDataResponseModel.fromJson(json.decode(str));

class AnlyzeHealthDataResponseModel {
  Map<String, Channel>? channels;

  AnlyzeHealthDataResponseModel({this.channels});

  factory AnlyzeHealthDataResponseModel.fromJson(Map<String, dynamic> json) =>
      AnlyzeHealthDataResponseModel(
        channels:
            json["channels"] != null
                ? Map.from(json["channels"]).map(
                  (k, v) => MapEntry<String, Channel>(k, Channel.fromJson(v)),
                )
                : {},
      );
}

class Channel {
  List<double>? dataList;
  List<String>? notes;

  Channel({required this.dataList, required this.notes});

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    dataList:
        json["dataList"] != null
            ? List<double>.from(json["dataList"].map((x) => x.toDouble()))
            : [],
    notes:
        json["notes"] == null
            ? []
            : List<String>.from(json["notes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {"dataList": dataList, "notes": notes};
}
