import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final CheckboxStateMixin controller;
  final String message;

  const TermsCheckboxWidget({
    super.key,
    required this.controller,
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
            value: controller.isChecked.value,
            onChanged: (_) => controller.toggleCheckbox(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            checkColor: AppColors.primary,
            side: BorderSide(color: AppColors.checkBoxBorderColor, width: 1),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: AppDimensions.padding(11)),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: AppDimensions.font(14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.termColor,
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
