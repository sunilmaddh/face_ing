import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/custom_radio_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class RadioWidget extends StatelessWidget {
  RadioWidget({
    super.key,
    required this.selectionType,
    required this.level,
    required this.radioTextLeft,
    required this.radioTextRight,
    required this.onSelectionChanged,
  });
  // RadioStateMixin controller;
  String level;
  String radioTextLeft;
  RxString selectionType;
  String radioTextRight;
  void Function(String) onSelectionChanged;
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
              groupValue: selectionType, // Use without .value
              label: radioTextLeft,
              onChanged: (v) {
                selectionType.value = v;
              },
            ),
            SizedBox(width: AppDimensions.width(25)),
            CustomRadioButton(
              value: radioTextRight.obs,
              groupValue: selectionType, // Use without .value
              label: radioTextRight,
              onChanged: (v) {
                // selectionType.value = v;
                onSelectionChanged(v);
              },
            ),
          ],
        ),
      ],
    );
  }
}
