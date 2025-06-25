import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class FaceDetectionView extends StatelessWidget {
  final Size? size;
  const FaceDetectionView({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();

    return Obx(() {
      final imageInfo = controller.imageData.value;
      final roi = imageInfo?.roi;

      if (roi == null || size == null) return Container();

      final widthFactor = size!.width / imageInfo!.imageWidth;
      final heightFactor = size!.height / imageInfo.imageHeight;

      final left = (roi.left ?? 0.0) * widthFactor;
      final top = (roi.top ?? 0.0) * heightFactor;
      final roiWidth = (roi.width ?? 0.0) * widthFactor;
      final roiHeight = (roi.height ?? 0.0) * heightFactor;

      return Positioned(
        left: left,
        top: top,
        child: SvgPicture.asset(
          AppAssets.faceDetact,
          width: roiWidth,
          height: roiHeight,
          color:
              imageInfo.imageValidity != ImageValidity.valid
                  ? AppColors.camreraPreviewColor
                  : AppColors.btntext,
        ),
      );
    });
  }
}
