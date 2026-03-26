import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/utils/enum/health_data_enum.dart';
import 'package:ntt_data/core/utils/enum/vital_key.dart';
import 'package:ntt_data/core/utils/extensions/extentions.dart';
import 'package:ntt_data/modules/binah/handler/vital_sign_helper.dart';
import 'package:ntt_data/modules/binah/helper/health_common_helper.dart';
import 'package:ntt_data/modules/binah/widgets/common_health_asset.dart';
import 'package:ntt_data/modules/binah/widgets/getvitalStatus.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/cards/stress_info_card.dart';

final statusHelper = Getvitalstatus();

class HealthReportHelper {
  List<Map<String, dynamic>> get allVitalCards => [
    ...basicVital,
    ...bloodlessVital,
    ...riskList,
    ...stress,
    ...hrvsddnList,
    ...adhrvsddnList,
  ];

  List<Map<String, dynamic>> get minimunVitalCards => [
    ...basicVital,
    ...bloodlessVital,
  ];

  List<Map<String, dynamic>> basicVital = [
    {
      "vitalKey": VitalKeys.wellnessIndex,
      "vitalName": HealthDataEnum.wellnessScore.name,
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.wellnessIndex),
      "vitalCondition": "",
      "vitalMass": "",
      "vitalStatus": statusHelper.getWellnessStatus(
        VitalSignTypes.wellnessIndex,
        5,
        7,
      ),
      "vitalHeading": "Your ${HealthDataEnum.wellnessScore.name}",
      "vitalDescription": HealthDataEnum.wellnessScore.description,
      "imageAsset": CommonHealthAsset().getWellnessAsset(
        statusHelper.getWellnessStatus(VitalSignTypes.wellnessIndex, 5, 7),
      ),
    },
    {
      "vitalConfidence": VitalSignHelper().vitalSignBreathingConfidence(),
      "vitalKey": VitalKeys.respirationRate,
      "vitalName": "Breathing Rate",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.respirationRate),
      "vitalCondition": "Avg 12 - 20",
      "vitalMass": "brpm",
      "vitalStatus": statusHelper.getBreathingRate(
        VitalSignTypes.respirationRate,
        12,
        20,
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.BreathingRate}",
      "vitalDescription": WellnessMetricDescriptionsLong.breathRate,
      "imageAsset": CommonHealthAsset().getBreathingRateAsset(
        statusHelper.getBreathingRate(VitalSignTypes.respirationRate, 12, 20),
      ),
    },
    {
      "vitalConfidence": VitalSignHelper().vitalSignPulseRateConfidence(),
      "vitalKey": VitalKeys.pulseRate,
      "vitalName": "Heart Rate",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pulseRate),
      "vitalCondition": "Avg 60 - 100",
      "vitalMass": "bpm",
      "vitalStatus": statusHelper.getPulseRate(
        VitalSignTypes.pulseRate,
        60,
        100,
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.pulseRate}",
      "vitalDescription": WellnessMetricDescriptionsLong.pulseRate,
      "imageAsset": CommonHealthAsset().getPulseRateAsset(
        statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
      ),
    },
    {
      "vitalConfidence": VitalSignHelper().vitalSignPrqConfidence(),
      "vitalKey": VitalKeys.prq,
      "vitalName": "PRQ",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.prq),
      "vitalCondition": "",
      "vitalMass": "",
      "vitalStatus": statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
      "vitalHeading": "Your ${WellnessMetricDescriptions.prq}",
      "vitalDescription": WellnessMetricDescriptionsLong.prq,
      "imageAsset": CommonHealthAsset().getPrqAsset(
        statusHelper.getPrq(VitalSignTypes.prq, 4, 5),
      ),
    },
    {
      "vitalKey": VitalKeys.bloodPressure,
      "vitalName": "Blood Pressure",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.bloodPressure),
      "vitalCondition": "Avg 100-129",
      "vitalMass": "mmHg",
      "vitalStatus": statusHelper.getBpSystolic(
        statusHelper.getSystolic(),
        100,
        129,
      ),
      "vitalHeading":
          "Your ${WellnessMetricDescriptions.bloodPressureDiastolic}",
      "vitalDescription": WellnessMetricDescriptionsLong.bpSystolic,
      "imageAsset": CommonHealthAsset().getSystolicBPAsset(
        statusHelper.getBpSystolic(statusHelper.getSystolic(), 100, 129),
      ),
    },
    {
      "vitalKey": VitalKeys.oxygenSaturation,
      "vitalName": "Oxygen Saturation",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.oxygenSaturation),
      "vitalCondition": "",
      "vitalMass": "%",
      "vitalStatus": statusHelper.getOxygenSaturation(
        VitalSignTypes.oxygenSaturation,
        94,
        95,
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.oxygenSaturation}",
      "vitalDescription": WellnessMetricDescriptionsLong.oxygenSaturation,
      "imageAsset": CommonHealthAsset().getOxygenSaturationAsset(
        statusHelper.getOxygenSaturation(
          VitalSignTypes.oxygenSaturation,
          94,
          95,
        ),
      ),
    },
  ];

  List<Map<String, dynamic>> bloodlessVital = [
    {
      "vitalKey": VitalKeys.hemoglobin,
      "vitalName": "Hemoglobin",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.hemoglobin),
      "vitalCondition": "",
      "vitalMass": "g/dL",
      "vitalStatus": statusHelper.getHemoglobin(
        VitalSignTypes.hemoglobin,
        HealthCommonHelper().homoGlobinMin(),
        HealthCommonHelper().homoGlobinMax(),
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.hemoglobin}",
      "vitalDescription": WellnessMetricDescriptionsLong.hemoglobin,
      "imageAsset": CommonHealthAsset().getHemoglobinAsset(
        statusHelper.getHemoglobin(
          VitalSignTypes.hemoglobin,
          HealthCommonHelper().homoGlobinMin(),
          HealthCommonHelper().homoGlobinMax(),
        ),
      ),
    },
    {
      "vitalKey": VitalKeys.hemoglobinA1c,
      "vitalName": "Hemoglobin A1C",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.hemoglobinA1C),
      "vitalCondition": "",
      "vitalMass": "%",
      "vitalStatus": HomoGlobinA1C().a1cConditionText,
      "vitalHeading": "Your ${WellnessMetricDescriptions.hemoglobinA1C}",
      "vitalDescription": WellnessMetricDescriptionsLong.hemoglobinA1C,
      "imageAsset": CommonHealthAsset().getHbA1cAsset(
        HomoGlobinA1C().a1cStatus,
      ),
    },
  ];
  List<Map<String, dynamic>> stress = [
    {
      "vitalKey": VitalKeys.stressLevel,
      "vitalName": "Stress Level",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
      "vitalCondition": "",
      "vitalMass": "",
      "vitalStatus": statusHelper.getVitalValue(VitalSignTypes.stressLevel),
      "vitalHeading": "Your ${WellnessMetricDescriptions.stressLevel}",
      "vitalDescription": WellnessMetricDescriptionsLong.stressLevel,
      "isExpand": true,
      "isVitalActive": false,
      "imageAsset": CommonHealthAsset().getStressLevelAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.stressLevel),
      ),
      "expandedWidget": Column(
        children: [
          StressInfoCard(
            vitalName: "Baevsky Stress Index",
            isExpanded: true,
            titleText: "Baevsky Stress Index",
            statusText:
                "Your Baevsky Stress Index is ${statusHelper.getVitalStressIndexStatus(VitalSignTypes.stressIndex).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.stressIndex),
            unitText: " ",
            imageAsset: CommonHealthAsset().getStressLevelAsset(
              statusHelper.getVitalStressIndexStatus(
                VitalSignTypes.stressIndex,
              ),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.stressIndex},
              );
            },
          ),

          StressInfoCard(
            vitalName: "Normalized Stress Index",
            isExpanded: true,
            titleText: "Normalized Stress Index",
            statusText:
                "Your Normalized Stress Index is ${statusHelper.getNormalizedStressLevel().toFirstCaps()}",
            valueText: statusHelper.getVitalValue(
              VitalSignTypes.normalizedStressIndex,
            ),
            unitText: "%",
            imageAsset: CommonHealthAsset().getmediumizedStressIndexAsset(
              statusHelper.getVitalStatusTwo(
                VitalSignTypes.normalizedStressIndex,
              ),
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
    },
  ];

  List<Map<String, dynamic>> hrvsddnList = [
    {
      "vitalConfidence": VitalSignHelper().vitalSignSDNNConfidence(),
      "vitalKey": VitalKeys.sdnn,
      "vitalName": "HRV SDNN",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.sdnn),
      "vitalCondition": "",
      "vitalMass": "ms",
      "vitalStatus": statusHelper.getVitalStatus(VitalSignTypes.sdnn, 50, 100),
      "vitalHeading": "Your ${WellnessMetricDescriptions.hrvSdnn}",
      "vitalDescription": WellnessMetricDescriptionsLong.hrvSDNN,
      "isExpand": true,
      "imageAsset": CommonHealthAsset().getHrvSdnnAsset(
        statusHelper.getVitalStatus(VitalSignTypes.sdnn, 50, 100),
      ),
      "expandedWidget": Column(
        children: [
          StressInfoCard(
            vitalConfidenceLevel:
                VitalSignHelper().vitalSignMeanRriConfidence(),
            vitalName: "Mean R-R Interval",
            isExpanded: true,
            titleText: WellnessMetricDescriptions.meanRRi,
            statusText:
                "Your Mean RRI is ${statusHelper.getVitalStatus(VitalSignTypes.meanRri, 600, 1000).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.meanRri),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getMeanRRiAsset(
              statusHelper.getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.meanRri},
              );
            },
          ),

          StressInfoCard(
            vitalName: "RMSSD",
            isExpanded: true,
            titleText: WellnessMetricDescriptions.rmssd,
            statusText:
                "Your RMSSD is ${statusHelper.getVitalStatus(VitalSignTypes.rmssd, 25, 43).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.rmssd),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getRmssdAsset(
              statusHelper.getVitalStatus(VitalSignTypes.rmssd, 25, 43),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.rmssd},
              );
            },
          ),
        ],
      ),
    },
  ];

  List<Map<String, dynamic>> adhrvsddnList = [
    {
      "vitalKey": VitalKeys.pnsZone,
      "vitalName": "Recovery Ability (PNS Zone)",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
      "vitalCondition": "",
      "vitalStatus": statusHelper.getVitalValue(VitalSignTypes.pnsZone),
      "vitalHeading": "Your ${WellnessMetricDescriptions.recoveryAbility}",
      "vitalDescription": WellnessMetricDescriptionsLong.recoveryAbility,
      "isExpand": true,
      "isVitalActive": false,
      "imageAsset": CommonHealthAsset().getRecoveryAbilityAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.pnsZone),
      ),
      "expandedWidget": Column(
        children: [
          StressInfoCard(
            vitalName: "PNS Index",
            isExpanded: true,
            titleText: "PNS Index",
            statusText:
                "Your PNS Index is ${statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.pnsIndex),
            unitText: " ",
            imageAsset: CommonHealthAsset().getPnsIndexAsset(
              statusHelper.getPnsIndex(VitalSignTypes.pnsIndex, -1, 1),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.pnsIndex},
              );
            },
          ),

          StressInfoCard(
            vitalName: "RMSSD",
            isExpanded: true,
            titleText: WellnessMetricDescriptions.rmssd,
            statusText:
                "Your RMSSD is ${statusHelper.getVitalStatus(VitalSignTypes.rmssd, 25, 43).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.rmssd),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getRmssdAsset(
              statusHelper.getVitalStatus(VitalSignTypes.rmssd, 25, 43),
            ),
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
            vitalName: "Mean RRi",
            isExpanded: true,
            titleText: WellnessMetricDescriptions.meanRRi,
            statusText:
                "Your Mean RRi is ${statusHelper.getVitalStatus(VitalSignTypes.meanRri, 600, 1000).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.meanRri),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getMeanRRiAsset(
              statusHelper.getVitalStatus(VitalSignTypes.meanRri, 600, 1000),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.meanRri},
              );
            },
          ),

          StressInfoCard(
            vitalName: "SD1",
            isExpanded: true,
            titleText: "SD1",
            statusText:
                "Your SD1 is ${statusHelper.getVitSDStatus(VitalSignTypes.sd1, 16, 48).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.sd1),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getSD1Asset(
              statusHelper.getVitSDStatus(VitalSignTypes.sd1, 16, 48),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.sd1},
              );
            },
          ),
        ],
      ),
    },
    {
      "vitalKey": VitalKeys.snsZone,
      "vitalName": "Stress Response (SNS Zone)",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.snsZone),
      "vitalCondition": "",
      "vitalStatus": statusHelper.getVitalValue(VitalSignTypes.snsZone),
      "vitalHeading": "Your ${WellnessMetricDescriptions.snsZone}",
      "vitalDescription": WellnessMetricDescriptionsLong.snsZone,
      "isExpand": true,
      "isVitalActive": false,
      "imageAsset": CommonHealthAsset().getSnsIndexAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.snsZone),
      ),
      "expandedWidget": Column(
        children: [
          StressInfoCard(
            vitalName: "SNS Index",
            isExpanded: true,
            titleText: "SNS Index",
            statusText:
                "Your SNS Index is ${statusHelper.getVitalStatus(VitalSignTypes.snsIndex, -1, 1).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.snsIndex),
            unitText: " ",
            imageAsset: CommonHealthAsset().getSnsIndexAsset(
              statusHelper.getVitalStatus(VitalSignTypes.snsIndex, -1, 1),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.snsIndex},
              );
            },
          ),

          StressInfoCard(
            vitalName: "Heart Rate",
            isExpanded: true,
            titleText: "Heart Rate",
            statusText:
                "Your Heart Rate is ${statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.pulseRate),
            unitText: "bpm",
            imageAsset: CommonHealthAsset().getPulseRateAsset(
              statusHelper.getPulseRate(VitalSignTypes.pulseRate, 60, 100),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.pulseRate},
              );
            },
          ),

          StressInfoCard(
            vitalName: "Baevsky Stress Index",
            isExpanded: true,
            titleText: "Baevsky Stress Index",
            statusText:
                "Your Baevsky Stress Index is ${statusHelper.getVitalStressIndexStatus(VitalSignTypes.stressIndex).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.stressIndex),
            unitText: " ",
            imageAsset: CommonHealthAsset().getStressLevelAsset(
              statusHelper.getVitalStressIndexStatus(
                VitalSignTypes.stressIndex,
              ),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.stressIndex},
              );
            },
          ),

          StressInfoCard(
            vitalName: "SD2",
            isExpanded: true,
            titleText: "SD2",
            statusText:
                "Your SD2 is ${statusHelper.getVitSDStatus(VitalSignTypes.sd2, 52, 84).toFirstCaps()}",
            valueText: statusHelper.getVitalValue(VitalSignTypes.sd2),
            unitText: "ms",
            imageAsset: CommonHealthAsset().getSD2Asset(
              statusHelper.getVitSDStatus(VitalSignTypes.sd2, 52, 84),
            ),
            onTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": VitalKeys.sd2},
              );
            },
          ),
        ],
      ),
    },
  ];

  final List<Map<String, dynamic>> riskList = [
    {
      "vitalKey": VitalKeys.ascvdRisk,
      "imageAsset": CommonHealthAsset().getAscvdRiskAsset(
        statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
      ),
      "vitalName": "ASCVD Risk",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.ascvdRisk),
      "vitalCondition": "",
      "vitalMass": "%",
      "vitalStatus": statusHelper.getASCVDRisk(VitalSignTypes.ascvdRisk, 1, 30),
      "vitalHeading": "Your ${WellnessMetricDescriptions.ascvdRisk}",
      "vitalDescription": WellnessMetricDescriptionsLong.ascvdRisk,
    },
    {
      "vitalKey": VitalKeys.heartAge,
      "vitalName": "Heart Age",
      "vitalValue": statusHelper.getVitalValue(VitalSignTypes.heartAge),
      "vitalMass": "years",
      "vitalStatus": "",
      "vitalHeading": "",
      "vitalDescription": WellnessMetricDescriptionsLong.heartAge,
    },
    {
      "vitalKey": VitalKeys.highBloodPressureRisk,
      "imageAsset": CommonHealthAsset().gethighBPRiskAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.highBloodPressureRisk),
      ),
      "vitalName": "High Blood Pressure Risk",
      "vitalValue": statusHelper.getVitalValue(
        VitalSignTypes.highBloodPressureRisk,
      ),
      "vitalHeading":
          "Your ${WellnessMetricDescriptions.highBloodPressureRisk}",
      "vitalDescription": WellnessMetricDescriptionsLong.highBloodPressureRisk,
      "vitalStatus": statusHelper.getVitalValue(
        VitalSignTypes.highBloodPressureRisk,
      ),
      "vitalMass": "",
      "vitalCondition": "",
      "isVitalActive": false,
    },
    {
      "vitalKey": VitalKeys.highHemoglobinA1cRisk,
      "imageAsset": CommonHealthAsset().getHbA1cAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.highHemoglobinA1CRisk),
      ),
      "vitalName": "High HbA1c Risk",
      "vitalValue": statusHelper.getVitalValue(
        VitalSignTypes.highHemoglobinA1CRisk,
      ),
      "vitalCondition": "",
      "vitalStatus": statusHelper.getVitalValue(
        VitalSignTypes.highHemoglobinA1CRisk,
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.highHbA1cRisk}",
      "vitalDescription": WellnessMetricDescriptionsLong.highHbA1cRisk,
      "isVitalActive": false,
    },
    {
      "vitalKey": VitalKeys.highFastingGlucoseRisk,
      "imageAsset": CommonHealthAsset().gethighFastingGlucoseRiskAsset(
        statusHelper.getVitalStringStatus(
          VitalSignTypes.highFastingGlucoseRisk,
        ),
      ),
      "vitalName": "High Fasting Glucose Risk",
      "vitalValue": statusHelper.getVitalValue(
        VitalSignTypes.highFastingGlucoseRisk,
      ),
      "vitalHeading":
          "Your ${WellnessMetricDescriptions.highFastingGlucoseRisk}",
      "vitalDescription": WellnessMetricDescriptionsLong.highFastingGlucoseRisk,
      "vitalStatus": statusHelper.getVitalValue(
        VitalSignTypes.highFastingGlucoseRisk,
      ),
      "isVitalActive": false,
    },
    {
      "vitalKey": VitalKeys.highTotalCholesterolRisk,
      "imageAsset": CommonHealthAsset().gethighCholesterolRiskAsset(
        statusHelper.getVitalStringStatus(
          VitalSignTypes.highTotalCholesterolRisk,
        ),
      ),
      "vitalName": "High Total Cholesterol Risk",
      "vitalValue": statusHelper.getVitalValue(
        VitalSignTypes.highTotalCholesterolRisk,
      ),
      "vitalHeading":
          "Your ${WellnessMetricDescriptions.highTotalCholesterolRisk}",
      "vitalDescription":
          WellnessMetricDescriptionsLong.highTotalCholesterolRisk,
      "vitalStatus": statusHelper.getVitalValue(
        VitalSignTypes.highTotalCholesterolRisk,
      ),
      "isVitalActive": false,
    },
    {
      "vitalKey": VitalKeys.lowHemoglobinRisk,
      "imageAsset": CommonHealthAsset().getLowHemoglobinRiskAsset(
        statusHelper.getVitalStringStatus(VitalSignTypes.lowHemoglobinRisk),
      ),
      "vitalName": "Low Hemoglobin Risk",
      "vitalValue": statusHelper.getVitalValue(
        VitalSignTypes.lowHemoglobinRisk,
      ),
      "vitalHeading": "Your ${WellnessMetricDescriptions.lowHemoglobinRisk}",
      "vitalDescription": WellnessMetricDescriptionsLong.lowHemoglobinRisk,
      "vitalStatus": statusHelper.getVitalValue(
        VitalSignTypes.lowHemoglobinRisk,
      ),
      "isVitalActive": false,
    },
  ];
}
