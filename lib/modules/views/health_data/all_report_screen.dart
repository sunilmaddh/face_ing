import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/health_data/widgets/circle_progress_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/info_card.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class AllReportScreen extends StatelessWidget {
  AllReportScreen({super.key});

  final _profileController = Get.find<ProfileController>();

  final _mesurementController = Get.find<MeasurementController>();

  final List<Map<String, dynamic>> reports = [
    {"title": "Respiration Rate", "value": "54.55", "mass": "", "image": ""},
    {"title": "Heart Rate", "value": "78.20", "mass": "", "image": ""},
    {
      "title": "Blood Pressure",
      "value": "120/80",
      "mass": "",
      "image": AppAssets.heartRate,
    },
    {"title": "Stress Level", "value": "510.43", "mass": "kcal", "image": ""},
    {"title": "Oxygen Level", "value": "98%", "mass": "", "image": ""},
    {"title": "Stress Level", "value": "424", "mass": "", "image": ""},
  ];

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
                // Scrollable Content
                ListView(
                  shrinkWrap: true, // Important for ListView inside Column
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                  children: [
                    // First Row: One Column (Two ReportCards) + One Large ReportCard
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ReportCard(
                                height: 190,
                                isCenter: true,
                                centerImage: AppAssets.wellnessImage,
                                title: "Wellness Index",
                                value: getVitalValue(
                                  VitalSignTypes.wellnessIndex,
                                ),
                              ),

                              const SizedBox(height: 20),
                              ReportCard(
                                isCenter: true,
                                mass: "rpm",

                                title: "Breathing Rate",
                                value: getVitalValue(
                                  VitalSignTypes.respirationRate,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            height: 365,
                            title: "Heart Rate",
                            value: getVitalValue(VitalSignTypes.pulseRate),
                            mass: "bpm",

                            image: AppAssets.heartRate,
                            isHeartRate: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CircleProgressCard(
                              progress: getVitalValueInt(VitalSignTypes.prq),
                              age: getVitalValueInt(VitalSignTypes.prq),
                              borderColor: Color(0xFF0072BC).withOpacity(0.2),
                              drawArcColor: Color(0xFF0072BC),
                              title: 'Pulse Respiration Quotient (PRQ)',
                            ),
                          ),

                          const SizedBox(width: 20),
                          Expanded(
                            child: ReportCard(
                              height: 235,
                              isCenter: true,
                              title: "Oxygen Saturation",
                              value: getVitalValue(
                                VitalSignTypes.oxygenSaturation,
                              ),
                              mass: "%",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ReportCard(
                        height: 210,
                        title: "Blood Pressure",
                        value: getVitalValue(VitalSignTypes.bloodPressure),
                        mass: "mmHg",
                        bigImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 240,
                            title: "Hemoglobin",
                            centerImage: AppAssets.homoglobin,
                            value: getVitalValue(VitalSignTypes.hemoglobin),
                            mass: "g/dL",
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            height: 240,
                            title: "HemoglobinA1C",
                            centerImage: AppAssets.homoglobin,
                            value: getVitalValue(VitalSignTypes.hemoglobinA1C),
                            mass: "%",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: CircleProgressCard(
                        bottomImage: AppAssets.goodImage,
                        value: getVitalValue(VitalSignTypes.ascvdRisk),
                        borderColor: Color(0xFFFFFDDF),
                        drawArcColor: Color(0xFFF7D100),
                        title:
                            'ASCVD Risk (Atherosclerotic Cardiovascular Disease Risk)',
                        mass: "%",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: CircleProgressCard(
                        bottomImage: AppAssets.heartAge,
                        value: getVitalValue(VitalSignTypes.heartAge),
                        borderColor: Color(0xFFFFFDDF),
                        drawArcColor: Color(0xFFF7D100),
                        title: 'Heart Age (biological heart age estimation)',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 215,
                            isCenter: true,
                            title:
                                "High Blood Pressure Risk (Hypertension Risk)",
                            value: getVitalValue(
                              VitalSignTypes.highBloodPressureRisk,
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            height: 215,
                            isCenter: true,
                            title: "High Hemoglobin A1C Risk",
                            value: getVitalValue(
                              VitalSignTypes.highHemoglobinA1CRisk,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 215,
                            isCenter: true,
                            title: "High Fasting Glucose Risk",
                            value: getVitalValue(
                              VitalSignTypes.highBloodPressureRisk,
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            height: 215,
                            isCenter: true,
                            title: "High Total Cholesterol Risk",
                            value: getVitalValue(
                              VitalSignTypes.highTotalCholesterolRisk,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ReportCard(
                        height: 165,
                        isCenter: true,
                        title: "Low Hemoglobin Risk (anemia risk)",
                        value: getVitalValue(VitalSignTypes.lowHemoglobinRisk),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReportCard(
                          width: 164,
                          isCenter: true,
                          title: "Stress Level",
                          value: getVitalValue(VitalSignTypes.stressLevel),
                        ),
                        const SizedBox(height: 20),
                        ReportCard(
                          width: 164,
                          isCenter: true,

                          title: "Stress Index",
                          value: getVitalValue(VitalSignTypes.stressIndex),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReportCard(
                          width: 164,
                          height: 165,
                          isCenter: true,
                          title: "Normalized Stress Index",
                          value: getVitalValue(
                            VitalSignTypes.normalizedStressIndex,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ReportCard(
                          width: 164,
                          height: 165,

                          isCenter: true,

                          title: "HRV SDNN ",
                          value: getVitalValue(VitalSignTypes.sdnn),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReportCard(
                          width: 164,
                          height: 165,
                          isCenter: true,
                          title: "Mean R-R Interval",
                          value: getVitalValue(VitalSignTypes.meanRri),
                        ),
                        const SizedBox(height: 20),
                        ReportCard(
                          width: 164,
                          height: 165,
                          isCenter: true,

                          title: "RMSSD",
                          value: getVitalValue(VitalSignTypes.rmssd),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CircleProgressCard(
                            leftPadding: 45,
                            value: getVitalValue(VitalSignTypes.pnsZone),
                            centerImage: AppAssets.pnsImage,
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title:
                                'PNS Zone (level of parasympathetic activity) ',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CircleProgressCard(
                            centerImage: AppAssets.pnsImage,
                            value: getVitalValue(VitalSignTypes.pnsIndex),
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'PNS Index (Parasympathetic Nervous System)',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ReportCard(
                        height: 180,
                        leftPadding: 30,
                        valueCenter: getVitalValue(VitalSignTypes.pnsZone),
                        centerImage: AppAssets.snsImage,
                        title: 'Sympathetic Nervous System (SNS) Index',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CircleProgressCard(
                            progress: getVitalValueInt(VitalSignTypes.sd1),
                            age: getVitalValueInt(VitalSignTypes.sd1),
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Standard Deviation 1 - HRV metric',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CircleProgressCard(
                            progress: getVitalValueInt(VitalSignTypes.sd2),
                            age: getVitalValueInt(VitalSignTypes.sd2),
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Standard Deviation 2 - HRV metric',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ReportCard(
                        height: 210,
                        title: "SNS Zone (level of sympathetic activity)",
                        value: getVitalValue(VitalSignTypes.snsZone),
                        bigImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        ReportCard(
                          height: 165,
                          title: "LF/HF Ratio ",
                          centerImage: AppAssets.lhRatioImage,
                          value: getVitalValue(VitalSignTypes.lfhf),
                        ),
                      ],
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

  // int getVitalValueInt(int type) {
  //   final result = _mesurementController.vitalsResults.value.getResult(type);
  //   return result?.value ?? 0;
  // }
  int getVitalValueInt(int type) {
    final result = _mesurementController.vitalsResults.value.getResult(type);
    final val = result?.value;
    if (val == null) return 0;
    return val is int ? val : val.toInt();
  }
}
