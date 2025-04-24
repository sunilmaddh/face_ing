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
    {
      "title": "Respiration Rate",
      "value": "54.55",
      "mass": "kcal",
      "image": "",
    },
    {"title": "Heart Rate", "value": "78.20", "mass": "bpm", "image": ""},
    {
      "title": "Blood Pressure",
      "value": "120/80",
      "mass": "mmHg",
      "image": AppAssets.heartRate,
    },
    {"title": "Stress Level", "value": "510.43", "mass": "kcal", "image": ""},
    {"title": "Oxygen Level", "value": "98%", "mass": "SpO2", "image": ""},
    {"title": "Stress Level", "value": "424", "mass": "SpO2", "image": ""},
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
                        // Column of Two ReportCards
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ReportCard(
                                title: reports[0]["value"],

                                value:
                                    _mesurementController.vitalsResults.value
                                        .getResult(VitalSignTypes.pulseRate)!
                                        .value
                                        .toString(),
                                mass: reports[0]["mass"],
                                image: reports[0]["image"],
                              ),
                              const SizedBox(height: 15),
                              ReportCard(
                                title: reports[1]["title"],
                                value:
                                    _mesurementController.vitalsResults.value
                                        .getResult(
                                          VitalSignTypes.bloodPressure,
                                        )!
                                        .value
                                        .toString(),
                                mass: reports[1]["mass"],
                                image: reports[1]["image"],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),

                        // Single Large ReportCard
                        Expanded(
                          flex: 1,
                          child: ReportCard(
                            title: reports[2]["title"],
                            value:
                                _mesurementController.vitalsResults.value
                                    .getResult(VitalSignTypes.bloodPressure)!
                                    .value
                                    .toString(),
                            mass: reports[2]["mass"],
                            image: reports[2]["image"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Second Row: Two ReportCards Side by Side
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: reports[3]["title"],
                            value:
                                _mesurementController.vitalsResults.value
                                    .getResult(VitalSignTypes.stressLevel)!
                                    .value
                                    .toString(),
                            mass: reports[3]["mass"],
                            image: reports[3]["image"],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: reports[4]["title"],
                            value: reports[4]["value"],
                            mass: reports[4]["mass"],
                            image: reports[4]["image"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Expanded(
                      child: ReportCard(
                        title: reports[4]["title"],
                        value: reports[4]["value"],
                        mass: reports[4]["mass"],
                        image: reports[4]["image"],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Second Row: Two ReportCards Side by Side
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: reports[3]["title"],
                            value: reports[3]["value"],
                            mass: reports[3]["mass"],
                            image: reports[3]["image"],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: reports[4]["title"],
                            value: reports[4]["value"],
                            mass: reports[4]["mass"],
                            image: reports[4]["image"],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ReportCard(
                        isCenter: true,
                        title: reports[4]["title"],
                        value: reports[4]["value"],
                        mass: reports[4]["mass"],
                        image: reports[4]["image"],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Second Row: Two ReportCards Side by Side
                    Row(
                      children: [
                        Expanded(
                          child: ReportCard(
                            title: reports[3]["title"],
                            value: reports[3]["value"],
                            mass: reports[3]["mass"],
                            image: reports[3]["image"],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ReportCard(
                            title: reports[4]["title"],
                            value: reports[4]["value"],
                            mass: reports[4]["mass"],
                            image: reports[4]["image"],
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
}
