import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/health_data/widgets/circle_progress_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/test_main.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class AllReportScreen extends StatefulWidget {
  AllReportScreen({super.key});

  @override
  State<AllReportScreen> createState() => _AllReportScreenState();
}

class _AllReportScreenState extends State<AllReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _measurementController = Get.find<MeasurementController>();
  final _geustController = Get.find<GeustController>();
  // Dummy implementations, replace with your actual method
  String? getVitalValue(String vitalType) {
    // TODO: implement fetching actual vital values
    return "5"; // Example static value for testing
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 7, vsync: this);

    _geustController.addGuest(_measurementController.vitalsResults.value);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    );
  }

  // Group cards by category based on your list

  List<Widget> basicVitalSigns() {
    return [
      buildCard(
        vitalName: "Wellness Score",
        vitalValue: getVitalValue("wellnessIndex"),
        vitalCondition: 'Avg 4 - 6',
        vitalStatus: _getVitalStatus("wellnessIndex", 4, 6),
        vitalHeading: WellnessMetricDescriptions.wellnessScore,
        vitalDescription: WellnessMetricDescriptionsLong.wellnessScore,
      ),
      buildCard(
        vitalName: "Blood Pressure",
        vitalValue: getVitalValue("bloodPressure"),
        vitalCondition: 'Avg 90 - 120',
        vitalMass: "mmHg",
        vitalStatus: _getVitalStatus("bloodPressure", 90, 120),
        vitalHeading: WellnessMetricDescriptions.bloodPressureDiastolic,
        vitalDescription: WellnessMetricDescriptionsLong.bpDiastolic,
        isExpand: true,
      ),
      buildCard(
        vitalName: "Pulse rate (Heart Rate)",
        vitalValue: getVitalValue("pulseRate"),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: _getVitalStatus("pulseRate", 60, 100),
        vitalHeading: WellnessMetricDescriptions.pulseRate,
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        vitalName: "PRQ",
        vitalValue: getVitalValue("prq"),
        vitalCondition: 'Avg 3 - 5',
        vitalMass: "bpm",
        vitalStatus: _getVitalStatus("prq", 3, 5),
        vitalHeading: WellnessMetricDescriptions.prq,
        vitalDescription: WellnessMetricDescriptionsLong.prq,
      ),
      buildCard(
        vitalName: "Oxygen Saturation",
        vitalValue: getVitalValue("oxygenSaturation"),
        vitalCondition: 'Avg 95 - 100',
        vitalMass: "%",
        vitalStatus: _getVitalStatus("oxygenSaturation", 95, 100),
        vitalHeading: WellnessMetricDescriptions.oxygenSaturation,
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  List<Widget> bloodlessBloodTests() {
    return [
      buildCard(
        vitalName: "Hemoglobin",
        vitalValue: getVitalValue("hemoglobin"),
        vitalCondition: 'Avg 14 - 17',
        vitalMass: "g/dL",
        vitalStatus: _getVitalStatus("hemoglobin", 14, 17),
        vitalHeading: WellnessMetricDescriptions.hemoglobin,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
      ),
      buildCard(
        vitalName: "Hemoglobin A1C",
        vitalValue: getVitalValue("hemoglobinA1C"),
        vitalCondition: 'Avg 5.7 - 6.4',
        vitalMass: "%",
        vitalStatus: _getVitalStatus("hemoglobinA1C", 5.7, 6.4),
        vitalHeading: WellnessMetricDescriptions.hemoglobinA1C,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobinA1C,
      ),
    ];
  }

  List<Widget> risks() {
    return [
      buildCard(
        vitalName: "High Blood Pressure Risk",
        vitalValue: getVitalValue("highBloodPressureRisk"),
        vitalHeading: WellnessMetricDescriptions.highBloodPressureRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highBloodPressureRisk,
        vitalStatus: '', // no range given
      ),
      buildCard(
        vitalName: "High HbA1c Risk",
        vitalValue: getVitalValue("highHemoglobinA1CRisk"),
        vitalCondition: 'Avg 31 - 70',
        vitalStatus: _getVitalStatus("highHemoglobinA1CRisk", 31, 70),
        vitalHeading: WellnessMetricDescriptions.highHbA1cRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highHbA1cRisk,
      ),
      buildCard(
        vitalName: "High Fasting Glucose Risk",
        vitalValue: getVitalValue("highFastingGlucoseRisk"),
        vitalHeading: WellnessMetricDescriptions.highFastingGlucoseRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highFastingGlucoseRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "High Total Cholesterol Risk",
        vitalValue: getVitalValue("highTotalCholesterolRisk"),
        vitalHeading: WellnessMetricDescriptions.highTotalCholesterolRisk,
        vitalDescription:
            WellnessMetricDescriptionsLong.highTotalCholesterolRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "Low Hemoglobin Risk (anemia risk)",
        vitalValue: getVitalValue("lowHemoglobinRisk"),
        vitalHeading: WellnessMetricDescriptions.lowHemoglobinRisk,
        vitalDescription: WellnessMetricDescriptionsLong.lowHemoglobinRisk,
        vitalStatus: '',
      ),
      buildCard(
        vitalName: "ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)",
        vitalValue: getVitalValue("ascvdRisk"),
        vitalCondition: 'Avg <5%',
        vitalMass: "%",
        vitalStatus: _ascvdRiskStatus(),
        vitalHeading: WellnessMetricDescriptions.ascvdRisk,
        vitalDescription: WellnessMetricDescriptionsLong.ascvdRisk,
      ),
      buildCard(
        vitalName: "Heart Age (biological heart age estimation)",
        vitalValue: getVitalValue("heartAge"),
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
        vitalValue: getVitalValue("stressIndex"),
        vitalCondition: 'Avg 3 - 6',
        vitalMass: "%",
        vitalStatus: _getVitalStatus("stressIndex", 3, 6),
        vitalHeading: WellnessMetricDescriptions.stressIndex,
        vitalDescription: WellnessMetricDescriptionsLong.stressIndex,
        isExpand: true,
      ),
      // You mentioned "Stress Level" and "Normalized Stress Index" but didn't give cards for them.
      // You can add similar cards here if you have data for those.
    ];
  }

  List<Widget> heartRateVariability() {
    return [
      buildCard(
        vitalName: "HRV SDNN",
        vitalValue: getVitalValue("sdnn"),
        vitalCondition: 'Avg 50 - 100',
        vitalMass: "ms",
        vitalStatus: _getVitalStatus("sdnn", 50, 100),
        vitalHeading: WellnessMetricDescriptions.hrvSdnn,
        vitalDescription: WellnessMetricDescriptionsLong.hrvSDNN,
      ),
      buildCard(
        vitalName: "Mean R-R Interval",
        vitalValue: getVitalValue("meanRri"),
        vitalCondition: 'Avg 600 - 1000',
        vitalMass: "ms",
        vitalStatus: _getVitalStatus("meanRri", 600, 1000),
        vitalHeading: WellnessMetricDescriptions.meanRRi,
        vitalDescription: WellnessMetricDescriptionsLong.meanRRi,
      ),
      buildCard(
        vitalName: "RMSSD",
        vitalValue: getVitalValue("rmssd"),
        vitalCondition: 'Avg 30 - 70',
        vitalMass: "ms",
        vitalStatus: _getVitalStatus("rmssd", 30, 70),
        vitalHeading: WellnessMetricDescriptions.rmssd,
        vitalDescription: WellnessMetricDescriptionsLong.rmssd,
      ),
    ];
  }

  List<Widget> advancedHeartRateVariability() {
    return [
      buildCard(
        vitalName: "Recovery Ability (PNS Zone)",
        vitalValue: getVitalValue("pnsZone"),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus("pnsZone", 4, 7),
        vitalHeading: WellnessMetricDescriptions.recoveryAbility,
        vitalDescription: WellnessMetricDescriptionsLong.recoveryAbility,
      ),
      buildCard(
        vitalName: "PNS Index",
        vitalValue: getVitalValue("pnsIndex"),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus("pnsIndex", 4, 7),
        vitalHeading: WellnessMetricDescriptions.pnsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.pnsIndex,
      ),
      buildCard(
        vitalName: "SNS Index",
        vitalValue: getVitalValue("snsIndex"),
        vitalCondition: 'Avg 4 - 7',
        vitalStatus: _getVitalStatus("snsIndex", 4, 7),
        vitalHeading: WellnessMetricDescriptions.snsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.snsIndex,
      ),
      // You also mentioned SD1, SD2, LF/HF, RRi Data but no cards provided, add if you want.
    ];
  }

  String _getVitalStatus(String vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType);
    if (rawValue == null) return '';
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'Low';
    if (value > max) return 'High';
    return 'Normal';
  }

  String _ascvdRiskStatus() {
    final rawValue = getVitalValue("ascvdRisk");
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

  @override
  Widget build(BuildContext context) {
    final tabs = [
      "All",
      "Basic Vital Signs",
      "Bloodless Blood Tests",
      "Risks",
      "Stress",
      "Heart Rate Variability",
      "Advanced Heart Rate Variability",
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            "Analyzing health data",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.transparent)),
              ),
              child: TabBar(
                padding: EdgeInsets.only(top: 10, bottom: 2),
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                labelColor: Colors.blue,
                // indicatorPadding: EdgeInsets.only(top: 10, bottom: 10),
                unselectedLabelColor: Colors.black87,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                tabs:
                    tabs.map((tabName) {
                      return Tab(
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            tabName,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(children: allCardsWithSpacing()),
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
              child: Column(
                children: withSpacing(advancedHeartRateVariability()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to add vertical spacing between cards
  List<Widget> withSpacing(List<Widget> cards) {
    final spacedList = <Widget>[];
    for (var card in cards) {
      spacedList.add(card);
      spacedList.add(const SizedBox(height: 20));
    }
    return spacedList;
  }

  List<Widget> allCardsWithSpacing() {
    return withSpacing(allCards());
  }
}

// Dummy classes to illustrate the structure.
// Replace these with your actual classes/implementations.

// class IndoCommonCard extends StatelessWidget {
//   final String vitalName;
//   final String? vitalValue;
//   final String? vitalCondition;
//   final String? vitalMass;
//   final String vitalStatus;
//   final String vitalHeading;
//   final String vitalDescription;
//   final bool isExpand;

//   const IndoCommonCard({
//     Key? key,
//     required this.vitalName,
//     this.vitalValue,
//     this.vitalCondition,
//     this.vitalMass,
//     required this.vitalStatus,
//     required this.vitalHeading,
//     required this.vitalDescription,
//     this.isExpand = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Dummy card UI, replace with your actual card widget
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               vitalName,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             if (vitalValue != null)
//               Text('Value: $vitalValue ${vitalMass ?? ""}'),
//             if (vitalCondition != null) Text('Condition: $vitalCondition'),
//             Text('Status: $vitalStatus'),
//             Text(vitalHeading, style: TextStyle(fontStyle: FontStyle.italic)),
//             Text(vitalDescription),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Dummy description classes
class WellnessMetricDescriptions {
  static const wellnessScore = "Wellness Score Heading";
  static const bloodPressureDiastolic = "Blood Pressure Heading";
  static const pulseRate = "Pulse Rate Heading";
  static const prq = "PRQ Heading";
  static const oxygenSaturation = "Oxygen Saturation Heading";
  static const hemoglobin = "Hemoglobin Heading";
  static const hemoglobinA1C = "Hemoglobin A1C Heading";
  static const highBloodPressureRisk = "High Blood Pressure Risk Heading";
  static const highHbA1cRisk = "High HbA1c Risk Heading";
  static const highFastingGlucoseRisk = "High Fasting Glucose Risk Heading";
  static const highTotalCholesterolRisk = "High Total Cholesterol Risk Heading";
  static const lowHemoglobinRisk = "Low Hemoglobin Risk Heading";
  static const ascvdRisk = "ASCVD Risk Heading";
  static const heartAge = "Heart Age Heading";
  static const stressIndex = "Stress Index Heading";
  static const hrvSdnn = "HRV SDNN Heading";
  static const meanRRi = "Mean RRi Heading";
  static const rmssd = "RMSSD Heading";
  static const recoveryAbility = "Recovery Ability Heading";
  static const pnsIndex = "PNS Index Heading";
  static const snsIndex = "SNS Index Heading";
}

class WellnessMetricDescriptionsLong {
  static const wellnessScore = "Long description for Wellness Score";
  static const bpDiastolic = "Long description for Blood Pressure";
  static const pulseRate = "Long description for Pulse Rate";
  static const prq = "Long description for PRQ";
  static const oxygenSaturation = "Long description for Oxygen Saturation";
  static const hemoglobin = "Long description for Hemoglobin";
  static const hemoglobinA1C = "Long description for Hemoglobin A1C";
  static const highBloodPressureRisk =
      "Long description for High Blood Pressure Risk";
  static const highHbA1cRisk = "Long description for High HbA1c Risk";
  static const highFastingGlucoseRisk =
      "Long description for High Fasting Glucose Risk";
  static const highTotalCholesterolRisk =
      "Long description for High Total Cholesterol Risk";
  static const lowHemoglobinRisk = "Long description for Low Hemoglobin Risk";
  static const ascvdRisk = "Long description for ASCVD Risk";
  static const heartAge = "Long description for Heart Age";
  static const stressIndex = "Long description for Stress Index";
  static const hrvSDNN = "Long description for HRV SDNN";
  static const meanRRi = "Long description for Mean RRi";
  static const rmssd = "Long description for RMSSD";
  static const recoveryAbility = "Long description for Recovery Ability";
  static const pnsIndex = "Long description for PNS Index";
  static const snsIndex = "Long description for SNS Index";
}
