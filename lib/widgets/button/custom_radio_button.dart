import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  final RxString value;
  final RxString groupValue;
  final String label;
  final ValueChanged<String> onChanged;
  final Color activeColor;
  final Color borderColor;
  final double size;
  final double borderWidth;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    this.activeColor = AppColors.primary,
    this.borderColor = Colors.grey,
    this.size = 20.0,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value.value),
      child: Obx(() {
        bool isSelected =
            value.value == groupValue.value; // Corrected comparison

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeColor : borderColor,
                  width: borderWidth,
                ),
                color:
                    isSelected
                        // ignore: deprecated_member_use
                        ? activeColor.withOpacity(0.2)
                        : Colors.transparent,
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: size / 2,
                          height: size / 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: activeColor,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.radioTextColor,
                fontFamily: "Gilroy-Medium",
              ),
            ),
          ],
        );
      }),
    );
  }
}
