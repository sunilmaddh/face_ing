import 'package:flutter/material.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:ntt_data/binah/face_detaction_test_page.dart';
import 'package:ntt_data/binah/face_detection_view.dart';
import 'package:ntt_data/binah/widget_size.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.height(0)),
        child: SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 0.7,
            child: Stack(
              children: [
                const CameraPreviewView(),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: CommonText.text("Stop", color: AppColors.primary),
                    ),
                  ),
                ),

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
