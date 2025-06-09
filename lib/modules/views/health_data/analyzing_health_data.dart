import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/health_data/additional_screen.dart';
import 'package:ntt_data/modules/views/health_data/all_report_screen.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/test_main.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/modules/views/health_data/vital_screen.dart';
import 'package:ntt_data/modules/views/health_data/wellness_screen.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/test_main_expand_widget.dart';

import '../geust/controller/geust_controller.dart';

// ignore: must_be_immutable
class AnalyzingHealthData extends StatefulWidget {
  AnalyzingHealthData({super.key});

  @override
  State<AnalyzingHealthData> createState() => _AnalyzingHealthDataState();
}

class _AnalyzingHealthDataState extends State<AnalyzingHealthData> {
  @override
  void initState() {
    // TODO: implement initState
    barWidgets = [
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(allCardsWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(basicVitalSigns())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(bloodlessBloodTests())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(risks())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(stress())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(heartRateVariability())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(advancedHeartRateVariability())),
      ),
    ];
    super.initState();
  }

  final _measurementController = Get.find<MeasurementController>();
  final _geustController = Get.find<GeustController>();
  // Dummy implementations, replace with your actual method
  String getVitalValue(int type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "null";
    if (value is num) return value.toStringAsFixed(1);
    return value.toString();
  }

  // Helper to build IndoCommonCard with less repetition
  Widget buildCard({
    required String vitalName,
    String? vitalValue,
    String? vitalCondition,
    String? vitalMass,
    required String vitalStatus,
    required String vitalHeading,
    required String vitalDescription,
    bool isExpand = false,
    Widget expandedWidget = const SizedBox(),
  }) {
    return IndoCommonCard(
      vitalName: vitalName,
      vitalValue: vitalValue.toString(),
      vitalCondition: vitalCondition.toString(),
      vitalMass: vitalMass.toString(),
      vitalStatus: vitalStatus,
      vitalHeading: vitalHeading,
      vitalDescription: vitalDescription,
      isExpand: isExpand,
      expandedWidget: expandedWidget,
    );
  }

  List<Widget> basicVitalSigns() {
    return [
      buildCard(
        vitalName: "Wellness Score",
        vitalValue: getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: 'Avg 4 - 6',
        vitalStatus: _getVitalStatus(VitalSignTypes.wellnessIndex, 4, 6),
        vitalHeading: WellnessMetricDescriptions.wellnessScore,
        vitalDescription: WellnessMetricDescriptionsLong.wellnessScore,
      ),
      buildCard(
        vitalName: "Breathing Rate ",
        vitalValue: getVitalValue(VitalSignTypes.respirationRate),
        vitalCondition: 'Avg 4 - 6',
        vitalStatus: _getVitalStatus(VitalSignTypes.respirationRate, 4, 6),
        vitalHeading: WellnessMetricDescriptions.wellnessScore,
        vitalDescription: WellnessMetricDescriptionsLong.wellnessScore,
      ),
      buildCard(
        vitalName: "Blood Pressure",
        vitalValue: getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: 'Avg 90 - 120',
        vitalMass: "mmHg",
        vitalStatus: _getVitalStatus(VitalSignTypes.bloodPressure, 90, 120),
        vitalHeading: WellnessMetricDescriptions.bloodPressureDiastolic,
        vitalDescription: WellnessMetricDescriptionsLong.bpDiastolic,
        isExpand: false,
      ),

      buildCard(
        vitalName: "Pulse rate (Heart Rate)",
        vitalValue: getVitalValue(VitalSignTypes.pulseRate),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: _getVitalStatus(VitalSignTypes.pulseRate, 60, 100),
        vitalHeading: WellnessMetricDescriptions.pulseRate,
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        vitalName: "PRQ",
        vitalValue: getVitalValue(VitalSignTypes.prq),
        vitalCondition: 'Avg 3 - 5',
        vitalMass: "bpm",
        vitalStatus: _getVitalStatus(VitalSignTypes.prq, 3, 5),
        vitalHeading: WellnessMetricDescriptions.prq,
        vitalDescription: WellnessMetricDescriptionsLong.prq,
      ),
      buildCard(
        vitalName: "Oxygen Saturation",
        vitalValue: getVitalValue(VitalSignTypes.oxygenSaturation),
        vitalCondition: 'Avg 95 - 100',
        vitalMass: "%",
        vitalStatus: _getVitalStatus(VitalSignTypes.oxygenSaturation, 95, 100),
        vitalHeading: WellnessMetricDescriptions.oxygenSaturation,
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  List<Widget> bloodlessBloodTests() {
    return [
      buildCard(
        vitalName: "Hemoglobin",
        vitalValue: getVitalValue(VitalSignTypes.hemoglobin),
        vitalCondition: 'Avg 14 - 17',
        vitalMass: "g/dL",
        vitalStatus: _getVitalStatus(VitalSignTypes.hemoglobin, 14, 17),
        vitalHeading: WellnessMetricDescriptions.hemoglobin,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
      ),
      buildCard(
        vitalName: "Hemoglobin A1C",
        vitalValue: getVitalValue(VitalSignTypes.hemoglobinA1C),
        vitalCondition: 'Avg 5.7 - 6.4',
        vitalMass: "%",
        vitalStatus: _getVitalStatus(VitalSignTypes.hemoglobinA1C, 5.7, 6.4),
        vitalHeading: WellnessMetricDescriptions.hemoglobinA1C,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobinA1C,
      ),
    ];
  }

  List<Widget> risks() {
    return [
      buildCard(
        vitalName: "High Blood Pressure Risk",
        vitalValue: getVitalValue(VitalSignTypes.highBloodPressureRisk),
        vitalHeading: WellnessMetricDescriptions.highBloodPressureRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highBloodPressureRisk,
        vitalStatus: _getVitalStatus(
          VitalSignTypes.highBloodPressureRisk,
          100,
          160,
        ), // no range given
      ),
      buildCard(
        vitalName: "High HbA1c Risk",
        vitalValue: getVitalValue(VitalSignTypes.highHemoglobinA1CRisk),
        vitalCondition: 'Avg 31 - 70',
        vitalStatus: _getVitalStatus(
          VitalSignTypes.highHemoglobinA1CRisk,
          31,
          70,
        ),
        vitalHeading: WellnessMetricDescriptions.highHbA1cRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highHbA1cRisk,
      ),
      buildCard(
        vitalName: "High Fasting Glucose Risk",
        vitalValue: getVitalValue(VitalSignTypes.highFastingGlucoseRisk),
        vitalHeading: WellnessMetricDescriptions.highFastingGlucoseRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highFastingGlucoseRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "High Total Cholesterol Risk",
        vitalValue: getVitalValue(VitalSignTypes.highTotalCholesterolRisk),
        vitalHeading: WellnessMetricDescriptions.highTotalCholesterolRisk,
        vitalDescription:
            WellnessMetricDescriptionsLong.highTotalCholesterolRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "Low Hemoglobin Risk (anemia risk)",
        vitalValue: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
        vitalHeading: WellnessMetricDescriptions.lowHemoglobinRisk,
        vitalDescription: WellnessMetricDescriptionsLong.lowHemoglobinRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)",
        vitalValue: getVitalValue(VitalSignTypes.ascvdRisk),
        vitalCondition: 'Avg <5%',
        vitalMass: "%",
        vitalStatus: _ascvdRiskStatus(),
        vitalHeading: WellnessMetricDescriptions.ascvdRisk,
        vitalDescription: WellnessMetricDescriptionsLong.ascvdRisk,
      ),
      buildCard(
        vitalName: "Heart Age (biological heart age estimation)",
        vitalValue: getVitalValue(VitalSignTypes.heartAge),
        vitalMass: "years",
        vitalStatus: '', // no comparison logic provided
        vitalHeading: WellnessMetricDescriptions.heartAge,
        vitalDescription: WellnessMetricDescriptionsLong.heartAge,
      ),
    ];
  }

  List<Widget> stress() {
    return [
      buildCard(
        vitalName: "Stress",
        vitalValue: getVitalValue(VitalSignTypes.stressLevel),
        vitalCondition: 'Avg 3 - 6',
        vitalMass: "%",
        vitalStatus: _getVitalStatus(VitalSignTypes.stressIndex, 3, 6),
        vitalHeading: WellnessMetricDescriptions.stressIndex,
        vitalDescription: WellnessMetricDescriptionsLong.stressIndex,
        isExpand: true,
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'Stress Index ',
              isExpanded: true,
              titleText: "Stress Index",
              statusText: "Your Stress Index is Mild", //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.stressIndex),

              unitText: " ",
            ),
            StressInfoCard(
              vitalName: 'Stress Index ',
              isExpanded: true,
              titleText: "Normalized Stress Index",
              statusText:
                  "Your Normalized Stress Index is Mild", //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.normalizedStressIndex),

              unitText: " ",
            ),
          ],
        ),
      ),
      // You mentioned "Stress Level" and "Normalized Stress Index" but didn't give cards for them.
      // You can add similar cards here if you have data for those.
    ];
  }

  List<Widget> heartRateVariability() {
    return [
      buildCard(
        vitalName: "HRV SDNN",
        vitalValue: getVitalValue(VitalSignTypes.sdnn),
        vitalCondition: 'Avg 50 - 100',
        vitalMass: "ms",
        vitalStatus: _getVitalStatus(VitalSignTypes.sdnn, 50, 100),
        vitalHeading: WellnessMetricDescriptions.hrvSdnn,
        vitalDescription: WellnessMetricDescriptionsLong.hrvSDNN,
        isExpand: true,
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'Mean R-R Interval',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.meanRRi,
              statusText:
                  "Your Mean R-R Interval is Mild", //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.meanRri),

              unitText: " ",
            ),
            StressInfoCard(
              vitalName: 'RMSSD',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.rmssd,
              statusText: "Your RMSSD is Mild", //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.rmssd),

              unitText: " ",
            ),
          ],
        ),
      ),
      // buildCard(
      //   vitalName: "Mean R-R Interval",
      //   vitalValue: getVitalValue(VitalSignTypes.meanRri),
      //   vitalCondition: 'Avg 600 - 1000',
      //   vitalMass: "ms",
      //   vitalStatus: _getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
      //   vitalHeading: WellnessMetricDescriptions.meanRRi,
      //   vitalDescription: WellnessMetricDescriptionsLong.meanRRi,
      // ),
      // buildCard(
      //   vitalName: "RMSSD",
      //   vitalValue: getVitalValue(VitalSignTypes.rmssd),
      //   vitalCondition: 'Avg 30 - 70',
      //   vitalMass: "ms",
      //   vitalStatus: _getVitalStatus(VitalSignTypes.rmssd, 30, 70),
      //   vitalHeading: WellnessMetricDescriptions.rmssd,
      //   vitalDescription: WellnessMetricDescriptionsLong.rmssd,
      // ),
    ];
  }

  List<Widget> advancedHeartRateVariability() {
    return [
      buildCard(
        vitalName: "Recovery Ability (PNS Zone)",
        vitalValue: getVitalValue(VitalSignTypes.pnsZone),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus(VitalSignTypes.pnsZone, 4, 7),
        vitalHeading: WellnessMetricDescriptions.recoveryAbility,
        vitalDescription: WellnessMetricDescriptionsLong.recoveryAbility,
      ),
      buildCard(
        vitalName: "PNS Index",
        vitalValue: getVitalValue(VitalSignTypes.pnsIndex),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus(VitalSignTypes.pnsIndex, 4, 7),
        vitalHeading: WellnessMetricDescriptions.pnsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.pnsIndex,
      ),
      buildCard(
        vitalName: "SNS Index",
        vitalValue: getVitalValue(VitalSignTypes.snsIndex),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus(VitalSignTypes.snsIndex, 4, 7),
        vitalHeading: WellnessMetricDescriptions.snsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.snsIndex,
      ),
      // You also mentioned SD1, SD2, LF/HF, RRi Data but no cards provided, add if you want.
    ];
  }

  String _getVitalStatus(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType);
    if (rawValue == null) return '';
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'Low';
    if (value > max) return 'High';
    return 'Normal';
  }

  String _ascvdRiskStatus() {
    final rawValue = getVitalValue(VitalSignTypes.ascvdRisk);
    if (rawValue == null) return '';
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value >= 5) return 'High';
    return 'Low';
  }

  List<Widget> allCards() {
    return [
      ...basicVitalSigns(),
      ...bloodlessBloodTests(),
      ...risks(),
      ...stress(),
      ...heartRateVariability(),
      ...advancedHeartRateVariability(),
    ];
  }

  List<Widget> tabWidgets = [
    Tab(text: "All"),
    Tab(text: "Basic Vital Signs"),
    Tab(text: "Bloodless Blood Tests"),
    Tab(text: "Risks"),
    Tab(text: "Stress"),
    Tab(text: "Heart Rate Variability"),
    Tab(text: "Advanced Heart Rate Variability"),
  ];

  List<Widget> barWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: false,
        title: "Analyzing health data",
        textColor: AppColors.blackColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CommonAssets.svgAsset(AppAssets.downloadIcon),
          ),
        ],
      ),
      body: CustomTabBarView(tabWidgets: tabWidgets, tabBarWidgets: barWidgets),
    );
  }

  List<Widget> allCardsWithSpacing() {
    return withSpacing(allCards());
  }

  List<Widget> withSpacing(List<Widget> cards) {
    final spacedList = <Widget>[];
    for (var card in cards) {
      spacedList.add(card);
      spacedList.add(const SizedBox(height: 20));
    }
    return spacedList;
  }
}
