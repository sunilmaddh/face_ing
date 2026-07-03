import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_metric.dart';

class CaptureDeviceData {
  final CaptureMetric? pitch;
  final CaptureMetric distance;

  CaptureDeviceData({this.pitch, required this.distance});
}
