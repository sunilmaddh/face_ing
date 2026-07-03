import 'dart:ui';

import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_data.dart';

class ImageData {
  final int imageWidth;
  final int imageHeight;
  @Deprecated('Use captureData.face.roi instead')
  final Rect? roi;
  final int imageValidity;
  final CaptureData? captureData;

  ImageData(
      {required this.imageWidth,
      required this.imageHeight,
      required this.roi,
      required this.imageValidity,
      this.captureData});
}
