import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/start_stop_button.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});
  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final controller = Get.find<MeasurementController>();
  final String scanType = Get.arguments["scanType"] ?? "";
  final String userName = Get.arguments["userName"] ?? "";
  @override
  void dispose() {
    // TODO: implement dispose
    controller.cloase();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.scanType.value = scanType;
    final Size screenSize = MediaQuery.of(context).size;
    final double ovalWidth = screenSize.width * 0.8;
    final double ovalHeight = screenSize.height * 0.5;
    return FocusDetector(
      onFocusLost: () {
        controller.screenInFocus(
          false,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
          "Smoker",
        );
      },
      onFocusGained: () {
        controller.screenInFocus(
          true,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
          "Smoker",
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Measurement",
          onTop: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        body: Obx(
          () =>
              controller.isScanningDone.isTrue
                  ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          child: LottieBuilder.asset(
                            AppAssets.scanAnimation,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                        ),
                        SizedBox(height: 30),
                        CommonText.text(
                          "Generating Health Report",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  )
                  : Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            CameraPreview(controller: controller),
                            Positioned.fill(
                              child: Obx(() {
                                return CustomPaint(
                                  painter: OverlayWithOvalHolePainter(
                                    center: Offset(
                                      screenSize.width / 2,
                                      screenSize.height / 2.6,
                                    ),
                                    radiusX: ovalWidth / 2,
                                    radiusY: ovalHeight / 2,
                                    overlayColor:
                                        controller.imageData.value != null &&
                                                controller
                                                        .imageData
                                                        .value!
                                                        .imageValidity !=
                                                    ImageValidity.valid
                                            ? AppColors.camreraPreviewColor
                                                .withOpacity(0.6)
                                            : Colors.black.withOpacity(0.3),
                                  ),
                                );
                              }),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: AppDimensions.height(250),
                                padding: EdgeInsets.only(
                                  bottom: AppDimensions.height(20),
                                  top: AppDimensions.height(8.0),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Visibility(
                                          visible:
                                              controller.isStarted.value ==
                                              true,
                                          child: SafeArea(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  CommonDialog().showScanDialog(
                                                    title: " 'Scan Failed'",
                                                    message:
                                                        "Possible causes include low light, misalignment, or camera error. Would you like to try again?",
                                                    context: Get.context!,
                                                    onConfirm: () {
                                                      controller
                                                          .stopMeasuring();
                                                      controller
                                                          .startStopButtonClicked();
                                                    },
                                                    onCancel: () {
                                                      controller
                                                          .stopMeasuring();
                                                    },
                                                  );
                                                },
                                                child: CommonText.text(
                                                  "Stop",
                                                  color: AppColors.blackColor,
                                                  fontSize: AppDimensions.font(
                                                    18,
                                                  ),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: AppDimensions.height(10),
                                      ),
                                      ImageValidityScan(),
                                      MeasurmentProgress(
                                        controller: controller,
                                      ),
                                      SizedBox(
                                        height: AppDimensions.height(10),
                                      ),
                                      StartStopButton(userName: userName),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}

class MeasurmentProgress extends StatelessWidget {
  const MeasurmentProgress({super.key, required this.controller});

  final MeasurementController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible:
            controller.imageData.value != null &&
            controller.imageData.value!.imageValidity == ImageValidity.valid &&
            controller.isStarted.value == true,
        child: Column(
          children: [
            PulseRate(),

            SizedBox(
              width: 300,
              height: AppDimensions.height(80),
              child: LottieBuilder.asset(
                AppAssets.heartRateAnim,
                fit: BoxFit.fill,
                repeat: true,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.width(20),
              ),
              child: FAProgressBar(
                progressColor: Colors.green,
                currentValue: controller.progress.value.toDouble(),
                displayText: "%",
              ),
            ),
          ],
        ),
      );
    });
  }
}

class OverlayWithOvalHolePainter extends CustomPainter {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final Color overlayColor;

  OverlayWithOvalHolePainter({
    required this.center,
    required this.radiusX,
    required this.radiusY,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path screenPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final Path ovalPath =
        Path()..addOval(
          Rect.fromCenter(
            center: center,
            width: radiusX * 2,
            height: radiusY * 2,
          ),
        );

    final Path mask = Path.combine(
      PathOperation.difference,
      screenPath,
      ovalPath,
    );

    canvas.drawPath(mask, Paint()..color = overlayColor);
  }

  @override
  bool shouldRepaint(covariant OverlayWithOvalHolePainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.radiusX != radiusX ||
        oldDelegate.radiusY != radiusY ||
        oldDelegate.overlayColor != overlayColor;
  }
}
