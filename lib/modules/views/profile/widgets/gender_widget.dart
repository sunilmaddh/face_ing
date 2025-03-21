import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/profile_controller.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/custom_radio_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class GenderWidget extends StatelessWidget {
  GenderWidget({super.key});

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.text("Gender",fontSize: AppDimensions.font(16), fontWeight: FontWeight.w500),
        SizedBox(height: AppDimensions.height(8.0)),
        Row(
          children: [
            CustomRadioButton(
              value: "Male".obs, 
              groupValue: _profileController.selectionType, // Use without .value
              label: "Male",
              onChanged: (v) {
                _profileController.selectionType.value = v;
              },
            ),
            SizedBox(width: AppDimensions.width(10)),
            CustomRadioButton(
              value: "Female".obs, 
              groupValue: _profileController.selectionType, // Use without .value
              label: "Female",
              onChanged: (v) {
                _profileController.selectionType.value = v;
              },
            ),
          ],
        ),
      ],
    );
  }
}


