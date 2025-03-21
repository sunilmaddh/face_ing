import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  // Dynamic width and height scaling
  static double width(double value) => value.w;
  static double height(double value) => value.h;

  // Dynamic font size scaling
  static double font(double value) => value.sp;

  // Padding Sizes
  static double padding(double value) => value.w;
  static double leftPadding(double laftPadding)=>laftPadding.w;
  static double topPadding(double laftPadding)=>laftPadding.w;
  static double rightPadding(double laftPadding)=>laftPadding.w;
  static double bottomPadding(double laftPadding)=>laftPadding.w;

  // Margin Sizes
  static double margin(double value) => value.w;

  // Border Radius - Common Method
  static double radius(double value) => value.r;

  // Predefined radius values (optional)
  static double radiusSmall = radius(6);
  static double radiusMedium = radius(12);
  static double radiusLarge = radius(20);
  static double radiusExtraLarge = radius(30);
}
