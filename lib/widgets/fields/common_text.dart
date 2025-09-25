import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';

class CommonText {
  /// Common styled text
  static Widget text(
    String text, {
    double fontSize = 16.0,
    Key? key,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    String fontFamily = AppTextStyles.fontFamily,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextDecoration? decoration,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      key: key,
      text,
      style: TextStyle(
        decorationColor: AppColors.primary,
        decoration: decoration,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
