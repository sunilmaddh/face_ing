import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:ntt_data/binah/camera_preview.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/binah/start_stop_button.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final controller = Get.find<MeasurementController>();
  @override
  void initState() {
    // controller.screenInFocus(true);
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return FocusDetector(
      onFocusLost: () => controller.screenInFocus(false),
      onFocusGained: () => controller.screenInFocus(true),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Obx(
                    () =>
                        (controller.sessionState.value == null ||
                                controller.sessionState.value ==
                                    SessionState.initializing)
                            ? Container()
                            : CameraPreview(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageValidityScan(),
                        SizedBox(height: 30),
                        // Text("Wait for 60 sec"),
                        // SizedBox(height: 30),
                        StartStopButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
