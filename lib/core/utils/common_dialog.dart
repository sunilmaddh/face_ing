import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class CommonDialog {
  void showFullWidthDialog({
    required String title,
    required VoidCallback onPressed,
    required TextEditingController textController,
  }) {
    final formKey = GlobalKey<FormState>(); // Defined inside function

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Optional: Rounded corners
        child: Container(
          width: Get.width, // 🔥 Full-width
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust based on content
              children: [
                CommonText.text(
                  title,
                  fontSize: AppDimensions.font(16),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTextStyles.fontFamily,
                ),
                const SizedBox(height: 30),
                CustomFormField(
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return "Please enter email ID";
                    }
                    return null;
                  },
                  label: "Email",
                  hint: "Please enter email ID",
                  controller: textController,
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Align buttons properly
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Close"),
                    ),
                    PrimaryButton(
                      text: 'Get OTP',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          onPressed(); // Call function correctly
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
