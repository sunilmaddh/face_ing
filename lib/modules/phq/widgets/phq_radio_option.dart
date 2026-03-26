import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class PhqRadioOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const PhqRadioOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xffE2E8F0)),
          color: isSelected ? const Color(0xFFEBF7FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Color(0xffCBD5E1),
                  width: 1,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: AppDimensions.font(16),
                  color: Color(0xFF334155),
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w400,
                  // isSelected
                  //     ? const Color(0xFF2196F3)
                  //     : const Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
