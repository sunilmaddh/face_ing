import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/modules/views/health_data/widgets/circle_progress_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class AllReportScreen extends StatelessWidget {
  AllReportScreen({super.key});
  final _measurementController = Get.find<MeasurementController>();

  @override
  Widget build(BuildContext context) {
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
                  ReportCard(
                    height: 190,
                    image: AppAssets.wellnessImage,
                    title: "Wellness Score",
                    value: getVitalValue(VitalSignTypes.wellnessIndex),
                    mass: getVitalValue(VitalSignTypes.wellnessLevel),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          height: 190,
                          isTextOnly: true,
                          title: "Breathing Rate",
                          value: getVitalValue(VitalSignTypes.respirationRate),
                          mass: "rpm",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          image: AppAssets.heartRate,
                          height: 190,
                          title: "Pulse rate (Heart Rate)",
                          value: getVitalValue(VitalSignTypes.oxygenSaturation),
                          mass: "bpm",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: CircleProgressCard(
                          size: 75,
                          progress: getVitalValueInt(VitalSignTypes.prq),
                          age: getVitalValueInt(VitalSignTypes.prq),
                          maxProgress: 10,
                          borderColor: Color(0xFFFFFDDF),
                          drawArcColor: Color(0xFFF7D100),
                          title: 'PRQ',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "Oxygen Saturation",
                          value:
                              "${getVitalValue(VitalSignTypes.oxygenSaturation)} %",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CircleProgressCard(
                    height: 220,
                    imageWidth: MediaQuery.of(context).size.width,
                    value: getVitalValue(VitalSignTypes.bloodPressure),
                    mass: "mmHg",
                    title: 'Blood Pressure ',
                    bottomImage: AppAssets.stressLevel,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          centerImage: AppAssets.homoglobin,
                          height: 190,
                          title: "Hemoglobin",
                          value: getVitalValue(VitalSignTypes.hemoglobin),
                          mass: "g/dL",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          centerImage: AppAssets.homoglobin,
                          height: 190,
                          title: "HemoglobinA1C",
                          value:
                              "${getVitalValue(VitalSignTypes.hemoglobinA1C)} %",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CircleProgressCard(
                    height: 270,
                    imageWidth: 190,
                    value: "${getVitalValue(VitalSignTypes.ascvdRisk)} %",
                    borderColor: Color(0xFF0072BC).withOpacity(0.2),
                    drawArcColor: Color(0xFF0072BC),
                    title:
                        'ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)',
                    bottomImage: AppAssets.goodImage,
                  ),
                  const SizedBox(height: 20),
                  CircleProgressCard(
                    height: 240,
                    imageWidth: MediaQuery.of(context).size.width,
                    value: getVitalValue(VitalSignTypes.heartAge),
                    mass: "years",
                    borderColor: Color(0xFF0072BC).withOpacity(0.2),
                    drawArcColor: Color(0xFF0072BC),
                    title: 'Heart Age (biological heart age estimation)',
                    bottomImage: AppAssets.heartAge,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "High Blood Pressure Risk",
                          value: getVitalValue(
                            VitalSignTypes.highBloodPressureRisk,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "High Hemoglobin A1C Risk",
                          value: getVitalValue(
                            VitalSignTypes.highHemoglobinA1CRisk,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "High Fasting Glucose Risk",
                          value: getVitalValue(
                            VitalSignTypes.highFastingGlucoseRisk,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "High Total Cholesterol Risk",
                          value: getVitalValue(
                            VitalSignTypes.highTotalCholesterolRisk,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReportCard(
                    isTextOnly: true,
                    height: 170,
                    title: "Low Hemoglobin Risk (anemia risk)",
                    value: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "Stress Level",
                          value: getVitalValue(VitalSignTypes.stressLevel),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "Stress Index",
                          value: getVitalValue(VitalSignTypes.stressIndex),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "Normalized Stress Index",
                          value:
                              "${getVitalValue(VitalSignTypes.normalizedStressIndex)} %",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "HRV SDNN ",
                          value: getVitalValue(VitalSignTypes.sdnn),
                          mass: "ms",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "Mean R-R Interval",
                          value: getVitalValue(VitalSignTypes.meanRri),
                          mass: "ms",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          isTextOnly: true,
                          height: 190,
                          title: "RMSSD",
                          value: getVitalValue(VitalSignTypes.rmssd),
                          mass: "ms",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: ReportCard(
                          backgroundImage: AppAssets.pnsImage,
                          height: 190,
                          title: "Recovery Ability (PNS Zone)",
                          value: getVitalValue(VitalSignTypes.pnsZone),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ReportCard(
                          backgroundImage: AppAssets.pnsImage,
                          height: 190,
                          title: "PNS Index",
                          value: getVitalValue(VitalSignTypes.pnsIndex),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReportCard(
                    backgroundImage: AppAssets.snsImage,
                    height: 190,
                    title: "SNS Index",
                    value: getVitalValue(VitalSignTypes.snsIndex),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: CircleProgressCard(
                          height: 190,
                          size: 75,
                          progress: getVitalValueInt(VitalSignTypes.sd1),
                          age: getVitalValueInt(VitalSignTypes.sd1),
                          maxProgress: 10,
                          mass: "ms",
                          borderColor: Color(0xFF0072BC).withOpacity(0.2),
                          drawArcColor: Color(0xFF0072BC),
                          title: 'SD1',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: CircleProgressCard(
                          size: 75,
                          progress: getVitalValueInt(VitalSignTypes.sd2),
                          age: getVitalValueInt(VitalSignTypes.sd2),
                          maxProgress: 10,
                          mass: "ms",
                          borderColor: Color(0xFF0072BC).withOpacity(0.2),
                          drawArcColor: Color(0xFF0072BC),
                          title: 'SD2',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CircleProgressCard(
                    height: 240,
                    imageWidth: MediaQuery.of(context).size.width,
                    value: getVitalValue(VitalSignTypes.snsZone),
                    title: 'Stress Response (SNS Zone)',
                    bottomImage: AppAssets.stressLevel,
                  ),
                  const SizedBox(height: 20),
                  ReportCard(
                    centerImage: AppAssets.lhRatioImage,
                    height: 190,
                    title: "LF/HF Ratio",
                    value: getVitalValue(VitalSignTypes.lfhf),
                  ),
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
