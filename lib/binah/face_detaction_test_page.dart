// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:ntt_data/binah/measurement_controller.dart';
// import 'package:ntt_data/core/utils/app_dimentions.dart';

// class FaceDetectionCircleWidget extends StatelessWidget {
//   const FaceDetectionCircleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final progressController = Get.find<MeasurementController>();

//     return Obx(() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FaceDetectionCircle(
//             progress: progressController.progress.value.toDouble(),
//             isStarted: progressController.isStarted.value,
//           ),
//         ],
//       );
//     });
//   }
// }

// class FaceDetectionCircle extends StatelessWidget {
//   final double progress;
//   final bool isStarted;

//   const FaceDetectionCircle({
//     super.key,
//     required this.progress,
//     required this.isStarted,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double width =
//         Platform.isAndroid
//             ? AppDimensions.width(310)
//             : AppDimensions.width(370);
//     double height =
//         Platform.isAndroid
//             ? AppDimensions.width(370)
//             : AppDimensions.height(460);

//     return SizedBox(
//       width: width,
//       height: height,
//       child: DottedBorder(
//         borderType: BorderType.values.last,
//         dashPattern: [6, 4],
//         color: Colors.grey,
//         strokeWidth: 3,
//         padding: EdgeInsets.zero,
//         child: SizedBox(width: width, height: height),
//       ),
//       // isStarted
//       //     ? Stack(
//       //       alignment: Alignment.center,
//       //       children: [
//       //         DottedBorder(
//       //           borderType: BorderType.values.last,
//       //           dashPattern: [6, 4],
//       //           color: Colors.black,
//       //           strokeWidth: 3,
//       //           padding: EdgeInsets.zero,
//       //           child: SizedBox(width: width, height: height),
//       //         ),
//       //         SizedBox(
//       //           width: width,
//       //           height: height,
//       //           child: CircularProgressIndicator(
//       //             value: progress,
//       //             strokeWidth: 6,
//       //             backgroundColor: Colors.transparent,
//       //             color: AppColors.primary,
//       //           ),
//       //         ),
//       //       ],
//       //     )
//       //     : DottedBorder(
//       //       borderType: BorderType.values.last,
//       //       dashPattern: [6, 4],
//       //       color: Colors.grey,
//       //       strokeWidth: 3,
//       //       padding: EdgeInsets.zero,
//       //       child: SizedBox(width: width, height: height),
//       //     ),
//     );
//   }
// }
