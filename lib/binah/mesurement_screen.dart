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
    controller.startStopButtonClicked();
    // controller.createSession();
    // controller.screenInFocus(true);
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeasurementController>();
    return Scaffold(
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
                      Obx(
                        () => Container(
                          color: const Color(0xFF3D3734),
                          padding: const EdgeInsets.all(5.0),
                          width: 180,
                          child: Column(
                            children: [
                              const Text(
                                "Image Validity",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                controller.imageValidityString.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Obx(() {
                      //   final state = controller.sessionState.value;

                      //   return Opacity(
                      //     opacity:
                      //         (controller.sessionState.value ==
                      //                     SessionState.ready ||
                      //                 controller.sessionState.value ==
                      //                     SessionState.processing)
                      //             ? 1.0
                      //             : 0.5,
                      //     child: InkWell(
                      //       onTap: controller.startStopButtonClicked,
                      //       child: Container(
                      //         width: 300,
                      //         height: 60,
                      //         alignment: Alignment.center,
                      //         padding: const EdgeInsets.symmetric(vertical: 20),
                      //         color: const Color(0xFF6200EE),
                      //         child: Text(
                      //           controller.sessionState.value ==
                      //                   SessionState.processing
                      //               ? "STOP ${controller.sessionState.value}"
                      //               : "START",
                      //           style: const TextStyle(color: Colors.white),
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }),
                    ],
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
