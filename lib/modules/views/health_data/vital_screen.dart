import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class VitalScreen extends StatelessWidget {
   VitalScreen({super.key});
 final List<Map<String, dynamic>> reports = [
    {"title": "Respiration Rate", "value": "54.55", "mass": "kcal", "image": ""},
    {
      "title": "Heart Rate",
      "value": "78.20",
      "mass": "bpm",
      "image": ""
    },
    {"title": "Blood Pressure", "value": "120/80", "mass": "mmHg", "image": AppAssets.heartRate},
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Scrollable Content
                    ListView(
                      shrinkWrap: true, // Important for ListView inside Column
                      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
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
                                    title: reports[0]["title"],
                                    value: reports[0]["value"],
                                    mass: reports[0]["mass"],
                                    image: reports[0]["image"],
                                  ),
                                  const SizedBox(height: 15),
                                  ReportCard(
                                    title: reports[1]["title"],
                                    value: reports[1]["value"],
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
                                value: reports[2]["value"],
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