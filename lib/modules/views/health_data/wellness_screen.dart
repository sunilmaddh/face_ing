import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/health_data/widgets/report_card.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';

class WellnessScreen extends StatelessWidget {
   WellnessScreen({super.key});
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
                   
                    ListView(
                      shrinkWrap: true, 
                      physics: const NeverScrollableScrollPhysics(), 
                      children: [
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
                    
                      ])])))),
    );
    
      
  }
}