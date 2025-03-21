import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final Color borderColor;
  final bool readOnly;
  final bool enable;
  final double borderRadius;

   const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.readOnly=false,
    this.enable=true,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.borderColor=AppColors.textFieldColor,
    this.borderRadius = 8.0, this.suffixIcon, this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(fontSize: AppDimensions.font(16), fontWeight: FontWeight.w500,fontFamily:AppTextStyles.fontFamily),
        ),
        const SizedBox(height: 3),
        TextFormField(
          
          readOnly: readOnly,
          enabled: enable,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            
            labelStyle: TextStyle(color: AppColors.textFieldValueColor),
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.searchColor,fontSize: AppDimensions.font(16),fontWeight: FontWeight.w400,fontFamily: "Suisse Intl"),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: suffixIcon,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor,width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
           
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            contentPadding:  EdgeInsets.symmetric(vertical: AppDimensions.height(12), horizontal:AppDimensions.width(15.0)),
          ),
        ),
      ],
    );
  }
}
