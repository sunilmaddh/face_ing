import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ntt_data/binah/measurement_controller.dart';

class FaceDetectionCircleWidget extends StatelessWidget {
  const FaceDetectionCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final progressController = Get.find<MeasurementController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaceDetectionCircle(
            progress: progressController.progress.value,
            isStarted: progressController.isStarted.value,
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     progressController.startProgress(seconds: 30);
          //   },
          //   child: const Text("Start"),
          // ),
        ],
      );
    });
  }
}

class FaceDetectionCircle extends StatelessWidget {
  final double progress;
  final bool isStarted;

  const FaceDetectionCircle({
    super.key,
    required this.progress,
    required this.isStarted,
  });

  @override
  Widget build(BuildContext context) {
    double width = 300;
    double height = 400;

    return SizedBox(
      width: width,
      height: height,
      child:
          isStarted
              ? Stack(
                alignment: Alignment.center,
                children: [
                  DottedBorder(
                    borderType: BorderType.values.last,
                    dashPattern: [6, 4],
                    color: Colors.blueAccent,
                    strokeWidth: 3,
                    padding: EdgeInsets.zero,
                    child: Container(width: width, height: height),
                  ),
                  SizedBox(
                    width: width + 10,
                    height: height + 10,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: Colors.transparent,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              )
              : DottedBorder(
                borderType: BorderType.values.last,
                dashPattern: [6, 4],
                color: Colors.blueAccent,
                strokeWidth: 3,
                padding: EdgeInsets.zero,
                child: Container(width: width, height: height),
              ),
    );
  }
}
