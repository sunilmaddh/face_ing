import 'package:flutter/material.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:ntt_data/binah/face_detection_view.dart';
import 'package:ntt_data/binah/widget_size.dart';

class CameraPreview extends StatefulWidget {
  const CameraPreview({super.key});

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
          aspectRatio: 0.75,
          child: Stack(
            children: [
              const CameraPreviewView(),
              Image.asset('assets/images/rppg_video_mask.png'),
              FaceDetectionView(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
