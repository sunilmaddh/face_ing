import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/widgets/button/custom_radio_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class RadioWidget extends StatelessWidget {
  RadioWidget({
    super.key,
    required this.controller,
    required this.level,
    required this.radioTextLeft,
    required this.radioTextRight,
  });
  RadioStateMixin controller;
  String level;
  String radioTextLeft;
  String radioTextRight;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.text(
          level,
          fontSize: AppDimensions.font(16),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: AppDimensions.height(8.0)),
        Row(
          children: [
            CustomRadioButton(
              value: radioTextLeft.obs,
              groupValue: controller.selectionType, // Use without .value
              label: radioTextLeft,
              onChanged: (v) {
                controller.selectionType.value = v;
              },
            ),
            SizedBox(width: AppDimensions.width(25)),
            CustomRadioButton(
              value: radioTextRight.obs,
              groupValue: controller.selectionType, // Use without .value
              label: radioTextRight,
              onChanged: (v) {
                controller.selectionType.value = v;
              },
            ),
          ],
        ),
      ],
    );
  }
}
