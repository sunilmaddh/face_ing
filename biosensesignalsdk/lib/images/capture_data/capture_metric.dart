import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_metric_status.dart';

class CaptureMetric {
  final double value;
  final CaptureMetricStatus status;

  CaptureMetric({required this.value, required this.status});
}
