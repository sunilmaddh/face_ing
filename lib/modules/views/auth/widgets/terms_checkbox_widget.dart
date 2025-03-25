import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final AuthController authController;

  final String message;
  const TermsCheckboxWidget({
    super.key,
    required this.authController,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            focusColor: AppColors.btntext,
            value: authController.isChecked.value,
            onChanged: (value) => authController.toggleCheckbox(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // fillColor: MaterialStateProperty.all(AppColors.btntext), // Background color
            checkColor: AppColors.primary, // Tick color
            side: BorderSide(
              color: AppColors.checkBoxBorderColor,
              width: 1,
            ), // Border color
          ),

          Flexible(
            // Ensures text does not overflow
            child: Padding(
              padding: EdgeInsets.only(top: AppDimensions.padding(11)),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: AppDimensions.font(14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.termColor,
                ),
                softWrap: true, // Ensures text wraps instead of overflowing
              ),
            ),
          ),
        ],
      ),
    );
  }
}
