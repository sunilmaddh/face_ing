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
import 'package:ntt_data/widgets/indo_common_card.dart';

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
  static const wellnessScore = "Wellness Score";
  static const BreathingRate = "Breathing Rate";
  static const bloodPressureDiastolic = "Blood Pressure";
  static const pulseRate = "Pulse Rate";
  static const prq = "PRQ";
  static const oxygenSaturation = "Oxygen Saturation";
  static const hemoglobin = "Hemoglobin";
  static const hemoglobinA1C = "Hemoglobin A1C";
  static const highBloodPressureRisk = "High Blood Pressure Risk";
  static const highHbA1cRisk = "High HbA1c Risk";
  static const highFastingGlucoseRisk = "High Fasting Glucose Risk";
  static const highTotalCholesterolRisk = "High Total Cholesterol Risk";
  static const lowHemoglobinRisk = "Low Hemoglobin Risk";
  static const ascvdRisk = "ASCVD Risk";
  static const heartAge = "Heart Age";
  static const stressIndex = "Stress Index";
  static const stressLevel = "Stress Level";
  static const hrvSdnn = "HRV SDNN";
  static const meanRRi = "Mean RRi";
  static const rmssd = "RMSSD";
  static const recoveryAbility = "Recovery Ability";
  static const pnsIndex = "PNS Index";
  static const snsIndex = "SNS Index";
  static const snsZone = "SNS Zone";
  static const sd1 = "SD1";
  static const sd2 = "SD2";
  static const lfhf = "LF/HF";
  static const RRiData = "RRi Data ";
}

class WellnessMetricDescriptionsLong {
  static const breathRate =
      "The breathing rate is the number of breaths you take per minute (rpm).";

  static const wellnessScore =
      "The Wellness Score is a prediction risk score that is used to predict a person's cardiovascular risk for the next 5 to 10 years.";

  static const RRiData = "The number of breaths you take per minute.";

  static const pulseRate = "The number of times your heart beats per minute.";

  static const prq =
      "The Pulse-Respiration Quotient (PRQ) is a measure of the ratio of a person’s pulse rate (measured in beats per minute) to their respiratory rate (measured in breaths per minute).";

  static const bpSystolic =
      "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.";

  static const bpDiastolic =
      "The pressure of blood is exerted on the walls of the arteries, which carry blood from the heart to other parts of the body.";

  static const oxygenSaturation =
      "Oxygen Saturation, or SpO2, is a measure of how much oxygen the red blood cells are carrying from the lungs to the rest of the body.";

  static const hemoglobin =
      "Hemoglobin is a protein in a person’s red blood cells that carries oxygen to the human body's organs and tissues and transports carbon dioxide from your organs and tissues back to your lungs.";

  static const hemoglobinA1C =
      "Hemoglobin A1C (or HbA1c) represents the average blood glucose (sugar) level for the last two to three months.";

  static const ascvdRisk =
      "ASCVD (Atherosclerotic Cardiovascular Disease) Risk estimates the likelihood of experiencing an atherosclerotic cardiovascular event within 10 years.";

  static const heartAge =
      "The Framingham Heart Age estimates the biological age of the heart based on cardiovascular health.";

  static const highBloodPressureRisk =
      "The High Blood Pressure Risk result indicates whether your blood pressure exceeds preset systolic/diastolic values.";

  static const highHbA1cRisk =
      "The High Hemoglobin A1c Risk (HbA1c) result indicates whether your Hemoglobin A1c level exceeds a preset threshold.";

  static const highFastingGlucoseRisk =
      "The High Fasting Glucose Risk result indicates whether your glucose level exceeds a preset threshold after at least 8 hours of fasting.";

  static const highTotalCholesterolRisk =
      "The High Total Cholesterol Risk result indicates whether your total cholesterol level exceeds a preset threshold.";

  static const lowHemoglobinRisk =
      "The Low Hemoglobin Risk result indicates whether your hemoglobin level is below a preset threshold.";

  static const stressLevel = "The body's reaction to a challenge or demand.";

  static const stressIndex =
      "Stress is the body's reaction to a challenge or demand.";

  static const normalizedStressIndex =
      "The Normalized Stress Level is calculated from the Stress Index and scaled to a range of 0 to 100.";

  static const hrvSDNN =
      "SDNN is a calculated parameter of Heart Rate Variability (HRV) that represents the standard deviation of normal-to-normal R-R-intervals.";

  static const meanRRi =
      "Mean RRi is the average time between the RR intervals (RRi) in milliseconds.";

  static const rmssd =
      "An important measure of the Heart Rate Variability. RMSSD is the root mean square of successive RR interval differences.";

  static const recoveryAbility =
      "The Recovery Ability that is also known as “rest and digest'' response refers to the body’s ability to recover, accumulate energy, and regulate bodily functions after stressful occurrences.";

  static const pnsIndex =
      "The PNS Index calculation is based on the following three parameters: Mean RRi, RMSSD, and SD1, and is used to indicate the body’s Recovery Ability zones.";

  static const snsIndex =
      "The SNS index is calculated based on the following three parameters: Heart Rate, Baevsky’s stress index, SD2, and is used to set the stress response zone.";
  static const snsZone =
      "The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.";

  static const stressResponse =
      "The Stress Response, which is also known as “fight or flight” response, refers to a physiological reaction to imminent danger that occurs when we are scared, anxious, stressed, attacked, or threatened.";

  static const sd1 =
      "SD1 is a poincaré plot standard deviation perpendicular to the line of identity.";

  static const sd2 =
      "SD2 is a poincaré plot standard deviation along the line of identity.";
  static const LfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";
  static const lfHf =
      "LF and HF stand for Low-Frequency and High-Frequency bands, which represent the Sympathetic and Parasympathetic activity, respectively.";

  static const rriData =
      "The RR interval is the time between the \"R\" peaks of successive heartbeats, in milliseconds.";
}
