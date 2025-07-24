import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';

class CommonDropdownTextField extends StatelessWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final Color borderColor;
  final String hintText;
  final bool readOnly;
  // final List<String> items;
  final int columns;
  final String title;
  final void Function(String?)? onChanged;

  const CommonDropdownTextField({
    super.key,
    required this.label,
    required this.options,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
    this.hintText = "",
    this.columns = 5,
    this.title = "",
    this.borderColor = AppColors.textFieldColor,
    this.borderRadius = 8.0,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppDimensions.font(16),
            fontWeight: FontWeight.w500,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
        const SizedBox(height: 3),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.numberWithOptions(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: hintText,
            // labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: AppDimensions.height(12),
              horizontal: AppDimensions.width(15.0),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                CommonDialog.showFullWidthCupertinoPicker(
                  context: context,
                  title: title,
                  list: options,
                  selectedItem: (selectedItem) {
                    controller.text = selectedItem;
                  },
                );
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }
}
