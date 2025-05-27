import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});
  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final controller = Get.find<MeasurementController>();
  final String scanType = Get.arguments["scanType"] ?? "";
  @override
  void dispose() {
    // TODO: implement dispose
    controller.cloase();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() {
    //   controller.isMeasurementCanceled.value = false;
    //   controller.scanType.value = scanType;
    //   controller.startStopButtonClicked();
    // });

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        onTop: () {
          AppNavigation.back();
        },
        title: "",
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: AppDimensions.height(120)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: AppDimensions.height(30)),
                        Text(
                          textAlign: TextAlign.center,
                          "47 bpm",
                          style: TextStyle(
                            color: AppColors.backArrowColor,
                            fontWeight: FontWeight.w500,

                            fontSize: AppDimensions.font(16),
                          ),
                        ),
                        SizedBox(
                          height: AppDimensions.height(100),
                          child: LottieBuilder.asset(AppAssets.heartRateAnim),
                        ),
                        SizedBox(height: AppDimensions.height(30)),

                        // LinearProgressIndicator(),
                        FAProgressBar(currentValue: 50.0, displayText: "%"),

                        // Obx(
                        //   () =>
                        //       controller.isMeasurementCanceled.value
                        //           ? Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //               horizontal: 30.0,
                        //             ),
                        //             child: Text(
                        //               textAlign: TextAlign.center,
                        //               "The measurement was canceled. Please wait while we prepare to restart.",
                        //               style: TextStyle(
                        //                 color: AppColors.backArrowColor,
                        //                 fontWeight: FontWeight.w500,

                        //                 fontSize: AppDimensions.font(16),
                        //               ),
                        //             ),
                        //           )
                        //           : Text(
                        //             controller.imageValidityString.value,
                        //             style: TextStyle(
                        //               color: Colors.black,
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: AppDimensions.font(18),
                        //             ),
                        //           ),
                        // ),
                        SizedBox(height: AppDimensions.height(30)),
                        // Image.asset("assets/images/png/redheart.jpg"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.height(190)),
                  child: Align(
                    alignment: Alignment.center,
                    child: CameraPreview(),
                    //  Obx(
                    //   () =>
                    //       (controller.sessionState.value == null ||
                    //               controller.sessionState.value ==
                    //                   SessionState.initializing)
                    //           ? Container()
                    //           : CameraPreview(),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
