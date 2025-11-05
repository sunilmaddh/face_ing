import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';

class PulseHelper {
  String getImage(String status) {
    switch (status.toLowerCase()) {
      case "excellent":
        return AppAssets.sunAsset;
      case "good":
        return AppAssets.cloudSunny;
      case "normal":
        return AppAssets.cloudAsset;
      case "not good":
        return AppAssets.rain2;
      case "tough":
        return AppAssets.stromAsset;
      default:
        return "";
    }
  }

  Color getColor(String statusName) {
    final status = statusName.toLowerCase();
    switch (status) {
      case "excellent":
        return Color(0xff00C648);
      case "good":
        return Color(0xff1BC76D);
      case "not good":
        return Color(0xffEEC000);
      case "tough":
        return Color(0xffFA704E);
      default:
        return Colors.white;
    }
  }

  List<PulseSurveyList> normalizeHealthData(
    List<String> xValues,
    List<PulseSurveyList> healthList,
  ) {
    List<PulseSurveyList> normalizedList = [];

    for (String x in xValues) {
      // Convert "Today" to current day
      String dayString =
          (x == "Today") ? DateFormat("d").format(DateTime.now()) : x;

      int? dayNum = int.tryParse(dayString);
      if (dayNum == null) {
        // Invalid day, add empty
        normalizedList.add(
          PulseSurveyList(value: "", surveyDate: "", status: ""),
        );
        continue;
      }

      // Find any health data with matching day
      PulseSurveyList? match = healthList.firstWhere((h) {
        if (h.surveyDate == null || h.surveyDate!.isEmpty) return false;
        DateTime scannedDate = DateTime.parse(h.surveyDate!);
        return scannedDate.day == dayNum;
      }, orElse: () => PulseSurveyList(value: "", surveyDate: "", status: ""));

      normalizedList.add(match);
    }

    return normalizedList;
  }

  static String cleanRange(String input) {
    return input.replaceAll(RegExp(r'\s?20\d{2}'), '');
  }
}
