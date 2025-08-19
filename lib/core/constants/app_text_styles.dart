import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';

class AppTextStyles {
  static const String fontFamily = AppConstents.commonFont;

  // Common text sizes
  static const double small = 14.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;

  // Text Styles
  static TextStyle smallText({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14.0,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle mediumText({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: medium,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle largeText({
    Color color = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 24.0,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle extraLargeText({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: extraLarge,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static String fontFamilyGilroy = "Gilroy-Medium";
}
