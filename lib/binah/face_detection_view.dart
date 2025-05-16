import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

class FaceDetectionView extends StatelessWidget {
  final Size? size;
  const FaceDetectionView({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    final imageInfo = controller.imageData.value;
    final roi = imageInfo?.roi;

    if (roi == null || size == null) return Container();

    var dpr = MediaQuery.of(context).devicePixelRatio;
    var widthFactor = size!.width / (imageInfo!.imageWidth / dpr);
    var heightFactor = size!.height / (imageInfo.imageHeight / dpr);

    return Positioned(
      left: (controller.imageData.value?.roi?.left ?? 0.0 * widthFactor) / dpr,
      top: (controller.imageData.value?.roi?.top ?? 0.0 * heightFactor) / dpr,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 4, color: const Color(0xff0653F4)),
          borderRadius: BorderRadius.circular(5),
        ),
        width:
            (controller.imageData.value?.roi?.width ?? 0.0 * widthFactor) / dpr,
        height:
            (controller.imageData.value?.roi?.height ?? 0.0 * heightFactor) /
            dpr,
      ),
    );
  }
}
