import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/demo/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';

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
  final _controller = Get.find<VitalGraphController>();
  Future<void> callVitalGraph(Map<String, dynamic> data) async {
    await _controller.callVitalGraphDataApi(data: data);
  }

  // 🔹 Common payload builder
  Map<String, dynamic> _buildPayload({
    required bool isUser,
    String? startDate,
    String? endDate,
    String? filterType,
    String? guestId,
  }) {
    final payload = <String, dynamic>{"userFlag": isUser.toString()};

    if (startDate != null && endDate != null) {
      payload["startDate"] = startDate;
      payload["endDate"] = endDate;
    }

    if (filterType != null) {
      payload["filterType"] = filterType;
    }

    if (!isUser && guestId != null) {
      payload["guestId"] = guestId;
    }

    return payload;
  }

  // 🔹 User API Calls
  Future<void> callForUserWithDateRange(
    String startDate,
    String endDate,
  ) async {
    final data = _buildPayload(
      isUser: true,
      startDate: startDate,
      endDate: endDate,
    );
    await callVitalGraph(data);
  }

  Future<void> callForUserWithFilter(String filterType) async {
    final data = _buildPayload(isUser: true, filterType: filterType);
    await callVitalGraph(data);
  }

  // 🔹 Guest API Calls
  Future<void> callForGuestWithDateRange(
    String startDate,
    String endDate,
    String guestId,
  ) async {
    final data = _buildPayload(
      isUser: false,
      startDate: startDate,
      endDate: endDate,
      guestId: guestId,
    );
    await callVitalGraph(data);
  }

  Future<void> callForGuestWithFilter(String filterType, String guestId) async {
    final data = _buildPayload(
      isUser: false,
      filterType: filterType,
      guestId: guestId,
    );
    await callVitalGraph(data);
  }
}
