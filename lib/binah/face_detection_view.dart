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

      final dpr = MediaQuery.of(context).devicePixelRatio;
      final widthFactor = size!.width / (imageInfo!.imageWidth / dpr);
      final heightFactor = size!.height / (imageInfo.imageHeight / dpr);

      return Positioned(
        left: ((roi.left ?? 0.0) * widthFactor) / dpr,
        top: ((roi.top ?? 0.0) * heightFactor) / dpr,
        child: SvgPicture.asset(
          AppAssets.faceDetact,
          width: ((roi.width ?? 0.0) * widthFactor) / dpr,
          height: ((roi.height ?? 0.0) * heightFactor) / dpr,
          color:
              controller.imageData.value != null &&
                      controller.imageData.value!.imageValidity !=
                          ImageValidity.valid
                  ? AppColors.camreraPreviewColor
                  : AppColors.btntext,
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(image: AssetImage(AppAssets.faceD)),
        //   ),
        //   color: Colors.transparent,
        //   //   border: Border.all(width: 4, color: const Color(0xff0653F4)),
        //   //   borderRadius: BorderRadius.circular(5),
        //   // ),
        //   width: ((roi.width ?? 0.0) * widthFactor) / dpr,
        //   height: ((roi.height ?? 0.0) * heightFactor) / dpr,
        // ),
      );
    });
  }
}
