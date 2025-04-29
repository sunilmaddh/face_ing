import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
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
                                title: "Pluse Rate",
                                value: getVitalValue(VitalSignTypes.pulseRate),
                              ),
                              const SizedBox(height: 15),
                              ReportCard(
                                title: "Blood Pressure",
                                value: getVitalValue(
                                  VitalSignTypes.bloodPressure,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            ReportCard(
                              title: "Hemoglobin",
                              value: getVitalValue(VitalSignTypes.hemoglobin),
                            ),
                            ReportCard(
                              title: "PRQ",
                              value: getVitalValue(VitalSignTypes.prq),
                            ),
                          ],
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: ReportCard(
                        //     title: "Hemoglobin",
                        //     value:
                        //         _mesurementController.vitalsResults.value
                        //             .getResult(VitalSignTypes.hemoglobin)!
                        //             .value
                        //             .toString(),
                        //     mass: reports[2]["mass"],
                        //     image: reports[2]["image"],
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: "Stress level",
                            value: getVitalValue(VitalSignTypes.stressLevel),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: "Stress Index",
                            value: getVitalValue(VitalSignTypes.stressIndex),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ReportCard(
                        title: "Respiration Rate",
                        value: getVitalValue(VitalSignTypes.respirationRate),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: "SDN",
                            value: getVitalValue(VitalSignTypes.sdnn),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: "Wellness Index",
                            value: getVitalValue(VitalSignTypes.wellnessIndex),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ReportCard(
                        isCenter: true,
                        title: "Wellness level",
                        value: getVitalValue(VitalSignTypes.wellnessLevel),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: "SNS Index",
                            value: getVitalValue(VitalSignTypes.snsIndex),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: "Oxygen Saturation",
                            value: getVitalValue(
                              VitalSignTypes.oxygenSaturation,
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
}
