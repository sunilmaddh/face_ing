import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
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
    controller.isMeasurementCanceled.value = false;
    controller.scanType.value = scanType;
    controller.startStopButtonClicked();
    return Scaffold(
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
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: AppDimensions.height(120)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () =>
                            controller.isMeasurementCanceled.value
                                ? Text(
                                  "Measurement canceled.",

                                  style: TextStyle(
                                    color: AppColors.backArrowColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppDimensions.font(24),
                                  ),
                                )
                                : Text(
                                  controller.imageValidityString.value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.font(18),
                                  ),
                                ),
                      ),

                      SizedBox(height: AppDimensions.height(30)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: AppDimensions.height(190)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () =>
                          (controller.sessionState.value == null ||
                                  controller.sessionState.value ==
                                      SessionState.initializing)
                              ? Container()
                              : CameraPreview(),
                    ),
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
