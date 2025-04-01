import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
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
    RxBool? isLoading,
  }) {
    final formKey = GlobalKey<FormState>();
    final RxBool loading =
        isLoading ?? false.obs; // Ensure proper RxBool handling

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Close"),
                    ),
                    Obx(
                      () => PrimaryButton(
                        isLoading: loading.value,
                        text: 'Get OTP',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            loading.value = true; // Show loading state
                            onPressed();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false, // Prevent accidental closure
    );
  }

  static void selectDate({
    required BuildContext context,
    required TextEditingController dateController,
  }) async {
    DateTime currentDate = DateTime.now();
    DateTime minDate = DateTime(1900, 1, 1);
    DateTime maxDate = DateTime(2100, 12, 31);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate.isBefore(maxDate) ? currentDate : maxDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      dateController.text = formattedDate;
      print("Selected Date: $formattedDate");
    }
  }

  // Show delete confirmation dialog
  void showDeleteUserDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CommonText.text(
            "Want to Remove the Guest?",
            maxLines: 2,
            fontSize: AppDimensions.font(18),
            fontWeight: FontWeight.w400,
            fontFamily: "Gilroy-Bold",
          ),
          content: CommonText.text(
            "Are you sure you want to remove? This action cannot be undone",
            maxLines: 2,
            fontSize: AppDimensions.font(15),
            fontWeight: FontWeight.w400,
            fontFamily: "Gilroy-Medium",
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: AppDimensions.height(40),
                  width: AppDimensions.width(125),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      onConfirm(); // Execute delete action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: CommonText.text("Delete", color: AppColors.btntext),
                  ),
                ),
                SizedBox(width: AppDimensions.width(2)),
                SizedBox(
                  height: AppDimensions.height(40),
                  width: AppDimensions.width(125),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: AppColors.deleteDesColor),
                      ),
                    ),
                    child: CommonText.text(
                      "Cancel",
                      color: AppColors.backArrowColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
