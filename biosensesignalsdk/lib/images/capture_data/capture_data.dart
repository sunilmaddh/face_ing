import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_device_data.dart';
import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_environment_data.dart';
import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_face_data.dart';
import 'package:biosensesignal_flutter_sdk/images/capture_data/capture_validity.dart';

class CaptureData {
  final CaptureFaceData face;
  final CaptureDeviceData device;
  final CaptureEnvironmentData environment;
  final CaptureValidity validity;

  CaptureData({
    required this.face,
    required this.device,
    required this.environment,
    required this.validity,
  });
}
