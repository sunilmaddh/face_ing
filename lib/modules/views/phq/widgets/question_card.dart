import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String speaker;

  const QuestionCard({
    super.key,
    required this.question,
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(10),
        border: Border.all(color: AppColors.primary, width: 0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2196F3),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            speaker,
            style: const TextStyle(color: AppColors.primary, fontSize: 14),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
