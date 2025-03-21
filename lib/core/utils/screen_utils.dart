import 'package:get/get.dart';

class ScreenUtils {
  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;

  static double get blockSizeHorizontal => screenWidth / 100;
  static double get blockSizeVertical => screenHeight / 100;

  static double get textMultiplier => blockSizeVertical;
  static double get imageSizeMultiplier => blockSizeHorizontal;
  static double get heightMultiplier => blockSizeVertical;
  static double get widthMultiplier => blockSizeHorizontal;

  // Responsive Text Size
  static double setTextSize(double textSize) => textSize * textMultiplier;

  // Responsive Width & Height
  static double setWidth(double width) => width * widthMultiplier;
  static double setHeight(double height) => height * heightMultiplier;

  // Responsive Padding
  static double setPadding(double padding) => padding * blockSizeHorizontal;

  // Responsive Border Radius
  static double setRadius(double radius) => radius * blockSizeHorizontal;
}
