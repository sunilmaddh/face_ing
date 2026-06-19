import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.selectedValue,
    required this.onSelectionChanged,
    required this.onTap,
    required this.items,
  });

  final String selectedValue;
  final List<String> items;
  final void Function(String) onSelectionChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.symmetric(horizontal: 10),
      height: AppDimensions.height(35),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(20),
          value: selectedValue,
          icon: Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.btntext),
          dropdownColor: AppColors.primary,
          style: TextStyle(
            fontFamily: AppFontType.secondary.name,
            fontSize: AppDimensions.font(12),
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
          onTap: onTap,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onSelectionChanged(newValue);
            }
          },
          items:
              items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CommonText.labelMedium(
                    value,
                    fontType: AppFontType.secondary,
                    fontWeight: FontWeight.w400,
                    color: AppColors.btntext,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
