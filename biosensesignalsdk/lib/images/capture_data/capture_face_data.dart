import 'dart:ui';

import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_landmark.dart';
import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_metric.dart';

class CaptureFaceData {
  final Rect roi;
  final Map<CaptureLandmark, Offset> landmarks;
  final CaptureMetric yaw;
  final CaptureMetric roll;
  final CaptureMetric pitch;
  final CaptureMetric verticalAlignment;
  final CaptureMetric horizontalAlignment;

  CaptureFaceData({
    required this.roi,
    required this.landmarks,
    required this.yaw,
    required this.roll,
    required this.pitch,
    required this.verticalAlignment,
    required this.horizontalAlignment,
  });
}
