import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_graph_status.dart';

class PulseHelper {
  static const List<Map<String, dynamic>> pulseServeQuestionList = [
    {
      "id": "1",
      "question": "How is your work pace?",
      "option_list": ["Excellent", "Good", "Fine", "Tough"],
    },
    {
      "id": "2",
      "question": "How is your workload?",
      "option_list": ["Excellent", "Good", "Fine", "Tough"],
    },
    {
      "id": "3",
      "question": "How are your relationships with your colleagues?",
      "option_list": ["Excellent", "Good", "Fine", "Tough"],
    },
    {
      "id": "4",
      "question": "How satisfied  are you with your job?",
      "option_list": ["Excellent", "Good", "Fine", "Tough"],
    },
    {
      "id": "5",
      "question": "How are you  sleeping and eating well?",
      "option_list": ["Excellent", "Good", "Fine", "Tough"],
    },
  ];

  static const List<Map<String, dynamic>> pulseStatus = [
    {"value": "Workload", "image": AppAssets.sunAsset},
    {"value": "Relationship", "image": AppAssets.rainAsset},
    {"value": "Sleep & Eat", "image": AppAssets.sunAsset},
    {"value": "Workpace", "image": AppAssets.cloudAsset},
    {"value": "Satisfaction", "image": AppAssets.stromAsset},
  ];

  static const Map<String, dynamic> lineChart = {
    "xValues": ["04", "05", "06", "07", "08", "09", "10"],
    "vitalName": "Wellness Score",
    "vitalValue": "3",
    "vitalUnit": "",
    "vitalStatusList": ["Low", "Medium", "High"],
    "vitalRange": ["5", "7"],
    "vitalAvgValue": "4",
    "healthList": [
      {
        "value": "3",
        "scannedDate": "2025-10-09 09:50:11",
        "status": "Low",
        "isTypeVital": "true",
      },
      {
        "value": "8",
        "scannedDate": "2025-10-07 12:10:03",
        "status": "High",
        "isTypeVital": "true",
      },
      {
        "value": "2",
        "scannedDate": "2025-10-06 10:12:56",
        "status": "Low",
        "isTypeVital": "true",
      },
    ],
    "yValues": ["0.0", "5.0", "10.0"],
    "vitalMaxValue": "10",
  };

  static List statusList = [
    StatusListColor(status: "Excellent", color: Color(0xff00C648)),
    StatusListColor(status: "Good", color: Color(0xff1BC76D)),
    StatusListColor(status: "Fine", color: Color(0xffEEC000)),
    StatusListColor(status: "Tough", color: Color(0xffFA704E)),
  ];
}
