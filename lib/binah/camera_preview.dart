import 'package:flutter/material.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:ntt_data/binah/face_detection_view.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/widget_size.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class CameraPreview extends StatefulWidget {
  const CameraPreview({super.key, required this.controller});
  final MeasurementController controller;
  @override
  State<CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange: (newSize) => setState(() => size = newSize),
      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Stack(
            children: [
              const CameraPreviewView(),
              FaceDetectionView(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
