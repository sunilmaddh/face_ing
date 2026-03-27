import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color borderColor;
  final bool readOnly;
  final bool enable;
  final double borderRadius;
  RxBool isObscureText = false.obs;
  final void Function(String?)? onChanged;

  CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.readOnly = false,
    this.enable = true,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.borderColor = AppColors.textFieldColor,
    this.borderRadius = 8.0,
    this.suffixIcon,
    this.onChanged,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    isObscureText.value = obscureText;
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
        Obx(
          () => TextFormField(
            onChanged: onChanged,
            readOnly: readOnly,
            enabled: enable,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isObscureText.value,
            validator: validator,
            contextMenuBuilder: (context, editableTextState) {
              return AdaptiveTextSelectionToolbar(
                anchors: editableTextState.contextMenuAnchors,
                children: [
                  TextButton(
                    onPressed:
                        () => editableTextState.pasteText(
                          SelectionChangedCause.toolbar,
                        ),
                    child: const Text('Paste'),
                  ),
                ],
              );
            },
            decoration: InputDecoration(
              labelStyle: TextStyle(color: AppColors.textFieldValueColor),
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.searchColor,
                fontSize: AppDimensions.font(16),
                fontWeight: FontWeight.w400,
                fontFamily: "Suisse Intl",
              ),
              suffix: Visibility(
                visible: obscureText,
                child: InkWell(
                  onTap: () {
                    isObscureText.value = !isObscureText.value;
                  },
                  child: Icon(
                    isObscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: AppDimensions.height(12),
                horizontal: AppDimensions.width(15.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
