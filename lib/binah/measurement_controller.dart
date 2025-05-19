import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/images/image_data_listener.dart';
import 'package:biosensesignal_flutter_sdk/images/image_data.dart'
    as sdk_image_data;
import 'package:biosensesignal_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:biosensesignal_flutter_sdk/session/session.dart';
import 'package:biosensesignal_flutter_sdk/session/session_info_listener.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:biosensesignal_flutter_sdk/session/session_enabled_vital_signs.dart';
import 'package:biosensesignal_flutter_sdk/license/license_info.dart';
import 'package:biosensesignal_flutter_sdk/license/license_details.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_listener.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_blood_pressure.dart';
import 'package:biosensesignal_flutter_sdk/alerts/warning_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/error_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/alert_codes.dart';
import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';

class MeasurementController extends GetxController
    with StateMixin, GetTickerProviderStateMixin, ProgressHandlerMixin
    implements SessionInfoListener, VitalSignsListener, ImageDataListener {
  final _geustController = Get.find<GeustController>();
  final licenseKey = "5109AA-AA2AB0-4FCBA4-D140D7-480067-AC54E7";
  final measurementDuration = 35;
  Session? _session;
  final Rx<SessionState?> sessionState = Rx<SessionState?>(null);
  final RxnString error = RxnString();
  final RxnString warning = RxnString();
  final RxnString pulseRate = RxnString();
  final RxnString finalResultsString = RxnString();
  RxBool isMeasurementCanceled = false.obs;
  @override
  final RxBool showImageValidity = false.obs;
  Rx<VitalSignsResults> vitalsResults = VitalSignsResults().obs;
  // final RxString imageValidityString = ''.obs;
  final Rx<sdk_image_data.ImageData?> imageData = Rx<sdk_image_data.ImageData?>(
    null,
  );
  @override
  void onInit() {
    // screenInFocus();
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    animationController.addListener(() {
      progress.value = animationController.value;
      if (animationController.isCompleted) {
        isStarted.value = false;
      }
    });
    ever<String?>(warning, (value) {
      if (value != null && value.isNotEmpty) {
        // Fluttertoast.showToast(
        //   msg: value,
        //   toastLength: Toast.LENGTH_SHORT,
        //   textColor: Colors.white,
        // );
      }
    });

    // Show alert on error
    ever<String?>(error, (value) {
      if (value != null && value.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          isMeasurementCanceled.value = true;
          // showAlert(Get.context!, null, value);
          resetProgress();
          stopProgress();
          startStopButtonClicked();
        });
      }
    });
  }

  Future<void> screenInFocus() async {
    _requestCameraPermission().then((granted) {
      if (granted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await createSession();
        });
      }
    });
  }

  Future<void> startStopButtonClicked() async {
    showImageValidity.value = false;
    final state = sessionState.value;
    debugPrint("Start scanning $state");
    Future.delayed(Duration(seconds: 5), () {
      if (sessionState.value == SessionState.ready) {
        isMeasurementCanceled.value = false;
        _startMeasuring().then((v) {
          startProgress(seconds: 60);
        });

        debugPrint("Start scanning $state");
      } else if (state == SessionState.processing) {
        _stopMeasuring();
      }
    });
  }

  @override
  void onImageData(sdk_image_data.ImageData imageData) {
    this.imageData.value = imageData;
    debugPrint("Image validity: ${imageData.imageValidity}");

    switch (imageData.imageValidity) {
      case ImageValidity.valid:
        handleValid("Perfect! Please hold it.");
        break;

      case ImageValidity.invalidDeviceOrientation:
        handleInvalid("Invalid Orientation");
        break;

      case ImageValidity.invalidRoi:
      case ImageValidity.faceTooFar:
        handleInvalid("Please little Closer");
        break;

      case ImageValidity.tiltedHead:
        handleInvalid("Tilted Head");
        break;

      case ImageValidity.unevenLight:
        handleInvalid("Uneven Lighting");
        break;

      default:
        handleInvalid("Unknown Error");
        break;
    }
  }

  @override
  void onVitalSign(VitalSign vitalSign) {
    if (vitalSign.type == VitalSignTypes.bloodPressure) {
      pulseRate.value = "PR: ${(vitalSign as VitalSignBloodPressure).value}";
    }
  }

  @override
  void onFinalResults(VitalSignsResults finalResults) async {
    debugPrint(finalResults.getResults().toString());
    vitalsResults.value = finalResults;
    debugPrint("vitalsResults  ${vitalsResults.toString()}");
    debugPrint(
      "vitalsResults  ${vitalsResults.value.getResult(VitalSignTypes.sd1)},${vitalsResults.value.getResult(VitalSignTypes.sd2)},${vitalsResults.value.getResult(VitalSignTypes.prq)}",
    );
    if (vitalsResults.value.getResult(VitalSignTypes.pulseRate) != null) {
      startStopButtonClicked();
      if (scanType.value == "add-guest") {
        _geustController.addGuest(vitalsResults.value).whenComplete(() {
          AppNavigation.off(
            AppRoutes.allReportScreen,
            action: () {
              _geustController.clearData();
              _geustController.getGeustHistory();
            },
          );
        });
      } else {
        _geustController
            .storeBinahHealthForUser(vitalsResults.value)
            .whenComplete(() {
              AppNavigation.off(
                AppRoutes.allReportScreen,
                action: () {
                  _geustController.clearData();
                  _geustController.getGeustHistory();
                },
              );
            });
      }
    }
  }

  @override
  void onWarning(WarningData warningData) {
    if (warning.value != null) return;
    if (warningData.code ==
        AlertCodes.measurementCodeMisdetectionDurationExceedsLimitWarning) {
      pulseRate.value = "";
    }
    warning.value = "Warning: ${warningData.code}";
    Future.delayed(const Duration(seconds: 1), () => warning.value = null);
  }

  @override
  void onError(ErrorData errorData) {
    error.value = "Error: ${errorData.code}";
  }

  @override
  void onSessionStateChange(SessionState sessionState) {
    this.sessionState.value = sessionState;
    debugPrint(sessionState.toString());
    switch (sessionState) {
      case SessionState.ready:
        WakelockPlus.enable();
        break;
      case SessionState.terminating:
        WakelockPlus.disable();
        break;
      default:
        break;
    }
  }

  cloase() {
    resetProgress();
    stopProgress();
    closeProgress();
    _stopMeasuring();
    _terminateSession();
    _reset();
  }

  @override
  void onEnabledVitalSigns(SessionEnabledVitalSigns enabledVitalSigns) {}

  @override
  void onLicenseInfo(LicenseInfo licenseInfo) {}

  Future<void> createSession() async {
    // if (_session != null) {
    //   await _terminateSession();
    // }
    // _reset();
    try {
      _session = await FaceSessionBuilder()
          .withImageDataListener(this)
          .withVitalSignsListener(this)
          .withSessionInfoListener(this)
          .build(LicenseDetails(licenseKey));
    } on HealthMonitorException catch (e) {
      error.value = "Error: ${e.code}";
    }
  }

  Future<void> _startMeasuring() async {
    try {
      _reset();
      await _session?.start(measurementDuration);
      debugPrint("measurementDuration ${measurementDuration.toString()}");
      // startProgress(seconds: 30);
    } on HealthMonitorException catch (e) {
      error.value = "Error: ${e.code}";
    }
  }

  Future<void> _stopMeasuring() async {
    try {
      await _session?.stop();
    } on HealthMonitorException catch (e) {
      error.value = "Error: ${e.code}";
    }
  }

  Future<void> _terminateSession() async {
    await _session?.terminate();
    _session = null;
  }

  void _reset() {
    error.value = null;
    warning.value = null;
    pulseRate.value = null;
    finalResultsString.value = null;
  }

  Future<bool> _requestCameraPermission() async {
    final result = await Permission.camera.request();
    return result.isGranted;
  }
}

void showAlert(BuildContext context, String? title, String message) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: title != null ? Text(title) : null,
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  });
}
