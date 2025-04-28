import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_blood_pressure.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_mean_rri.dart';
import 'package:biosensesignal_flutter_sdk/alerts/warning_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/error_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/alert_codes.dart';
import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';

class MeasurementController extends GetxController
    with StateMixin
    implements SessionInfoListener, VitalSignsListener, ImageDataListener {
  final licenseKey = "5109AA-AA2AB0-4FCBA4-D140D7-480067-AC54E7";
  final measurementDuration = 60;

  Session? _session;

  final Rx<SessionState?> sessionState = Rx<SessionState?>(null);
  final RxnString error = RxnString();
  final RxnString warning = RxnString();
  final RxnString pulseRate = RxnString();
  final RxnString finalResultsString = RxnString();
  final RxBool showImageValidity = false.obs;
  Rx<VitalSignsResults> vitalsResults = VitalSignsResults().obs;
  final RxString imageValidityString = ''.obs;
  final Rx<sdk_image_data.ImageData?> imageData = Rx<sdk_image_data.ImageData?>(
    null,
  );
  @override
  void onInit() {
    super.onInit();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   screenInFocus(true); // ✅ this must be called
    // });

    // Show toast on warning
    ever<String?>(warning, (value) {
      if (value != null && value.isNotEmpty) {
        Fluttertoast.showToast(
          msg: value,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      }
    });

    // Show alert on error
    ever<String?>(error, (value) {
      if (value != null && value.isNotEmpty) {
        // Delay needed to wait until context is available
        Future.delayed(Duration.zero, () {
          showAlert(Get.context!, null, value);
        });
      }
    });

    // Show final results
    ever<String?>(finalResultsString, (value) {
      if (value != null && value.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          AppNavigation.to(AppRoutes.analyzingHealthData);
          // showAlert(Get.context!, "Final Results", value);
        });
      }
    });
  }

  screenInFocus(bool focus) {
    if (focus) {
      _requestCameraPermission().then((granted) {
        if (granted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _createSession();
          });
        }
      });
    } else {
      _terminateSession();
    }
  }

  void startStopButtonClicked() {
    showImageValidity.value = false;
    final state = sessionState.value;
    if (state == SessionState.ready) {
      debugPrint("Start scanning");
      _startMeasuring();
    } else if (state == SessionState.processing) {
      _stopMeasuring();
    }
  }

  @override
  void onImageData(sdk_image_data.ImageData imageData) {
    this.imageData.value = imageData;
    if (imageData.imageValidity != ImageValidity.valid) {
      showImageValidity.value = true;
      imageValidityString.value = switch (imageData.imageValidity) {
        ImageValidity.invalidDeviceOrientation => "Invalid Orientation",
        ImageValidity.invalidRoi => "Face Not Detected",
        ImageValidity.tiltedHead => "Tilted Head",
        ImageValidity.faceTooFar => "You are Too Far",
        ImageValidity.unevenLight => "Uneven Lighting",
        _ => "",
      };
    } else {
      showImageValidity.value = false;
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
    var pulseRateValue =
        (finalResults.getResult(VitalSignTypes.pulseRate)
                as VitalSignPulseRate?)
            ?.value ??
        "N/A";
    var meanRriValue =
        (finalResults.getResult(VitalSignTypes.meanRri) as VitalSignMeanRri?)
            ?.value ??
        "N/A";

    vitalsResults.value = finalResults;
    finalResultsString.value =
        "Pulse Rate: $pulseRateValue\nMean RRi: $meanRriValue";
    debugPrint(
      "pulseRate: ${finalResults.getResult(VitalSignTypes.pulseRate)},bloodPressure: ${finalResults.getResult(VitalSignTypes.bloodPressure)},heartAge: ${finalResults.getResult(VitalSignTypes.heartAge)}",
    );
    debugPrint(
      "hemoglobin: ${finalResults.getResult(VitalSignTypes.hemoglobin)},highTotalCholesterolRisk: ${finalResults.getResult(VitalSignTypes.highTotalCholesterolRisk)}, ascvdRisk: ${finalResults.getResult(VitalSignTypes.ascvdRisk)}",
    );
    debugPrint(
      "highFastingGlucoseRisk: ${finalResults.getResult(VitalSignTypes.highFastingGlucoseRisk)},highBloodPressureRisk: ${finalResults.getResult(VitalSignTypes.highBloodPressureRisk)},lowHemoglobinRisk:${finalResults.getResult(VitalSignTypes.lowHemoglobinRisk)}",
    );
    debugPrint(
      "lfhf: ${finalResults.getResult(VitalSignTypes.lfhf)},meanRri:${finalResults.getResult(VitalSignTypes.meanRri)},normalizedStressIndex: ${finalResults.getResult(VitalSignTypes.normalizedStressIndex)}",
    );
    debugPrint(
      "pnsIndex: ${finalResults.getResult(VitalSignTypes.pnsIndex)},pnsZone: ${finalResults.getResult(VitalSignTypes.pnsZone)},prq: ${finalResults.getResult(VitalSignTypes.prq)}",
    );
    debugPrint(
      "respirationRate: ${finalResults.getResult(VitalSignTypes.respirationRate)},rmssd: ${finalResults.getResult(VitalSignTypes.rmssd)},rri: ${finalResults.getResult(VitalSignTypes.rri)}",
    );
    debugPrint(
      "sdnn: ${finalResults.getResult(VitalSignTypes.sdnn)},snsIndex: ${finalResults.getResult(VitalSignTypes.snsIndex)},stressIndex: ${finalResults.getResult(VitalSignTypes.stressIndex)}",
    );
    debugPrint(
      "stressLevel: ${finalResults.getResult(VitalSignTypes.stressLevel)},wellnessIndex: ${finalResults.getResult(VitalSignTypes.wellnessIndex)},wellnessLevel: ${finalResults.getResult(VitalSignTypes.wellnessLevel)}",
    );

    // AppNavigation.to(AppRoutes.analyzingHealthData);
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
    debugPrint(sessionState.toString());
    this.sessionState.value = sessionState;

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

  @override
  void onEnabledVitalSigns(SessionEnabledVitalSigns enabledVitalSigns) {}

  @override
  void onLicenseInfo(LicenseInfo licenseInfo) {}

  Future<void> _createSession() async {
    if (_session != null) {
      await _terminateSession();
    }
    _reset();
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
