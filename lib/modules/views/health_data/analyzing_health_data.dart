import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/enum/health_data_enum.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/health_data/all_report_screen.dart';
import 'package:ntt_data/modules/views/health_data/widgets/common_health_asset.dart';
import 'package:ntt_data/modules/views/health_data/widgets/getvitalStatus.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/indo_common_card.dart';
import 'package:ntt_data/widgets/test_main_expand_widget.dart';

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
  final _authController = Get.find<AuthController>();
  final _geustController = Get.find<GeustController>();

  String getVitalValue(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "";
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
    String? imageAsset,
    required String vitalHeading,
    required String vitalDescription,
    bool isExpand = false,
    bool isVitalActive = true,
    Widget expandedWidget = const SizedBox(),
  }) {
    return IndoCommonCard(
      imageAsset: imageAsset ?? '',
      isVitalActive: isVitalActive,
      vitalName: vitalName,
      vitalValue: vitalValue ?? 'N/A',
      vitalCondition: vitalCondition ?? '',
      vitalMass: vitalMass ?? "",
      vitalStatus: vitalStatus,
      vitalHeading: vitalHeading,
      vitalDescription: vitalDescription,
      isExpand: isExpand,
      expandedWidget: expandedWidget,
    );
  }

  List<Widget> allVitalSigns() {
    final bpValue = getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue?.split('/') ?? [];
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;
    final diastolic = bpParts.length > 1 ? int.tryParse(bpParts[1]) : null;

    return [
      buildCard(
        vitalName: HealthDataEnum.wellnessScore.name,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getWellnessStatus(
          VitalSignTypes.wellnessIndex,
          5,
          7,
        ),
        vitalHeading: HealthDataEnum.wellnessScore.name,
        vitalDescription: HealthDataEnum.wellnessScore.description,
        vitalMass: '',
        imageAsset: CommonHealthAsset().getWellnessAsset(
          statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
        ),
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getBreathingRateAsset(
          statusHelper.getBreathingRate(VitalSignTypes.respirationRate, 12, 20),
        ),
        vitalName: "Breathing Rate ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.respirationRate),
        vitalCondition: 'Avg 12 - 20',
        vitalStatus: statusHelper.getBreathingRate(
          VitalSignTypes.respirationRate,
          12,
          20,
        ),
        vitalHeading: WellnessMetricDescriptions.BreathingRate,
        vitalDescription: WellnessMetricDescriptionsLong.breathRate,
        vitalMass: 'rpm',
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPulseRateAsset(
          statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
        ),
        vitalName: "Pulse rate (Heart Rate)",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: statusHelper.getPulseRate(
          VitalSignTypes.pulseRate,
          60,
          100,
        ),
        vitalHeading: WellnessMetricDescriptions.pulseRate,
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPrqAsset(
          statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        ),
        vitalName: "PRQ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.prq),
        vitalCondition: '',
        vitalMass: "",
        vitalStatus: statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        vitalHeading: WellnessMetricDescriptions.prq,
        vitalDescription: WellnessMetricDescriptionsLong.prq,
      ),
      buildCard(
        vitalName: "Blood Pressure",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: '',
        vitalMass: "mmHg",
        vitalStatus: statusHelper.getBpSystolic(systolic, 100, 129),
        vitalHeading: WellnessMetricDescriptions.bloodPressureDiastolic,
        vitalDescription: WellnessMetricDescriptionsLong.bpSystolic,

        imageAsset: CommonHealthAsset().getSystolicBPAsset(
          statusHelper.getBpSystolic(systolic, 100, 129),
        ),
      ),

      buildCard(
        imageAsset: CommonHealthAsset().getOxygenSaturationAsset(
          statusHelper.getOxygenSaturation(
            VitalSignTypes.oxygenSaturation,
            94,
            95,
          ),
        ),
        vitalName: "Oxygen Saturation",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.oxygenSaturation),
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: statusHelper.getOxygenSaturation(
          VitalSignTypes.oxygenSaturation,
          94,
          95,
        ),
        vitalHeading: WellnessMetricDescriptions.oxygenSaturation,
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  final statusHelper = Getvitalstatus();

  List<Widget> basicVitalSigns() {
    final bpValue = getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue?.split('/') ?? [];
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;
    final diastolic = bpParts.length > 1 ? int.tryParse(bpParts[1]) : null;

    return [
      buildCard(
        vitalName: HealthDataEnum.wellnessScore.name,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getWellnessStatus(
          VitalSignTypes.wellnessIndex,
          5,
          7,
        ),
        vitalHeading: HealthDataEnum.wellnessScore.name,
        vitalDescription: HealthDataEnum.wellnessScore.description,
        vitalMass: '',
        imageAsset: CommonHealthAsset().getWellnessAsset(
          statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
        ),
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getBreathingRateAsset(
          statusHelper.getBreathingRate(VitalSignTypes.respirationRate, 12, 20),
        ),
        vitalName: "Breathing Rate ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.respirationRate),
        vitalCondition: 'Avg 12 - 20',
        vitalStatus: statusHelper.getBreathingRate(
          VitalSignTypes.respirationRate,
          12,
          20,
        ),
        vitalHeading: WellnessMetricDescriptions.BreathingRate,
        vitalDescription: WellnessMetricDescriptionsLong.breathRate,
        vitalMass: 'rpm',
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPulseRateAsset(
          statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
        ),
        vitalName: "Pulse rate (Heart Rate)",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: statusHelper.getPulseRate(
          VitalSignTypes.pulseRate,
          60,
          100,
        ),
        vitalHeading: WellnessMetricDescriptions.pulseRate,
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPrqAsset(
          statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        ),
        vitalName: "PRQ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.prq),
        vitalCondition: '',
        vitalMass: "",
        vitalStatus: statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        vitalHeading: WellnessMetricDescriptions.prq,
        vitalDescription: WellnessMetricDescriptionsLong.prq,
      ),
      buildCard(
        vitalName: "Blood Pressure",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: '',
        vitalMass: "mmHg",
        vitalStatus: statusHelper.getBpSystolic(systolic, 100, 129),
        vitalHeading: WellnessMetricDescriptions.bloodPressureDiastolic,
        vitalDescription: WellnessMetricDescriptionsLong.bpSystolic,

        imageAsset: CommonHealthAsset().getSystolicBPAsset(
          statusHelper.getBpSystolic(systolic, 100, 129),
        ),
      ),

      buildCard(
        imageAsset: CommonHealthAsset().getOxygenSaturationAsset(
          statusHelper.getOxygenSaturation(
            VitalSignTypes.oxygenSaturation,
            94,
            95,
          ),
        ),
        vitalName: "Oxygen Saturation",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.oxygenSaturation),
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: statusHelper.getOxygenSaturation(
          VitalSignTypes.oxygenSaturation,
          94,
          95,
        ),
        vitalHeading: WellnessMetricDescriptions.oxygenSaturation,
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  List<Widget> bloodlessBloodTests() {
    bool isMale = false;
    var hemoglobinMin = 0.0;
    var hemoglobinMax = 0.0;
    if (_geustController.selectionType.isNotEmpty) {
      isMale = _geustController.selectionType.value == "Male";
    } else {
      isMale = _measurementController.genderType.toLowerCase() == 'male';
    }
    hemoglobinMin = isMale ? 14.0 : 12.0;
    hemoglobinMax = isMale ? 18.0 : 16.0;

    final a1cValueStr = statusHelper.getVitalValue(
      VitalSignTypes.hemoglobinA1C,
    );
    final a1cValue = double.tryParse(a1cValueStr ?? '');

    String a1cStatus = 'low'; // default for safety
    String a1cConditionText = '';

    if (a1cValue != null) {
      if (a1cValue <= 5.6) {
        a1cStatus = 'low';
        a1cConditionText = 'Normal';
      } else if (a1cValue <= 6.4) {
        a1cStatus = 'medium';
        a1cConditionText = 'Prediabetes risk';
      } else {
        a1cStatus = 'high';
        a1cConditionText = 'Diabetes risk';
      }
    }

    return [
      buildCard(
        imageAsset: CommonHealthAsset().getHemoglobinAsset(
          statusHelper.getHemoglobin(
            VitalSignTypes.hemoglobin,
            hemoglobinMin,
            hemoglobinMax,
          ),
        ),
        vitalName: "Hemoglobin",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
        vitalCondition: "",
        vitalMass: "g/dL",
        vitalStatus: statusHelper.getHemoglobin(
          VitalSignTypes.hemoglobin,
          hemoglobinMin,
          hemoglobinMax,
        ),

        vitalHeading: WellnessMetricDescriptions.hemoglobin,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getHbA1cAsset(a1cStatus),
        vitalName: "Hemoglobin A1C",
        vitalValue: a1cValueStr,
        vitalCondition: '', // 👈 status text like Prediabetes risk
        vitalMass: "%",
        vitalStatus: a1cConditionText,
        vitalHeading: WellnessMetricDescriptions.hemoglobinA1C,
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobinA1C,
      ),
    ];
  }

  List<Widget> risks() {
    return [
      buildCard(
        imageAsset: CommonHealthAsset().getAscvdRiskAsset(
          statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
        ),
        vitalName: "ASCVD Risk ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
        vitalHeading: WellnessMetricDescriptions.ascvdRisk,
        vitalDescription: WellnessMetricDescriptionsLong.ascvdRisk,
      ),
      buildCard(
        vitalName: "Heart Age ",
        vitalValue: getVitalValue(VitalSignTypes.heartAge),
        vitalMass: "years",
        vitalStatus: "",
        // WellnessMetricDescriptions.heartAge, // no comparison logic provided
        vitalHeading: "",
        vitalDescription: WellnessMetricDescriptionsLong.heartAge,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().gethighBPRiskAsset(
          getVitalValue(VitalSignTypes.highBloodPressureRisk),
        ),
        vitalName: "High Blood Pressure Risk",
        vitalValue: getVitalValue(VitalSignTypes.highBloodPressureRisk),
        vitalHeading: WellnessMetricDescriptions.highBloodPressureRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highBloodPressureRisk,
        vitalStatus: getVitalValue(
          VitalSignTypes.highBloodPressureRisk,
        ), // no range given
        vitalMass: '',
        vitalCondition: '',
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getHbA1cAsset(
          getVitalValue(VitalSignTypes.highHemoglobinA1CRisk),
        ),
        vitalName: "High HbA1c Risk",
        vitalValue: getVitalValue(VitalSignTypes.highHemoglobinA1CRisk),
        vitalCondition: '',
        vitalStatus: getVitalValue(VitalSignTypes.highHemoglobinA1CRisk),
        vitalHeading: WellnessMetricDescriptions.highHbA1cRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highHbA1cRisk,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().gethighFastingGlucoseRiskAsset(
          getVitalValue(VitalSignTypes.highFastingGlucoseRisk),
        ),
        vitalName: "High Fasting Glucose Risk",
        vitalValue: getVitalValue(VitalSignTypes.highFastingGlucoseRisk),
        vitalHeading: WellnessMetricDescriptions.highFastingGlucoseRisk,
        vitalDescription: WellnessMetricDescriptionsLong.highFastingGlucoseRisk,
        vitalStatus: getVitalValue(VitalSignTypes.highFastingGlucoseRisk),
      ),
      buildCard(
        imageAsset: CommonHealthAsset().gethighCholesterolRiskAsset(
          getVitalValue(VitalSignTypes.highTotalCholesterolRisk),
        ),
        vitalName: "High Total Cholesterol Risk",
        vitalValue: getVitalValue(VitalSignTypes.highTotalCholesterolRisk),
        vitalHeading: WellnessMetricDescriptions.highTotalCholesterolRisk,
        vitalDescription:
            WellnessMetricDescriptionsLong.highTotalCholesterolRisk,
        vitalStatus: getVitalValue(VitalSignTypes.highTotalCholesterolRisk),
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getLowHemoglobinRiskAsset(
          getVitalValue(VitalSignTypes.lowHemoglobinRisk),
        ),
        vitalName: "Low Hemoglobin Risk",
        vitalValue: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
        vitalHeading: WellnessMetricDescriptions.lowHemoglobinRisk,
        vitalDescription: WellnessMetricDescriptionsLong.lowHemoglobinRisk,
        vitalStatus: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
      ),
    ];
  }

  List<Widget> stress() {
    // Get the raw value as a String
    final normalizedStressValueStr = getVitalValue(
      VitalSignTypes.normalizedStressIndex,
    );

    // Parse it to double for evaluation
    final normalizedStressValue = double.tryParse(
      normalizedStressValueStr ?? '',
    );

    // Determine status based on value

    // Determine status based on value
    String stressLevel = '';
    if (normalizedStressValue != null) {
      if (normalizedStressValue < 29) {
        stressLevel = 'Low';
      } else if (normalizedStressValue < 40) {
        stressLevel = 'Normal';
      } else if (normalizedStressValue < 67) {
        stressLevel = 'Mild';
      } else if (normalizedStressValue < 97) {
        stressLevel = 'High';
      } else {
        stressLevel = 'Very High';
      }
    }

    return [
      buildCard(
        vitalName: "Stress Level",
        vitalValue: getVitalValue(VitalSignTypes.stressLevel),
        vitalCondition: '',
        vitalMass: "",
        vitalStatus: getVitalValue(VitalSignTypes.stressLevel),
        vitalHeading: WellnessMetricDescriptions.stressLevel,
        vitalDescription: WellnessMetricDescriptionsLong.stressLevel,
        isExpand: true,
        imageAsset: CommonHealthAsset().getStressLevelAsset(
          getVitalValue(VitalSignTypes.stressLevel),
        ),
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'Stress Index ',
              isExpanded: true,
              titleText: "Stress Index",
              statusText: "",
              // "Your Stress Index is ${_measurementController.vitalsResults.value.getResult(VitalSignTypes.stressIndex)!.value.toString()}", //need to get it with avg
              valueText:
                  _measurementController.vitalsResults.value
                      .getResult(VitalSignTypes.stressIndex)!
                      .value
                      .toString(),

              unitText: " ",
            ),
            StressInfoCard(
              vitalName: 'Normalized Stress Index',
              isExpanded: true,
              titleText: "Normalized Stress Index",
              statusText:
                  "Normalized Stress Index is $stressLevel", // 👈 Only Low/Mild/High
              valueText: normalizedStressValueStr,
              unitText: "%",
              imageAsset: CommonHealthAsset().getmediumizedStressIndexAsset(
                _getVitalStatusTwo(VitalSignTypes.normalizedStressIndex),
              ),
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
        imageAsset: CommonHealthAsset().getHrvSdnnAsset(
          _getVitalStatus(VitalSignTypes.sdnn, 50, 100),
        ),
        vitalName: "HRV SDNN",
        vitalValue: getVitalValue(VitalSignTypes.sdnn),
        vitalCondition: 'Avg 50 ',
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
              statusText: _getVitalStatus(
                VitalSignTypes.meanRri,
                600,
                1000,
              ), //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.meanRri),
              imageAsset: CommonHealthAsset().getMeanRRiAsset(
                _getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
              ),
              unitText: "ms",
            ),
            StressInfoCard(
              vitalName: 'RMSSD',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.rmssd,
              statusText: _getVitalStatus(VitalSignTypes.rmssd, 25, 43),
              //need to get it with avg
              valueText: getVitalValue(VitalSignTypes.rmssd),
              imageAsset: CommonHealthAsset().getRmssdAsset(
                _getVitalStatus(VitalSignTypes.rmssd, 25, 43),
              ),
              unitText: "ms",
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> advancedHeartRateVariability() {
    print(statusHelper.getVitalValue(VitalSignTypes.pnsZone));
    return [
      buildCard(
        imageAsset: CommonHealthAsset().getRecoveryAbilityAsset(
          statusHelper.getVitalValue(VitalSignTypes.pnsZone),
        ),
        vitalName: "Recovery Ability (PNS Zone)",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pnsZone),
        vitalCondition: '',
        vitalStatus: statusHelper.getVitalValue(VitalSignTypes.pnsZone),
        vitalHeading: WellnessMetricDescriptions.recoveryAbility,
        vitalDescription: WellnessMetricDescriptionsLong.recoveryAbility,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getPnsIndexAsset(
          statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1),
        ),
        vitalName: "PNS Index",
        vitalValue: getVitalValue(VitalSignTypes.pnsIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1),

        vitalHeading: WellnessMetricDescriptions.pnsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.pnsIndex,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getSnsIndexAsset(
          getVitalValue(VitalSignTypes.snsZone),
        ),
        vitalName: "Stress Response (SNS Zone) ",
        vitalValue: getVitalValue(VitalSignTypes.snsZone),
        vitalCondition: '',
        vitalStatus: getVitalValue(VitalSignTypes.snsZone),
        vitalHeading: WellnessMetricDescriptions.snsZone,
        vitalDescription: WellnessMetricDescriptionsLong.snsZone,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getSnsIndexAsset(
          _getVitalStatus(VitalSignTypes.snsIndex, -1, 1),
        ),
        vitalName: "SNS Index",
        vitalValue: getVitalValue(VitalSignTypes.snsIndex),
        vitalCondition: '',
        vitalStatus: _getVitalStatus(VitalSignTypes.snsIndex, -1, 1),
        vitalHeading: WellnessMetricDescriptions.snsIndex,
        vitalDescription: WellnessMetricDescriptionsLong.snsIndex,
      ),
      buildCard(
        // imageAsset: CommonHealthAsset().getSD1Asset(
        //   getVitalValue(VitalSignTypes.sd1),
        // ),
        vitalName: "SD1",
        vitalValue: getVitalValue(VitalSignTypes.sd1),
        vitalCondition: '',
        vitalMass: "ms",
        vitalStatus: "",
        //  _getVitalStatus(VitalSignTypes.sd1, 4, 7),
        vitalHeading: "",
        vitalDescription: WellnessMetricDescriptionsLong.sd1,
        isVitalActive: false,
      ),
      buildCard(
        // imageAsset: CommonHealthAsset().getSD2Asset(
        //   // getVitalValue(VitalSignTypes.sd2),
        // ),
        vitalName: "SD2",
        vitalValue: getVitalValue(VitalSignTypes.sd2),
        vitalCondition: '',
        vitalMass: "ms",
        vitalStatus: "",
        //  _getVitalStatus(VitalSignTypes.sd1, 4, 7),
        vitalHeading: "",
        vitalDescription: WellnessMetricDescriptionsLong.sd2,
        isVitalActive: false,
      ),
      buildCard(
        imageAsset: CommonHealthAsset().getLfHfAsset(
          _getVitalStatus(VitalSignTypes.lfhf, 0.5, 2),
        ),
        vitalName: "LF/HF",
        vitalMass: '',
        vitalValue: getVitalValue(VitalSignTypes.lfhf),
        vitalCondition: '',
        vitalStatus: _getVitalStatus(VitalSignTypes.lfhf, 0.5, 2),
        vitalHeading: WellnessMetricDescriptions.lfhf,
        vitalDescription: WellnessMetricDescriptionsLong.lfHf,
        isVitalActive: true,
      ),
      // buildCard(
      //   // imageAsset: CommonHealthAsset().getRRiDataAsset(
      //   //   // getVitalValue(VitalSignTypes.rri),
      //   // ),
      //   vitalName: "RRi Data ",
      //   vitalMass: '',
      //   vitalValue: VitalSignTypes.rri.toString(),
      //   vitalCondition: '',
      //   vitalStatus: _getVitalStatus(VitalSignTypes.rri, 0.5, 2),
      //   vitalHeading: WellnessMetricDescriptions.RRiData,
      //   vitalDescription: WellnessMetricDescriptionsLong.rriData,
      //   isVitalActive: false,
      // ),
      // You also mentioned SD1, SD2, LF/HF, RRi Data but no cards provided, add if you want.
    ];
  }

  String _getVitalStatus(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'Normal';
  }

  String _getVitalStatusBloodPressure(vitalType, num min, num max) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String _getVitalStatusTwo(vitalType) {
    final rawValue = getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value <= 29) return 'low';
    if (value <= 40) return "Normal";
    if (value <= 67) return "Mild";
    if (value <= 97) return "High";
    if (value > 97) return "Very High";
    return 'medium';
  }

  List<Widget> allCards() {
    return [
      ...allVitalSigns(),
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: false,
        title: "Health data report",
        textColor: AppColors.blackColor,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10.0),
        //     child: CommonAssets.svgAsset(AppAssets.downloadIcon),
        //   ),
        // ],
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
      spacedList.add(const SizedBox(height: 10));
    }
    return spacedList;
  }
}
