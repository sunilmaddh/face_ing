import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final Widget widget;
  const QuestionCard({super.key, required this.widget});
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
      child: widget,
    );
  }
}
