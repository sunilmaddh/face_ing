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
            child:
            // Column(
            //   children: [
            //     ListView.builder(
            //       shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         var entries =
            //             _profileController
            //                 .anlyzeHealthDataResponseModel
            //                 .value
            //                 .channels!
            //                 .entries
            //                 .toList();
            //         final key = entries[index].key;
            //         final channel = entries[index].value;
            //         final value =
            //             (channel.dataList != null &&
            //                     channel.dataList!.isNotEmpty)
            //                 ? channel.dataList!.first.toStringAsFixed(2)
            //                 : 'N/A';
            //         return Expanded(
            //           child: ReportCard(
            //             title: key,
            //             value: value,
            //             mass: "", // or set dynamically if available
            //             image: "", // or set dynamically if available
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
            Column(
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
                                isCenter: true,
                                title: "Stress Level",
                                value: getVitalValue(
                                  VitalSignTypes.stressLevel,
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
                            height: 330,
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
                            child: ReportCard(
                              height: 165,
                              title: "Heart Rate Variability",
                              value: getVitalValue(VitalSignTypes.rmssd),
                              mass: "ms",
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ReportCard(
                              height: 165,
                              isCenter: true,
                              title: "Mean R-R Interval",
                              value: getVitalValue(VitalSignTypes.meanRri),
                              mass: "ms",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ReportCard(
                        title: "Blood Pressure",
                        value: getVitalValue(VitalSignTypes.bloodPressure),
                        mass: "mmHg",
                        bigImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Expanded(
                    //   child: ReportCard(
                    //     title:
                    //         "RMSSD (Root Mean Square of Successive Differences - HRV metric)",
                    //     value: getVitalValue(VitalSignTypes.rmssd),
                    //     mass: "ms",
                    //     bigImage: AppAssets.stressLevel,
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
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
                            height: 165,
                            title: "LF/HF Ratio ",
                            centerImage: AppAssets.lhRatioImage,
                            value: getVitalValue(VitalSignTypes.lfhf),
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
                          child: CircleProgressCard(
                            progress: VitalSignTypes.prq,
                            age: VitalSignTypes.prq,
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Pulse Respiration Quotient (PRQ)',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CircleProgressCard(
                            progress: VitalSignTypes.pnsIndex,

                            age: VitalSignTypes.pnsIndex,

                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Parasympathetic Nervous System Index',
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
                            centerImage: AppAssets.snsImage,
                            value: getVitalValue(VitalSignTypes.snsIndex),
                            borderColor: Color(0xFF0072BC).withOpacity(0.2),
                            drawArcColor: Color(0xFF0072BC),
                            title: 'Sympathetic Nervous System (SNS) Index',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 165,
                            title: "LF/HF Ratio ",
                            centerImage: AppAssets.lhRatioImage,
                            value: getVitalValue(VitalSignTypes.lfhf),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ReportCard(
                            height: 165,
                            isCenter: true,
                            centerImage: AppAssets.wellnessImage,

                            title: "Wellness Index",
                            value: getVitalValue(VitalSignTypes.wellnessIndex),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ReportCard(
                        title: "SNS Zone (level of sympathetic activity)",
                        value: getVitalValue(VitalSignTypes.snsZone),
                        bigImage: AppAssets.stressLevel,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 170,
                            title: "Standard Deviation 1 - HRV metric",
                            value: getVitalValue(VitalSignTypes.sd1),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CircleProgressCard(
                            progress: VitalSignTypes.sd2,

                            age: VitalSignTypes.sd2,

                            mass: "ms",
                            borderColor: Color(0xFFFFFDDF),
                            drawArcColor: Color(0xFFF7D100),
                            title: 'Standard Deviation 2 - HRV metric',
                          ),
                        ),
                        // Expanded(
                        //   child: ReportCard(
                        //     height: 170,
                        //     isCenter: true,

                        //     title: "HemoglobinA1C",
                        //     value: getVitalValue(VitalSignTypes.hemoglobinA1C),
                        //     mass: "%",
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: CircleProgressCard(
                        bottomImage: AppAssets.goodImage,
                        value: getVitalValue(
                          VitalSignTypes.highHemoglobinA1CRisk,
                        ),
                        borderColor: Color(0xFFFFFDDF),
                        drawArcColor: Color(0xFFF7D100),
                        title: 'High Hemoglobin A1C Risk',
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: "Blood Pressure",
                            value: getVitalValue(VitalSignTypes.bloodPressure),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ReportCard(
                            isCenter: true,
                            title: "Respiration Rate",
                            value: getVitalValue(
                              VitalSignTypes.respirationRate,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            height: 194,
                            title:
                                "High Blood Pressure Risk (Hypertension Risk)",
                            value: getVitalValue(
                              VitalSignTypes.highBloodPressureRisk,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ReportCard(
                            height: 194,
                            isCenter: true,
                            title: "Normalized Stress Index",
                            value: getVitalValue(
                              VitalSignTypes.normalizedStressIndex,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: "High Total Cholesterol Risk",
                            value: getVitalValue(
                              VitalSignTypes.highTotalCholesterolRisk,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ReportCard(
                            isCenter: true,

                            title: "High Fasting Glucose Risk",
                            value: getVitalValue(
                              VitalSignTypes.highFastingGlucoseRisk,
                            ),
                          ),
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
}
