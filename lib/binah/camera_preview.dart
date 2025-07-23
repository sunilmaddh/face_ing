import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:biosensesignal_flutter_sdk/ui/camera_preview_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/widget_size.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

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
          aspectRatio: 0.71,
          child: Stack(
            children: [
              const CameraPreviewView(),
              FaceDetectionViewDemo(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class FaceDetectionViewDemo extends StatelessWidget {
  final Size? size;
  FaceDetectionViewDemo({super.key, required this.size});
  final controller = Get.find<MeasurementController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imageInfo = controller.imageData.value;
      final roi = imageInfo?.roi;
      if (roi == null || size == null) return Container();
      var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      var widthFactor =
          size!.width / (imageInfo!.imageWidth / devicePixelRatio);
      var heightFactor =
          size!.height / (imageInfo.imageHeight / devicePixelRatio);
      return Positioned(
        left: (roi.left * widthFactor) / devicePixelRatio,
        top: (roi.top * heightFactor) / devicePixelRatio,
        child: SvgPicture.asset(
          AppAssets.faceDetact,
          width: (roi.width * widthFactor) / devicePixelRatio,
          height: (roi.height * heightFactor) / devicePixelRatio,
          color:
              imageInfo.imageValidity != ImageValidity.valid
                  ? AppColors.camreraPreviewColor
                  : AppColors.btntext,
        ),
      );
    });
  }
}
