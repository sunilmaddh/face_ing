import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/bar_chart/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
  static const List<String> tabGuestGraphTitles = [
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
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBarVitalSignWidget = List.generate(
    5,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBarBloodlessWidget = List.generate(
    2,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBarRiskWidget = List.generate(
    6,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBarStressWidget = List.generate(
    1,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBaHRVWidget = List.generate(
    1,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  static List<Widget> tabBarHRVWidgets = List.generate(
    7,
    (_) => VitalGraphWidget(
      leftTitle: [],
      bottomTitles: [],
      vitalValue: [],
      vitalName: '',
    ),
  );
  List<String> filterTypeList = ["Weekly", "Monthly"];
  final _controller = Get.find<VitalGraphController>();
  Future<void> callVitalGraph(
    Map<String, dynamic> data,
    bool isFromHistory,
  ) async {
    await _controller.callVitalGraphDataApi(
      data: data,
      isFromHistory: isFromHistory,
    );
  }

  // 🔹 Common payload builder
  Map<String, dynamic> _buildPayload({
    required bool isUser,

    String? endDate,
    String? filterType,
    String? guestId,
  }) {
    final payload = <String, dynamic>{"userFlag": isUser.toString()};

    if (endDate != null) {
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
    String filterType,
    String endDate,
  ) async {
    final data = _buildPayload(
      isUser: true,
      endDate: endDate,
      filterType: filterType,
    );
    await callVitalGraph(data, false);
  }

  Future<void> callForUserWithFilter(
    String filterType,
    bool isFromHistory,
  ) async {
    final data = _buildPayload(isUser: true, filterType: filterType);
    await callVitalGraph(data, isFromHistory);
  }

  // 🔹 Guest API Calls
  Future<void> callForGuestWithDateRange(
    String filterType,
    String endDate,
    String guestId,
    bool isFormHistory,
  ) async {
    final data = _buildPayload(
      filterType: filterType,
      isUser: guestId.isEmpty ? true : false,
      endDate: endDate,
      guestId: guestId,
    );
    await callVitalGraph(data, isFormHistory);
  }

  Future<void> callForGuestWithFilter(
    String filterType,
    String guestId,
    bool isFromHistory,
  ) async {
    final data = _buildPayload(
      isUser: guestId.isEmpty ? true : false,
      filterType: filterType,
      guestId: guestId,
    );
    await callVitalGraph(data, isFromHistory);
  }

  List<HealthList> normalizeHealthData(
    List<String> xValues,
    List<HealthList> healthList,
  ) {
    List<HealthList> normalizedList = [];

    for (String x in xValues) {
      // Convert "Today" to current day
      String dayString =
          (x == "Today") ? DateFormat("d").format(DateTime.now()) : x;

      int? dayNum = int.tryParse(dayString);
      if (dayNum == null) {
        // Invalid day, add empty
        normalizedList.add(
          HealthList(value: "", scannedDate: "", status: "", isTypeVital: ""),
        );
        continue;
      }

      // Find any health data with matching day
      HealthList? match = healthList.firstWhere(
        (h) {
          if (h.scannedDate == null || h.scannedDate!.isEmpty) return false;
          DateTime scannedDate = DateTime.parse(h.scannedDate!);
          return scannedDate.day == dayNum;
        },
        orElse:
            () => HealthList(
              value: "",
              scannedDate: "",
              status: "",
              isTypeVital: "",
            ),
      );

      normalizedList.add(match);
    }

    return normalizedList;
  }

  static String cleanRange(String input) {
    return input.replaceAll(RegExp(r'\s?20\d{2}'), '');
  }
}
