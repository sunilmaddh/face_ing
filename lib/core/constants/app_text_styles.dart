import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required AppFontType fontType,
    double? height,
    TextDecoration? decoration,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontType.value,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle displayLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 32,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.2,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle displayMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 28,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.2,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle displaySmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.25,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle headlineLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 22,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.3,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle headlineMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.3,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle headlineSmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 18,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.3,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle titleLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.35,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle titleMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 16,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.4,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle titleSmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.4,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle bodyLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 16,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.5,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle bodyMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.5,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle bodySmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.5,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle labelLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 14,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.3,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle labelMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 12,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.3,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle labelSmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return _baseStyle(
      fontSize: 10,
      fontWeight: fontWeight,
      color: color,
      fontType: fontType,
      height: 1.2,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }
}
