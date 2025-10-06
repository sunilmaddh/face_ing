import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/bottomsheet_helper.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/views/binah/handler/vital_sign_helper.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/enum/health_data_enum.dart';
import 'package:ntt_data/core/utils/enum/vital_key.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/health_data/all_report_screen.dart';
import 'package:ntt_data/modules/views/health_data/widgets/common_health_asset.dart';
import 'package:ntt_data/modules/views/health_data/widgets/getvitalStatus.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/cards/stress_info_card.dart';
import 'package:ntt_data/widgets/indo_common_card.dart';

// ignore: must_be_immutable
class AnalyzingHealthData extends StatefulWidget {
  const AnalyzingHealthData({super.key});

  @override
  State<AnalyzingHealthData> createState() => _AnalyzingHealthDataState();
}

class _AnalyzingHealthDataState extends State<AnalyzingHealthData>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    barWidgets = [
      if (_measurementController.scanType.value != "add-guest" &&
          _measurementController.scanType.value != "re-scan")
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
    _tabController = TabController(
      length: AppMethods.tabGuestWidget.length,
      vsync: this,
    );

    super.initState();
  }

  final _measurementController = Get.find<MeasurementController>();
  final _geustController = Get.find<GeustController>();

  String getVitalValue(type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "";
    if (value is num) return value.toStringAsFixed(2);
    return value.toString();
  }

  // Helper to build IndoCommonCard with less repetition
  Widget buildCard({
    required String vitalName,
    String? vitalValue,
    String? vitalConfidence,
    String? vitalKey,
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
      confidenceLevel: vitalConfidence ?? "",
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
      onTop: () {
        AppNavigation.to(
          AppRoutes.vitalDescriptions,
          arguments: {"vitalKey": vitalKey},
        );
      },
      onInfoTop: () {},
    );
  }

  List<Widget> allVitalSigns() {
    final bpValue = statusHelper.getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue.split('/');
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;

    return [
      buildCard(
        vitalKey: VitalKeys.wellnessIndex,
        vitalName: HealthDataEnum.wellnessScore.name,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getWellnessStatus(
          VitalSignTypes.wellnessIndex,
          5,
          7,
        ),
        vitalHeading: "Your ${HealthDataEnum.wellnessScore.name}",
        vitalDescription: HealthDataEnum.wellnessScore.description,
        vitalMass: '',
        imageAsset: CommonHealthAsset().getWellnessAsset(
          statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
        ),
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignBreathingConfidence(),
        vitalKey: VitalKeys.respirationRate,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.BreathingRate}",
        vitalDescription: WellnessMetricDescriptionsLong.breathRate,
        vitalMass: 'rpm',
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignPulseRateConfidence(),
        vitalKey: VitalKeys.pulseRate,
        imageAsset: CommonHealthAsset().getPulseRateAsset(
          statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
        ),
        vitalName: "Heart Rate",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
        vitalCondition: 'Avg 60 - 100',
        vitalMass: "bpm",
        vitalStatus: statusHelper.getPulseRate(
          VitalSignTypes.pulseRate,
          60,
          100,
        ),
        vitalHeading: "Your ${WellnessMetricDescriptions.pulseRate}",
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignPrqConfidence(),
        vitalKey: VitalKeys.prq,
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
        vitalKey: VitalKeys.bloodPressure,
        vitalName: "Blood Pressure",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: 'Avg 100-129',
        vitalMass: "mmHg",
        vitalStatus: statusHelper.getBpSystolic(systolic, 100, 129),
        vitalHeading:
            "Your ${WellnessMetricDescriptions.bloodPressureDiastolic}",
        vitalDescription: WellnessMetricDescriptionsLong.bpSystolic,

        imageAsset: CommonHealthAsset().getSystolicBPAsset(
          statusHelper.getBpSystolic(systolic, 100, 129),
        ),
      ),

      buildCard(
        vitalKey: VitalKeys.oxygenSaturation,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.oxygenSaturation}",
        vitalDescription: WellnessMetricDescriptionsLong.oxygenSaturation,
      ),
    ];
  }

  final statusHelper = Getvitalstatus();

  List<Widget> basicVitalSigns() {
    final bpValue = statusHelper.getVitalValue(VitalSignTypes.bloodPressure);
    final bpParts = bpValue.split('/');
    final systolic = bpParts.isNotEmpty ? int.tryParse(bpParts[0]) : null;

    return [
      buildCard(
        vitalKey: VitalKeys.wellnessIndex,
        vitalName: HealthDataEnum.wellnessScore.name,
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
        vitalCondition: '',
        vitalStatus: statusHelper.getWellnessStatus(
          VitalSignTypes.wellnessIndex,
          5,
          7,
        ),
        vitalHeading: "Your ${HealthDataEnum.wellnessScore.name}",
        vitalDescription: HealthDataEnum.wellnessScore.description,
        vitalMass: '',
        imageAsset: CommonHealthAsset().getWellnessAsset(
          statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
        ),
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignBreathingConfidence(),
        vitalKey: VitalKeys.respirationRate,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.BreathingRate}",
        vitalDescription: WellnessMetricDescriptionsLong.breathRate,
        vitalMass: 'brpm',
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignPulseRateConfidence(),
        vitalKey: VitalKeys.pulseRate,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.pulseRate}",
        vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
      ),
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignPrqConfidence(),
        vitalKey: VitalKeys.prq,
        imageAsset: CommonHealthAsset().getPrqAsset(
          statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        ),
        vitalName: "PRQ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.prq),
        vitalCondition: '',
        vitalMass: "",
        vitalStatus: statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
        vitalHeading: "Your ${WellnessMetricDescriptions.prq}",
        vitalDescription: WellnessMetricDescriptionsLong.prq,
      ),
      buildCard(
        vitalKey: VitalKeys.bloodPressure,
        vitalName: "Blood Pressure",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
        vitalCondition: 'Avg 100-129',
        vitalMass: "mmHg",
        vitalStatus: statusHelper.getBpSystolic(systolic, 100, 129),
        vitalHeading:
            "Your ${WellnessMetricDescriptions.bloodPressureDiastolic}",
        vitalDescription: WellnessMetricDescriptionsLong.bpSystolic,

        imageAsset: CommonHealthAsset().getSystolicBPAsset(
          statusHelper.getBpSystolic(systolic, 100, 129),
        ),
      ),

      buildCard(
        vitalKey: VitalKeys.oxygenSaturation,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.oxygenSaturation}",
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
      } else if (a1cValue < 5.7) {
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
        vitalKey: VitalKeys.hemoglobin,
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
        vitalHeading: "Your ${WellnessMetricDescriptions.hemoglobin}",
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
      ),
      buildCard(
        vitalKey: VitalKeys.hemoglobinA1c,
        imageAsset: CommonHealthAsset().getHbA1cAsset(a1cStatus),
        vitalName: "Hemoglobin A1C",
        vitalValue: a1cValueStr,
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: a1cConditionText,
        vitalHeading: "Your ${WellnessMetricDescriptions.hemoglobinA1C}",
        vitalDescription: WellnessMetricDescriptionsLong.hemoglobinA1C,
      ),
    ];
  }

  List<Widget> risks() {
    return [
      buildCard(
        vitalKey: VitalKeys.ascvdRisk,
        imageAsset: CommonHealthAsset().getAscvdRiskAsset(
          statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
        ),
        vitalName: "ASCVD Risk ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
        vitalCondition: '',
        vitalMass: "%",
        vitalStatus: statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
        vitalHeading: "Your ${WellnessMetricDescriptions.ascvdRisk}",
        vitalDescription: WellnessMetricDescriptionsLong.ascvdRisk,
      ),
      buildCard(
        vitalKey: VitalKeys.heartAge,
        vitalName: "Heart Age ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.heartAge),
        vitalMass: "years",
        vitalStatus: "",
        // WellnessMetricDescriptions.heartAge, // no comparison logic provided
        vitalHeading: "",
        vitalDescription: WellnessMetricDescriptionsLong.heartAge,
      ),
      buildCard(
        vitalKey: VitalKeys.highBloodPressureRisk,
        imageAsset: CommonHealthAsset().gethighBPRiskAsset(
          statusHelper.getVitalStringStatus(
            VitalSignTypes.highBloodPressureRisk,
          ),
        ),
        vitalName: "High Blood Pressure Risk",
        vitalValue: statusHelper.getVitalValue(
          VitalSignTypes.highBloodPressureRisk,
        ),
        vitalHeading:
            "Your ${WellnessMetricDescriptions.highBloodPressureRisk}",
        vitalDescription: WellnessMetricDescriptionsLong.highBloodPressureRisk,
        vitalStatus: getVitalValue(
          VitalSignTypes.highBloodPressureRisk,
        ), // no range given
        vitalMass: '',
        vitalCondition: '',
        isVitalActive: false,
      ),
      buildCard(
        vitalKey: VitalKeys.highHemoglobinA1cRisk,
        imageAsset: CommonHealthAsset().getHbA1cAsset(
          statusHelper.getVitalStringStatus(
            VitalSignTypes.highHemoglobinA1CRisk,
          ),
        ),
        vitalName: "High HbA1c Risk",
        vitalValue: statusHelper.getVitalValue(
          VitalSignTypes.highHemoglobinA1CRisk,
        ),
        vitalCondition: '',
        vitalStatus: statusHelper.getVitalValue(
          VitalSignTypes.highHemoglobinA1CRisk,
        ),
        vitalHeading: "Your ${WellnessMetricDescriptions.highHbA1cRisk}",
        vitalDescription: WellnessMetricDescriptionsLong.highHbA1cRisk,
        isVitalActive: false,
      ),
      buildCard(
        vitalKey: VitalKeys.highFastingGlucoseRisk,
        imageAsset: CommonHealthAsset().gethighFastingGlucoseRiskAsset(
          statusHelper.getVitalStringStatus(
            VitalSignTypes.highFastingGlucoseRisk,
          ),
        ),
        vitalName: "High Fasting Glucose Risk",
        vitalValue: statusHelper.getVitalValue(
          VitalSignTypes.highFastingGlucoseRisk,
        ),
        vitalHeading:
            "Your ${WellnessMetricDescriptions.highFastingGlucoseRisk}",
        vitalDescription: WellnessMetricDescriptionsLong.highFastingGlucoseRisk,
        vitalStatus: getVitalValue(VitalSignTypes.highFastingGlucoseRisk),
        isVitalActive: false,
      ),
      buildCard(
        vitalKey: VitalKeys.highTotalCholesterolRisk,
        imageAsset: CommonHealthAsset().gethighCholesterolRiskAsset(
          statusHelper.getVitalStringStatus(
            VitalSignTypes.highTotalCholesterolRisk,
          ),
        ),
        vitalName: "High Total Cholesterol Risk",
        vitalValue: statusHelper.getVitalValue(
          VitalSignTypes.highTotalCholesterolRisk,
        ),
        vitalHeading:
            "Your ${WellnessMetricDescriptions.highTotalCholesterolRisk}",
        vitalDescription:
            WellnessMetricDescriptionsLong.highTotalCholesterolRisk,
        vitalStatus: getVitalValue(VitalSignTypes.highTotalCholesterolRisk),
        isVitalActive: false,
      ),
      buildCard(
        vitalKey: VitalKeys.lowHemoglobinRisk,
        imageAsset: CommonHealthAsset().getLowHemoglobinRiskAsset(
          statusHelper.getVitalStringStatus(VitalSignTypes.lowHemoglobinRisk),
        ),
        vitalName: "Low Hemoglobin Risk",
        vitalValue: statusHelper.getVitalValue(
          VitalSignTypes.lowHemoglobinRisk,
        ),
        vitalHeading: "Your ${WellnessMetricDescriptions.lowHemoglobinRisk}",
        vitalDescription: WellnessMetricDescriptionsLong.lowHemoglobinRisk,
        vitalStatus: statusHelper.getVitalValue(
          VitalSignTypes.lowHemoglobinRisk,
        ),
        isVitalActive: false,
      ),
    ];
  }

  List<Widget> stress() {
    // Get the raw value as a String
    final normalizedStressValueStr = statusHelper.getVitalValue(
      VitalSignTypes.normalizedStressIndex,
    );

    // Parse it to double for evaluation
    final normalizedStressValue = double.tryParse(
      normalizedStressValueStr ?? '',
    );
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
        vitalKey: VitalKeys.stressLevel,
        vitalName: "Stress Level",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.stressLevel),
        vitalCondition: '',
        vitalMass: "",
        vitalStatus: statusHelper.getVitalValue(VitalSignTypes.stressLevel),
        vitalHeading: "Your ${WellnessMetricDescriptions.stressLevel}",
        vitalDescription: WellnessMetricDescriptionsLong.stressLevel,
        isExpand: true,
        isVitalActive: false,
        imageAsset: CommonHealthAsset().getStressLevelAsset(
          statusHelper.getVitalStringStatus(VitalSignTypes.stressLevel),
        ),
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'Baevsky Stress Index',
              isExpanded: true,
              titleText: "Baevsky Stress Index",
              statusText:
                  "Your Baevsky Stress Index is ${_getVitalStressIndexStatus(VitalSignTypes.stressIndex).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.stressIndex),
              unitText: " ",
              imageAsset: CommonHealthAsset().getStressLevelAsset(
                _getVitalStressIndexStatus(VitalSignTypes.stressIndex),
              ),
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.stressIndex},
                );
              },
            ),
            StressInfoCard(
              vitalName: 'Normalized Stress Index',
              isExpanded: true,
              titleText: "Normalized Stress Index",
              statusText:
                  "Your Normalized Stress Index is ${stressLevel.toFirstCaps()}",
              valueText: normalizedStressValueStr,
              unitText: "%",
              imageAsset: CommonHealthAsset().getmediumizedStressIndexAsset(
                _getVitalStatusTwo(VitalSignTypes.normalizedStressIndex),
              ),
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.normalizedStressIndex},
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> heartRateVariability() {
    return [
      buildCard(
        vitalConfidence: VitalSignHelper().vitalSignSDNNConfidence(),
        vitalKey: VitalKeys.sdnn,
        imageAsset: CommonHealthAsset().getHrvSdnnAsset(
          _getVitalStatus(VitalSignTypes.sdnn, 50, 100),
        ),
        vitalName: "HRV SDNN",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.sdnn),
        vitalCondition: '',
        vitalMass: "ms",
        vitalStatus: _getVitalStatus(VitalSignTypes.sdnn, 50, 100),
        vitalHeading: "Your ${WellnessMetricDescriptions.hrvSdnn}",
        vitalDescription: WellnessMetricDescriptionsLong.hrvSDNN,
        isExpand: true,
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalConfidenceLevel:
                  VitalSignHelper().vitalSignMeanRriConfidence(),
              vitalName: 'Mean R-R Interval',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.meanRRi,
              statusText:
                  "Your Mean RRI is ${_getVitalStatus(VitalSignTypes.meanRri, 600, 1000).toFirstCaps()}", //need to get it with avg
              valueText: statusHelper.getVitalValue(VitalSignTypes.meanRri),
              imageAsset: CommonHealthAsset().getMeanRRiAsset(
                _getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
              ),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.meanRri},
                );
              },
            ),

            StressInfoCard(
              vitalName: 'RMSSD',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.rmssd,
              statusText:
                  "Your RMSSD is ${_getVitalStatus(VitalSignTypes.rmssd, 25, 43).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.rmssd),
              imageAsset: CommonHealthAsset().getRmssdAsset(
                _getVitalStatus(VitalSignTypes.rmssd, 25, 43),
              ),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.rmssd},
                );
              },
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
        vitalKey: VitalKeys.pnsZone,
        imageAsset: CommonHealthAsset().getRecoveryAbilityAsset(
          statusHelper.getVitalStringStatus(VitalSignTypes.pnsZone),
        ),
        vitalName: "Recovery Ability (PNS Zone)",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.pnsZone),
        vitalCondition: '',
        vitalStatus: statusHelper.getVitalValue(VitalSignTypes.pnsZone),
        vitalHeading: "Your ${WellnessMetricDescriptions.recoveryAbility}",
        vitalDescription: WellnessMetricDescriptionsLong.recoveryAbility,
        isExpand: true,
        isVitalActive: false,
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'PNS Index',
              isExpanded: true,
              titleText: "PNS Index",
              statusText:
                  "Your PNS Index is ${statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
              unitText: " ",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.pnsIndex},
                );
              },
              imageAsset: CommonHealthAsset().getPnsIndexAsset(
                statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1),
              ),
            ),
            StressInfoCard(
              vitalName: 'RMSSD',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.rmssd,
              statusText:
                  "Your RMSSD is ${_getVitalStatus(VitalSignTypes.rmssd, 25, 43).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.rmssd),
              imageAsset: CommonHealthAsset().getRmssdAsset(
                _getVitalStatus(VitalSignTypes.rmssd, 25, 43),
              ),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.rmssd},
                );
              },
            ),
            StressInfoCard(
              vitalConfidenceLevel:
                  VitalSignHelper().vitalSignMeanRriConfidence(),
              vitalName: 'Mean RRi',
              isExpanded: true,
              titleText: WellnessMetricDescriptions.meanRRi,
              statusText:
                  "Your Mean RRi is ${_getVitalStatus(VitalSignTypes.meanRri, 600, 1000).toFirstCaps()}", //need to get it with avg
              valueText: statusHelper.getVitalValue(VitalSignTypes.meanRri),
              imageAsset: CommonHealthAsset().getMeanRRiAsset(
                _getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
              ),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.meanRri},
                );
              },
            ),
            StressInfoCard(
              vitalName: 'SD1',
              isExpanded: true,
              titleText: "SD1",
              statusText:
                  "Your SD1 is ${_getVitSDStatus(VitalSignTypes.sd1, 16, 48).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.sd1),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.sd1},
                );
              },
              imageAsset: CommonHealthAsset().getSD1Asset(
                _getVitSDStatus(VitalSignTypes.sd1, 16, 48),
              ),
            ),
          ],
        ),
      ),

      buildCard(
        vitalKey: VitalKeys.snsZone,
        imageAsset: CommonHealthAsset().getSnsIndexAsset(
          statusHelper.getVitalStringStatus(VitalSignTypes.snsZone),
        ),
        vitalName: "Stress Response (SNS Zone) ",
        vitalValue: statusHelper.getVitalValue(VitalSignTypes.snsZone),
        vitalCondition: '',
        vitalStatus: getVitalValue(VitalSignTypes.snsZone),
        vitalHeading: "Your ${WellnessMetricDescriptions.snsZone}",
        vitalDescription: WellnessMetricDescriptionsLong.snsZone,
        isVitalActive: false,
        isExpand: true,
        expandedWidget: Column(
          children: [
            StressInfoCard(
              vitalName: 'SNS Index',
              isExpanded: true,
              titleText: "SNS Index",
              statusText:
                  "Your SNS Index is ${_getVitalStatus(VitalSignTypes.snsIndex, -1, 1).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.snsIndex),
              unitText: " ",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.snsIndex},
                );
              },
              imageAsset: CommonHealthAsset().getSnsIndexAsset(
                _getVitalStatus(VitalSignTypes.snsIndex, -1, 1),
              ),
            ),
            StressInfoCard(
              vitalName: 'Heart Rate',
              isExpanded: true,
              titleText: "Heart Rate",
              statusText:
                  "Your Heart Rate is ${statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
              unitText: "bpm",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.pulseRate},
                );
              },
              imageAsset: CommonHealthAsset().getPulseRateAsset(
                statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
              ),
            ),
            StressInfoCard(
              vitalName: 'Baevsky Stress Index',
              isExpanded: true,
              titleText: "Baevsky Stress Index",
              statusText:
                  "Your Baevsky Stress Index is ${_getVitalStressIndexStatus(VitalSignTypes.stressIndex).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.stressIndex),
              unitText: " ",
              imageAsset: CommonHealthAsset().getStressLevelAsset(
                _getVitalStressIndexStatus(VitalSignTypes.stressIndex),
              ),
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.stressIndex},
                );
              },
            ),
            StressInfoCard(
              vitalName: 'SD2',
              isExpanded: true,
              titleText: "SD2",
              statusText:
                  "Your SD2 is ${_getVitSDStatus(VitalSignTypes.sd2, 52, 84).toFirstCaps()}",
              valueText: statusHelper.getVitalValue(VitalSignTypes.sd2),
              unitText: "ms",
              onTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": VitalKeys.sd2},
                );
              },
              imageAsset: CommonHealthAsset().getSD2Asset(
                _getVitSDStatus(VitalSignTypes.sd2, 52, 84),
              ),
            ),
          ],
        ),
      ),

      // buildCard(
      //   vitalKey: VitalKeys.lfhf,
      //   imageAsset: CommonHealthAsset().getLfHfAsset(
      //     _getVitalStatus(VitalSignTypes.lfhf, 0.5, 2),
      //   ),
      //   vitalName: "LF/HF",
      //   vitalMass: '',
      //   vitalValue: statusHelper.getVitalValue(VitalSignTypes.lfhf),
      //   vitalCondition: '',
      //   vitalStatus: _getVitalStatus(VitalSignTypes.lfhf, 0.5, 2),
      //   vitalHeading: "Your ${WellnessMetricDescriptions.lfhf}",
      //   vitalDescription: WellnessMetricDescriptionsLong.lfHf,
      //   isVitalActive: true,
      // ),
    ];
  }

  String _getVitalStatus(vitalType, num min, num max) {
    final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < min) return 'low';
    if (value > max) return 'high';
    return 'normal';
  }

  String _getVitalStatusTwo(vitalType) {
    final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value <= 29) return 'low';
    if (value <= 40) return "normal";
    if (value <= 67) return "mild";
    if (value <= 97) return "high";
    if (value > 97) return "very High";
    return 'medium';
  }

  String _getVitalStressIndexStatus(vitalType) {
    final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value <= 80) return 'low';
    if (value <= 150) return "normal";
    if (value <= 300) return "mild";
    if (value <= 600) return "high";
    if (value >= 601) return "very High";
    return 'medium';
  }

  String _getVitSDStatus(vitalType, minValue, maxValue) {
    final rawValue = statusHelper.getVitalValue(vitalType ?? 0);
    final value = double.tryParse(rawValue);
    if (value == null) return '';
    if (value < minValue) return 'low';
    if (value <= maxValue) return "normal";
    // if (value <= 600) return "high";
    return 'high';
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

  List<Widget> barWidgets = [];

  @override
  Widget build(BuildContext context) {
    barWidgets = [
      if (_measurementController.scanType.value != "add-guest" &&
          _measurementController.scanType.value != "re-scan")
        SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(children: withSpacing(allCardsWithSpacing())),
        ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(basicVitalSignsWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(bloodlessBloodTestsWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(risksWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(stressWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: withSpacing(heartRateVariabilityWithSpacing())),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: withSpacing(advancedHeartRateVariabilityWithSpacing()),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.btntext,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: true,
        title: "Health data report",
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomTabBarView(
          isNotRadius: false,
          tabWidgets:
              (_measurementController.scanType.value != "add-guest" &&
                      _measurementController.scanType.value != "re-scan")
                  ? AppMethods.tabWidgets
                  : AppMethods.tabGuestWidget,
          tabBarWidgets: barWidgets,
          tabController: _tabController,
          onTabChanged: (index) {
            if (_measurementController.scanType.value == "add-guest" ||
                _measurementController.scanType.value == "re-scan") {
              if (index > 0) {
                BottomsheetHelper.showBottomSheetAlert(context, _tabController);
              }
            }
          },
        ),
      ),
    );
  }

  List<Widget> basicVitalSignsWithSpacing() {
    return withSpacing(basicVitalSigns());
  }

  List<Widget> bloodlessBloodTestsWithSpacing() {
    return withSpacing(bloodlessBloodTests());
  }

  List<Widget> risksWithSpacing() {
    return withSpacing(risks());
  }

  List<Widget> stressWithSpacing() {
    return withSpacing(stress());
  }

  List<Widget> heartRateVariabilityWithSpacing() {
    return withSpacing(heartRateVariability());
  }

  List<Widget> advancedHeartRateVariabilityWithSpacing() {
    return withSpacing(advancedHeartRateVariability());
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
