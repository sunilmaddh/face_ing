import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

void commonDialogCard({
  required BuildContext context,
  required Widget widget,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,

  String title = "",
  double height = 250,
  String positiveText = "OK",
  String negativeText = "Cancel",
}) {
  // DateTime selectedDate = initialDate;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonText.text(
                title,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: AppDimensions.font(18),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: AppDimensions.height(height),
                width: double.infinity,
                child: widget,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: AppDimensions.height(45),

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onConfirm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: CommonText.text(
                            positiveText,
                            color: AppColors.btntext,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimensions.width(20)),
                    Expanded(
                      child: SizedBox(
                        height: AppDimensions.height(45),

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (onCancel != null) onCancel();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.btntext,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide(color: AppColors.deleteDesColor),
                            ),
                          ),
                          child: CommonText.text(
                            negativeText,
                            color: AppColors.backArrowColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
