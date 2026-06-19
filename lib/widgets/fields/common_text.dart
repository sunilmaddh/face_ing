import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_fonts.dart';
import 'package:ntt_data/core/constants/app_text_styles.dart';

class CommonText {
  const CommonText._();

  static Widget _buildText(
    String text, {
    Key? key,
    required TextStyle style,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return Text(
      text,
      key: key,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget text(
    String text, {
    Key? key,
    TextStyle? style,
    Color? color,
    FontWeight? fontWeight,
    AppFontType fontType = AppFontType.primary,
    FontStyle? fontStyle,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    double? fontSize,
    TextDecoration? decoration,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    final baseStyle = style ?? AppTextStyles.bodyMedium(fontType: fontType);

    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: baseStyle.copyWith(
        color: color ?? baseStyle.color,
        fontWeight: fontWeight ?? baseStyle.fontWeight,
        fontFamily: fontType.value,
        fontStyle: fontStyle ?? baseStyle.fontStyle,
        decoration: decoration ?? baseStyle.decoration,
        fontSize: baseStyle.fontSize,
      ),
    );
  }

  static Widget displayLarge(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.displayLarge(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget displayMedium(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.displayMedium(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget displaySmall(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.displaySmall(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget headlineLarge(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.headlineLarge(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget headlineMedium(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.headlineMedium(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget headlineSmall(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.headlineSmall(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget titleLarge(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.titleLarge(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget titleMedium(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.titleMedium(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget titleSmall(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.titleSmall(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget bodyLarge(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.bodyLarge(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget bodyMedium(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.bodyMedium(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget bodySmall(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.bodySmall(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget labelLarge(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.labelLarge(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget labelMedium(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.labelMedium(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  static Widget labelSmall(
    String text, {
    Key? key,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    AppFontType fontType = AppFontType.primary,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool softWrap = true,
  }) {
    return _buildText(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: AppTextStyles.labelSmall(
        color: color,
        fontWeight: fontWeight,
        fontType: fontType,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}
