import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/health_data/widgets/circle_progress_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class AllReportScreen extends StatelessWidget {
  AllReportScreen({super.key});
  final _mesurementController = Get.find<MeasurementController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CommonCard(
          color: AppColors.cardBackgroundColor,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ReportCard(
                      height: 190,
                      backgroundImage: AppAssets.wellnessImage,
                      title: "Wellness Index",
                      value: getVitalValue(VitalSignTypes.wellnessIndex),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: ReportCard(
                            height: 220,
                            isTextOnly: true,
                            value: getVitalValue(VitalSignTypes.prq),
                            mass: "rpm",

                            title: 'Breathing Rate',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            centerImage: AppAssets.heartRate,
                            height: 230,
                            title: "Heart Rate",
                            value: getVitalValue(
                              VitalSignTypes.oxygenSaturation,
                            ),
                            mass: "bpm",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: CircleProgressCard(
                            size: 75,
                            progress: getVitalValueInt(VitalSignTypes.prq),
                            age: getVitalValueInt(VitalSignTypes.prq),

                            maxProgress: 10,
                            borderColor: Color(0xFFFFFDDF),
                            drawArcColor: Color(0xFFF7D100),
                            title: 'Pulse Respiration Quotient (PRQ)',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            isTextOnly: true,
                            height: 230,
                            title: "Oxygen Saturation",
                            value: getVitalValue(
                              VitalSignTypes.oxygenSaturation,
                            ),
                            mass: "%",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      flex: 1,
                      child: CircleProgressCard(
                        height: 240,
                        imageWidth: MediaQuery.of(context).size.width,
                        value: getVitalValue(VitalSignTypes.bloodPressure),
                        mass: "mmHg",

                        title: 'Blood Pressure ',
                        bottomImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            centerImage: AppAssets.homoglobin,
                            height: 190,
                            title: "Hemoglobin",
                            value: getVitalValue(VitalSignTypes.hemoglobin),
                            mass: "%",
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            centerImage: AppAssets.homoglobin,
                            height: 190,
                            title: "HemoglobinA1C",
                            value: getVitalValue(VitalSignTypes.hemoglobinA1C),
                            mass: "%",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: CircleProgressCard(
                        height: 270,
                        imageWidth: 190,
                        value: getVitalValue(VitalSignTypes.ascvdRisk),
                        mass: "%",
                        borderColor: Color(0xFF0072BC).withOpacity(0.2),
                        drawArcColor: Color(0xFF0072BC),
                        title:
                            'ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)',
                        bottomImage: AppAssets.goodImage,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: CircleProgressCard(
                        height: 240,
                        imageWidth: MediaQuery.of(context).size.width,
                        value: getVitalValue(VitalSignTypes.heartAge),
                        mass: "years",
                        borderColor: Color(0xFF0072BC).withOpacity(0.2),
                        drawArcColor: Color(0xFF0072BC),
                        title: 'Heart Age (biological heart age estimation)',
                        bottomImage: AppAssets.heartAge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
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
                        Expanded(
                          flex: 1,
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
                        Expanded(
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
                      height: 190,
                      title: "Low Hemoglobin Risk (anemia risk)",
                      value: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: ReportCard(
                              isTextOnly: true,
                              height: 190,
                              title: "Stress Level",
                              value: getVitalValue(VitalSignTypes.stressLevel),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: ReportCard(
                              isTextOnly: true,
                              height: 190,
                              title: "Stress Index",
                              value: getVitalValue(VitalSignTypes.stressIndex),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: ReportCard(
                            isTextOnly: true,
                            height: 190,
                            title: "Normalized Stress Index",
                            value: getVitalValue(
                              VitalSignTypes.normalizedStressIndex,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            isTextOnly: true,
                            height: 190,
                            title: "HRV SDNN ",
                            value: getVitalValue(VitalSignTypes.sdnn),
                            mass: "%",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: ReportCard(
                            isTextOnly: true,
                            height: 190,
                            title: "Mean R-R Interval",
                            value: getVitalValue(VitalSignTypes.meanRri),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
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
                          flex: 1,
                          child: ReportCard(
                            backgroundImage: AppAssets.pnsImage,
                            height: 190,
                            title: "PNS Zone",
                            value: getVitalValue(VitalSignTypes.pnsZone),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
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
                      title: "Sympathetic Nervous System (SNS) Index",
                      value: getVitalValue(VitalSignTypes.snsIndex),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: CircleProgressCard(
                            size: 75,
                            progress: getVitalValueInt(VitalSignTypes.sd1),
                            age: getVitalValueInt(VitalSignTypes.sd1),

                            maxProgress: 10,
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Standard Deviation 1 - HRV metric',
                            mass: "ms",
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 1,
                          child: CircleProgressCard(
                            size: 75,
                            progress: getVitalValueInt(VitalSignTypes.sd1),
                            age: getVitalValueInt(VitalSignTypes.sd1),
                            maxProgress: 10,
                            mass: "ms",
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Standard Deviation 2 - HRV metric',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      flex: 1,
                      child: CircleProgressCard(
                        height: 240,
                        imageWidth: MediaQuery.of(context).size.width,
                        value: getVitalValue(VitalSignTypes.snsZone),
                        title: 'SNS Zone (level of sympathetic activity) ',
                        bottomImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: ReportCard(
                              centerImage: AppAssets.lhRatioImage,

                              height: 190,
                              title: "LF/HF Ratio",
                              value: getVitalValue(VitalSignTypes.lfhf),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getVitalValue(int type) {
    final result = _mesurementController.vitalsResults.value.getResult(type);
    return result?.value?.toString() ?? "null";
  }

  double getVitalValueD(int type) {
    final result = _mesurementController.vitalsResults.value.getResult(type);
    return result?.value ?? 0.0;
  }

  int getVitalValueInt(int type) {
    final result = _mesurementController.vitalsResults.value.getResult(type);
    final val = result?.value;
    if (val == null) return 0;
    return val is int ? val : val.toInt();
  }
}
