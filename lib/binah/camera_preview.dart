import 'package:flutter/material.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:ntt_data/binah/face_detaction_test_page.dart';
import 'package:ntt_data/binah/face_detection_view.dart';
import 'package:ntt_data/binah/widget_size.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

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
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: AspectRatio(
            aspectRatio: 0.80,
            child: Stack(
              children: [
                const CameraPreviewView(),
                Align(
                  alignment: Alignment.center,
                  child: FaceDetectionCircleWidget(),
                ),
                FaceDetectionView(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
