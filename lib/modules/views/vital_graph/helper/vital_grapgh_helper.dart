import 'package:flutter/material.dart';
import 'package:ntt_data/demo/vital_graph_widget.dart';

class VitalGraphHelper {
  // Main Tabs

  static const List<String> tabGraphTitles = [
    "Wellness",
    "Basic Vital Signs",
    "Bloodless Blood Tests",
    "Risks",
    "Stress",
    "Heart Rate Variability",
    "Advanced Heart Rate Variability",
  ];

  static const List<String> tabWellnessTitles = ["Wellness"];

  // Vital Signs Tabs
  static const List<String> tabVitalSignTitles = [
    "Breathing Rate",
    "Pulse Rate (Heart Rate)",
    "PRQ",
    "Blood Pressure",
    "Oxygen Saturation",
  ];

  // Bloodless Blood Tests Tabs
  static const List<String> tabBBTTitles = ["Hemoglobin", "Hemoglobin A1C"];

  // Risk Tabs
  static const List<String> tabRiskTitles = [
    "ASCVD Risk",
    "High Blood Pressure Risk",
    "High HbA1c Risk",
    "High Fasting Glucose Risk",
    "High Total Cholesterol Risk",
    "Low Hemoglobin Risk",
  ];

  // Stress Tabs
  static const List<String> tabStressTitles = ["Stress Level"];

  // HRV Basic Tabs
  static const List<String> tabHRBTitles = ["HRV SDNN"];

  // Advanced HRV Tabs
  static const List<String> tabAHRVTitles = [
    "PNS Zone",
    "PNS Index",
    "SNS Zone",
    "SNS Index",
    "SD1",
    "SD2",
    "LF/HF",
  ];

  // Widget Lists

  static final List<Widget> tabGraphWidgets =
      tabGraphTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabWellnessWidgets =
      tabWellnessTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabVitalSignWidgets =
      tabVitalSignTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabBBTWidgets =
      tabBBTTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabRiskWidgets =
      tabRiskTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabStressWidgets =
      tabStressTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabHRBWidgets =
      tabHRBTitles.map((title) => Tab(text: title)).toList();

  static final List<Widget> tabAHRVWidgets =
      tabAHRVTitles.map((title) => Tab(text: title)).toList();

  static List<Widget> tabBarWellnessWidget = List.generate(
    1,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBarVitalSignWidget = List.generate(
    5,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBarBloodlessWidget = List.generate(
    2,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBarRiskWidget = List.generate(
    6,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBarStressWidget = List.generate(
    1,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBaHRVWidget = List.generate(
    1,
    (_) => VitalGraphWidget(),
  );
  static List<Widget> tabBarHRVWidgets = List.generate(
    7,
    (_) => VitalGraphWidget(),
  );

  List<String> filterTypeList = ["1D", "7D", "Monthly"];
}
