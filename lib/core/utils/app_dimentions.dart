import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  // Dynamic width and height scaling
  static double width(double value) => value.w;
  static double height(double value) => value.h;

  // Dynamic font size scaling
  static double font(double value) => value.sp;

  // Padding Sizes
  static double padding(double value) => value.w;
  static double leftPadding(double laftPadding) => laftPadding.w;
  static double topPadding(double laftPadding) => laftPadding.w;
  static double rightPadding(double laftPadding) => laftPadding.w;
  static double bottomPadding(double laftPadding) => laftPadding.h;

  // Margin Sizes
  static double margin(double value) => value.w;

  // Border Radius - Common Method
  static double radius(double value) => value.r;

  // Predefined radius values (optional)
  static double radiusSmall = radius(6);
  static double radiusMedium = radius(12);
  static double radiusLarge = radius(20);
  static double radiusExtraLarge = radius(30);

  /// Returns responsive EdgeInsets for all sides
  static EdgeInsets all(double value) => EdgeInsets.all(value.w);

  /// Returns responsive symmetric padding
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);

  /// Returns responsive only padding
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: left.w,
    top: top.h,
    right: right.w,
    bottom: bottom.h,
  );
}
