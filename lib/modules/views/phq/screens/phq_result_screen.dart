import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import '../widgets/result_card.dart';

class PhqResultScreen extends StatefulWidget {
  const PhqResultScreen({super.key});

  @override
  State<PhqResultScreen> createState() => _PhqResultScreenState();
}

class _PhqResultScreenState extends State<PhqResultScreen> {
  final controller = Get.find<AssessmentController>();

  @override
  void initState() {
    controller.getResult();
    super.initState();
  }

  void callResult() async {
    await controller.getResult();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.depressionResponse.value.aiPrediction.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "Analysis Successful",

        isCenterTitle: false,
      ),
      body: Obx(
        () =>
            controller.isGettingResult.isTrue
                ? Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CommonText.text(
                        _formatDate(controller.createDate.value),
                        color: Colors.grey.shade600,
                        fontSize: 14,
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
                              aiResult:
                                  controller
                                              .depressionResponse
                                              .value
                                              .aiPrediction ==
                                          null
                                      ? "No result"
                                      : controller
                                          .depressionResponse
                                          .value
                                          .aiPrediction!,
                              clinicalData: 'CLINICAL DATA',
                              clinicalResult:
                                  controller
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ==
                                              null ||
                                          controller
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                      ? 'No Data'
                                      : _formatScore(
                                        controller
                                            .depressionResponse
                                            .value
                                            .clinicalData,
                                      ),
                              aiResultColor: _getColor(
                                controller
                                        .depressionResponse
                                        .value
                                        .aiPrediction ??
                                    "",
                              ),
                              clinicalResultColor:
                                  controller
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ==
                                              null ||
                                          controller
                                                  .depressionResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                      ? Colors.grey
                                      : _getColor(
                                        _formatScore(
                                          controller
                                              .depressionResponse
                                              .value
                                              .clinicalData,
                                        ),
                                      ),
                              text1:
                                  controller
                                              .depressionResponse
                                              .value
                                              .phq2Score ==
                                          "N/A"
                                      ? ""
                                      : controller
                                              .depressionResponse
                                              .value
                                              .phq2Score ??
                                          "",
                              text2:
                                  controller
                                              .depressionResponse
                                              .value
                                              .phq9Score ==
                                          "N/A"
                                      ? ""
                                      : controller
                                              .depressionResponse
                                              .value
                                              .phq9Score ??
                                          "",
                            ),
                            ResultCard(
                              title: 'Anxiety',
                              aiPrediction: 'AI PREDICTION',
                              aiResult:
                                  controller
                                      .anxietyResponse
                                      .value
                                      .aiPrediction ??
                                  "No Result",
                              clinicalData: 'CLINICAL DATA',
                              clinicalResult:
                                  controller
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ==
                                              null ||
                                          controller
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                      ? 'No Data'
                                      : _formatScore(
                                        controller
                                            .anxietyResponse
                                            .value
                                            .clinicalData,
                                      ),
                              aiResultColor: _getColor(
                                controller.anxietyResponse.value.aiPrediction ??
                                    "",
                              ),
                              clinicalResultColor:
                                  controller
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ==
                                              null ||
                                          controller
                                                  .anxietyResponse
                                                  .value
                                                  .clinicalData ==
                                              "N/A"
                                      ? Colors.grey
                                      : _getColor(
                                        _formatScore(
                                          controller
                                              .anxietyResponse
                                              .value
                                              .clinicalData,
                                        ),
                                      ),
                              text1:
                                  controller.anxietyResponse.value.gad7Score ==
                                          "N/A"
                                      ? ""
                                      : controller
                                              .anxietyResponse
                                              .value
                                              .gad7Score ??
                                          "",
                              text2: '',
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
