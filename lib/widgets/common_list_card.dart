import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CommonListCard extends StatelessWidget {
  const CommonListCard({
    super.key,
    required this.text,
    required this.index,
    required this.selectedIndices,
  });

  final String text;
  final int index;
  final RxList<int> selectedIndices; // Track multiple selected items

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = selectedIndices.contains(index);
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: AppDimensions.height(48),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textFieldColor, width: 1),
        ),
        child: CommonText.text(
          text,
          color: isSelected ? AppColors.btntext : AppColors.blackColor,
        ),
      );
    });
  }
}
