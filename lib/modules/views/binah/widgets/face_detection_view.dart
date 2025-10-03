import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
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
// import 'dart:math' as math;
// import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:ntt_data/binah/measurement_controller.dart';
// import 'package:ntt_data/core/constants/app_assets.dart';
// import 'package:ntt_data/core/constants/app_colors.dart';

// class FaceDetectionView extends StatelessWidget {
//   final Size? size;
//   final bool isFrontCamera; // 👈 pass true if using front cam

//   const FaceDetectionView({
//     super.key,
//     required this.size,
//     this.isFrontCamera = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<MeasurementController>();

//     return Obx(() {
//       final imageInfo = controller.imageData.value;
//       final roi = imageInfo?.roi;

//       if (roi == null || size == null) return Container();

//       // ✅ Better scaling (keeps aspect ratio consistent)
//       final scale = math.min(
//         size!.width / imageInfo!.imageWidth,
//         size!.height / imageInfo.imageHeight,
//       );

//       // Calculate ROI position
//       double left = (roi.left ?? 0.0) * scale;
//       double top = (roi.top ?? 0.0) * scale;
//       double roiWidth = (roi.width ?? 0.0) * scale;
//       double roiHeight = (roi.height ?? 0.0) * scale;

//       // ✅ Adjust for mirroring if front camera
//       if (isFrontCamera) {
//         left = size!.width - left - roiWidth;
//       }

//       return Positioned(
//         left: left,
//         top: top,
//         child: SvgPicture.asset(
//           AppAssets.faceDetact,
//           width: roiWidth,
//           height: roiHeight,
//           color:
//               imageInfo.imageValidity != ImageValidity.valid
//                   ? AppColors.camreraPreviewColor
//                   : AppColors.btntext,
//         ),

//         // 👉 Debug first with this instead of SvgPicture to see if alignment fixes:
//         /*
//         child: Container(
//           width: roiWidth,
//           height: roiHeight,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//               width: 2,
//             ),
//           ),
//         ),
//         */
//       );
//     });
//   }
// }
