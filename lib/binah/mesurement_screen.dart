import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart'
    show SessionState;
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/start_stop_button.dart';
import 'package:ntt_data/binah/vital_sign_helper.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/dialog_halper.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'dart:async';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});
  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final controller = Get.find<MeasurementController>();
  final String scanType = Get.arguments["scanType"] ?? "";
  final String userName = Get.arguments["userName"] ?? "";
  final String guestId = Get.arguments["guestId"] ?? "";
  @override
  void dispose() {
    controller.cloase();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    controller.getScanMeassage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.scanType.value = scanType;
    // controller.guestId.value = guestId;
    final Size screenSize = MediaQuery.of(context).size;
    final double ovalWidth = screenSize.width * 0.8;
    final double ovalHeight = screenSize.height * 0.5;
    return FocusDetector(
      onFocusLost: () async {
        await controller.screenInFocus(
          false,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
          controller.selectionType.value,
        );
      },
      onFocusGained: () async {
        await controller.screenInFocus(
          true,
          controller.genderType.value,
          controller.age.value,
          controller.weight.value,
          controller.height.value,
          controller.selectionType.value,
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
                          width: AppDimensions.width(300),
                          child: LottieBuilder.asset(
                            AppAssets.scanAnimation,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                        ),
                        SizedBox(height: AppDimensions.height(30)),
                        CommonText.text(
                          "Generating Health Report",
                          fontSize: AppDimensions.font(16),
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
                                      screenSize.height / 3.4,
                                    ),
                                    radiusX: ovalWidth / 1.75,
                                    radiusY: ovalHeight / 1.8,
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
                                height: AppDimensions.height(241),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Visibility(
                                        visible:
                                            controller.isStarted.value == true,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: AppDimensions.symmetric(
                                              horizontal: 25,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                if (controller
                                                    .isFirstEver
                                                    .isTrue) {
                                                  controller.isFirstEver.value =
                                                      false;
                                                  controller
                                                      .stopMeasuring()
                                                      .then((v) {
                                                        controller
                                                            .isScanStop
                                                            .value = true;
                                                        controller
                                                            .stopeasurement();
                                                      });

                                                  DialogHelper.showStopAlertDialog(
                                                    Get.context!,
                                                  );
                                                }
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

                                    Obx(() {
                                      final imageData =
                                          controller.imageData.value;
                                      final isStarted =
                                          controller.isStarted.value;
                                      final sessionState =
                                          controller.sessionState.value;
                                      if (imageData != null &&
                                          imageData.imageValidity !=
                                              ImageValidity.valid &&
                                          isStarted) {
                                        return ImageValidityScan();
                                      } else if (imageData != null &&
                                          imageData.imageValidity ==
                                              ImageValidity.valid &&
                                          isStarted) {
                                        return Padding(
                                          padding: AppDimensions.only(
                                            bottom: 0,
                                          ),
                                          child: MeasurmentProgress(
                                            controller: controller,
                                          ),
                                        );
                                      } else if ((sessionState ==
                                                  SessionState.ready ||
                                              sessionState ==
                                                  SessionState.processing) &&
                                          !isStarted) {
                                        return StartStopButton(
                                          userName: userName,
                                        );
                                      } else {
                                        return Padding(
                                          padding: AppDimensions.all(80),
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                    // SizedBox(height: AppDimensions.height(10)),
                                  ],
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
      return SizedBox(
        height: AppDimensions.height(210),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.center, child: PulseRate()),
                Obx(() {
                  int currentProgress = controller.progress.value.toInt();
                  var helper = MeasurementHelper(
                    scanMessageList: controller.scanMessageList,
                  );

                  return Padding(
                    padding: AppDimensions.only(left: 20, right: 20, top: 10),
                    child: TypewriterText(
                      text: helper.getProgressMessage(currentProgress),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      speed: const Duration(
                        milliseconds: 40,
                      ), // Adjust typing speed
                    ),
                  );
                }),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.width(20),
                  vertical: 10,
                ),
                child: FAProgressBar(
                  progressColor: Colors.green,
                  currentValue:
                      controller.progress.value
                          .toDouble(), // convert int → double
                  displayText: "%",
                  formatValue:
                      (value, _) =>
                          value.toInt().toString(), // show only integer
                  // ensures no extra decimals
                ),
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

class TypewriterText extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLines;
  final Duration speed;

  const TypewriterText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.speed = const Duration(milliseconds: 50),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _displayedText = '';
    _currentIndex = 0;

    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer.cancel();
      _startTyping();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonText.text(
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      _displayedText,
    );
  }
}
