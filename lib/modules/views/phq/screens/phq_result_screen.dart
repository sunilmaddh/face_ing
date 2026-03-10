import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import '../widgets/result_card.dart';

class PhqResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;
  const PhqResultScreen({super.key, required this.result});
  @override
  Widget build(BuildContext context) {
    final resultData = result['result'];
    final actualScore = resultData['actualScore'];
    final createdAt = resultData['createdAt'] ?? '';
    final formattedDate = _formatDate(createdAt);

    final depressionAI = _formatScore(resultData['predictedScoreDepression']);
    final anxietyAI = _formatScore(resultData['predictedScoreAnxiety']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Analysis Successful',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              formattedDate,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ResultCard(
                    title: 'Depression',
                    aiPrediction: 'AI PREDICTION',
                    aiResult: depressionAI,
                    clinicalData: 'CLINICAL DATA',
                    clinicalResult:
                        actualScore == null
                            ? 'No Data'
                            : _formatScore(actualScore['depression']),
                    aiResultColor: _getColor(depressionAI),
                    clinicalResultColor:
                        actualScore == null
                            ? Colors.grey
                            : _getColor(
                              _formatScore(actualScore['depression']),
                            ),
                  ),
                  ResultCard(
                    title: 'Anxiety',
                    aiPrediction: 'AI PREDICTION',
                    aiResult: anxietyAI,
                    clinicalData: 'CLINICAL DATA',
                    clinicalResult:
                        actualScore == null
                            ? 'No Data'
                            : _formatScore(actualScore['anxiety']),
                    aiResultColor: _getColor(anxietyAI),
                    clinicalResultColor:
                        actualScore == null
                            ? Colors.grey
                            : _getColor(_formatScore(actualScore['anxiety'])),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Analyze Again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy | HH:mm').format(date);
    } catch (e) {
      return '';
    }
  }

  String _formatScore(String? score) {
    if (score == null || score.isEmpty) return 'No Data';
    return score
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Color _getColor(String score) {
    final lower = score.toLowerCase();
    if (lower.contains('normal') || lower.contains('minimal')) {
      return const Color(0xFF66BB6A);
    } else if (lower.contains('mild')) {
      return const Color(0xFFFFA726);
    } else if (lower.contains('moderate')) {
      return const Color(0xFFFFA726);
    } else if (lower.contains('severe')) {
      return const Color(0xFFEF5350);
    }
    return Colors.grey;
  }
}
