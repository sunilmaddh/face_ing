import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/health_data/widgets/circle_progress_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/test_main.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class AllReportScreen extends StatelessWidget {
  AllReportScreen({super.key});
  final _measurementController = Get.find<MeasurementController>();

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() {
    //   Map<String, String> vitalData = {
    //     "vitalResult": _measurementController.vitlaList,
    //   };
    // });
    return Scaffold(
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        isCenterTitle: false,
        title: "Analyzing health data",
        textColor: AppColors.blackColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: CommonCard(
            color: AppColors.cardBackgroundColor,
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndoCommonCard(
                    vitalName: "Wellness Score",
                    vitalValue: getVitalValue(VitalSignTypes.wellnessIndex),
                    // vitalMass: getVitalValue(VitalSignTypes.wellnessIndex),
                    vitalHeading: WellnessMetricDescriptions.wellnessScore,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.wellnessScore,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Breathing Rate",
                    vitalValue: getVitalValue(VitalSignTypes.respirationRate),
                    vitalMass: "rpm",
                    vitalHeading: WellnessMetricDescriptions.breathingRate,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.breathingRate,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Pulse rate (Heart Rate)",
                    vitalValue: getVitalValue(VitalSignTypes.respirationRate),
                    vitalMass: "bpm",
                    vitalHeading: WellnessMetricDescriptions.pulseRate,
                    vitalDescription: WellnessMetricDescriptionsLong.pulseRate,
                  ),
                  const SizedBox(height: 20),
                  // IndoCommonCard(
                  //   vitalName: "Pulse rate (Heart Rate)",
                  //   vitalValue: getVitalValue(VitalSignTypes.respirationRate),
                  //   vitalMass: "bpm",
                  //   vitalHeading: "",
                  // ),
                  // const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "PRQ",
                    vitalValue: getVitalValue(VitalSignTypes.prq),
                    vitalMass: "bpm",
                    vitalHeading: WellnessMetricDescriptions.prq,
                    vitalDescription: WellnessMetricDescriptionsLong.prq,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Blood Pressure",
                    vitalValue: getVitalValue(VitalSignTypes.bloodPressure),
                    vitalMass: "mmHg",
                    vitalHeading:
                        WellnessMetricDescriptions.bloodPressureDiastolic,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.bpDiastolic,
                  ),

                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Oxygen Saturation",
                    vitalValue: getVitalValue(VitalSignTypes.oxygenSaturation),
                    vitalMass: "%",
                    vitalHeading: WellnessMetricDescriptions.oxygenSaturation,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.oxygenSaturation,
                  ),

                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Hemoglobin",
                    vitalValue: getVitalValue(VitalSignTypes.hemoglobin),
                    vitalMass: "g/dL",
                    vitalHeading: WellnessMetricDescriptions.hemoglobin,
                    vitalDescription: WellnessMetricDescriptionsLong.hemoglobin,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "HemoglobinA1C",
                    vitalValue: getVitalValue(VitalSignTypes.hemoglobinA1C),
                    vitalMass: "%",
                    vitalHeading: WellnessMetricDescriptions.hemoglobinA1C,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.hemoglobinA1C,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName:
                        "ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)",
                    vitalValue: getVitalValue(VitalSignTypes.ascvdRisk),
                    vitalMass: "%",
                    vitalHeading: WellnessMetricDescriptions.ascvdRisk,
                    vitalDescription: WellnessMetricDescriptionsLong.ascvdRisk,
                  ),
                  const SizedBox(height: 20),

                  IndoCommonCard(
                    vitalName: "Heart Age (biological heart age estimation)",
                    vitalValue: getVitalValue(VitalSignTypes.heartAge),
                    vitalMass: "years",
                    vitalHeading: WellnessMetricDescriptions.heartAge,
                    vitalDescription: WellnessMetricDescriptionsLong.heartAge,
                  ),
                  const SizedBox(height: 20),

                  IndoCommonCard(
                    vitalName: "High Blood Pressure Risk",
                    vitalValue: getVitalValue(
                      VitalSignTypes.highBloodPressureRisk,
                    ),

                    vitalDescription:
                        WellnessMetricDescriptionsLong.highBloodPressureRisk,

                    vitalHeading:
                        WellnessMetricDescriptions.highBloodPressureRisk,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "High Hemoglobin A1C Risk",
                    vitalValue: getVitalValue(
                      VitalSignTypes.highHemoglobinA1CRisk,
                    ),
                    vitalDescription:
                        WellnessMetricDescriptionsLong.highHbA1cRisk,

                    vitalHeading: WellnessMetricDescriptions.highHbA1cRisk,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "High Fasting Glucose Risk",
                    vitalValue: getVitalValue(
                      VitalSignTypes.highFastingGlucoseRisk,
                    ),
                    vitalDescription:
                        WellnessMetricDescriptionsLong.highFastingGlucoseRisk,

                    vitalHeading:
                        WellnessMetricDescriptions.highFastingGlucoseRisk,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "High Total Cholesterol Risk",
                    vitalValue: getVitalValue(
                      VitalSignTypes.highTotalCholesterolRisk,
                    ),

                    vitalDescription:
                        WellnessMetricDescriptionsLong.highTotalCholesterolRisk,

                    vitalHeading:
                        WellnessMetricDescriptions.highTotalCholesterolRisk,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Low Hemoglobin Risk (anemia risk)",
                    vitalValue: getVitalValue(VitalSignTypes.lowHemoglobinRisk),

                    vitalHeading: WellnessMetricDescriptions.lowHemoglobinRisk,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.lowHemoglobinRisk,
                  ),
                  const SizedBox(height: 20),

                  IndoCommonCard(
                    vitalName: "Stress",
                    vitalValue: getVitalValue(VitalSignTypes.stressIndex),

                    vitalHeading: WellnessMetricDescriptions.stressIndex,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.stressIndex,
                    vitalMass: "%",
                  ),
                  const SizedBox(height: 20),

                  IndoCommonCard(
                    vitalName: "HRV SDNN",
                    vitalValue: getVitalValue(VitalSignTypes.sdnn),

                    vitalHeading: WellnessMetricDescriptions.hrvSdnn,
                    vitalDescription: WellnessMetricDescriptionsLong.hrvSDNN,
                    vitalMass: "ms",
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Mean R-R Interval",
                    vitalValue: getVitalValue(VitalSignTypes.meanRri),

                    vitalHeading: WellnessMetricDescriptions.meanRRi,
                    vitalDescription: WellnessMetricDescriptionsLong.meanRRi,
                    vitalMass: "ms",
                  ),
                  const SizedBox(height: 20),

                  IndoCommonCard(
                    vitalName: "RMSSD",
                    vitalValue: getVitalValue(VitalSignTypes.rmssd),
                    vitalMass: "ms",

                    vitalHeading: WellnessMetricDescriptions.rmssd,
                    vitalDescription: WellnessMetricDescriptionsLong.rmssd,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Recovery Ability (PNS Zone)",
                    vitalValue: getVitalValue(VitalSignTypes.pnsZone),

                    vitalHeading: WellnessMetricDescriptions.recoveryAbility,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.recoveryAbility,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "PNS Index",
                    vitalValue: getVitalValue(VitalSignTypes.pnsIndex),

                    vitalHeading: WellnessMetricDescriptions.pnsIndex,
                    vitalDescription: WellnessMetricDescriptionsLong.pnsIndex,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "SNS Index",
                    vitalValue: getVitalValue(VitalSignTypes.snsIndex),

                    vitalHeading: WellnessMetricDescriptions.snsIndex,
                    vitalDescription: WellnessMetricDescriptionsLong.snsIndex,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "SD1",
                    vitalValue: getVitalValue(VitalSignTypes.sd1),
                    vitalMass: "ms",

                    vitalHeading: WellnessMetricDescriptions.sd1,
                    vitalDescription: WellnessMetricDescriptionsLong.sd1,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "SD2",
                    vitalValue: getVitalValue(VitalSignTypes.sd2),
                    vitalMass: "ms",

                    vitalHeading: WellnessMetricDescriptions.sd2,
                    vitalDescription: WellnessMetricDescriptionsLong.sd2,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "Stress Response (SNS Zone)",
                    vitalValue: getVitalValue(VitalSignTypes.sd2),

                    vitalHeading: WellnessMetricDescriptions.stressResponse,
                    vitalDescription:
                        WellnessMetricDescriptionsLong.stressResponse,
                  ),
                  const SizedBox(height: 20),
                  IndoCommonCard(
                    vitalName: "LF/HF Ratio",
                    vitalValue: getVitalValue(VitalSignTypes.sd2),

                    vitalHeading: WellnessMetricDescriptions.lfHf,
                    vitalDescription: WellnessMetricDescriptionsLong.lfHf,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getVitalValue(int type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final value = result?.value;
    if (value == null) return "null";
    if (value is num) return value.toStringAsFixed(1);
    return value.toString();
  }

  int getVitalValueInt(int type) {
    final result = _measurementController.vitalsResults.value.getResult(type);
    final val = result?.value;
    if (val == null) return 0;
    return val is int ? val : val.toInt();
  }
}
