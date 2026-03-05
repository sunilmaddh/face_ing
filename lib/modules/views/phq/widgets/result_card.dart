import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'result_column.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String aiPrediction;
  final String aiResult;
  final String clinicalData;
  final String clinicalResult;
  final Color aiResultColor;
  final Color clinicalResultColor;

  const ResultCard({
    super.key,
    required this.title,
    required this.aiPrediction,
    required this.aiResult,
    required this.clinicalData,
    required this.clinicalResult,
    required this.aiResultColor,
    required this.clinicalResultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,

      margin: const EdgeInsets.only(bottom: 16),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ResultColumn(
                        icon: Icons.psychology_outlined,
                        label: aiPrediction,
                        result: aiResult,
                        resultColor: aiResultColor,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    Expanded(
                      child: ResultColumn(
                        icon: Icons.medical_information_outlined,
                        label: clinicalData,
                        result: clinicalResult,
                        resultColor: clinicalResultColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
