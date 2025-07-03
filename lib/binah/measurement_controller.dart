import 'dart:async';
import 'package:biosensesignal_flutter_sdk/session/demographics/sex.dart';
import 'package:biosensesignal_flutter_sdk/session/smoking_status.dart';
import 'package:biosensesignal_flutter_sdk/session/user_information.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
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
import 'package:biosensesignal_flutter_sdk/alerts/warning_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/error_data.dart';
// import 'package:biosensesignal_flutter_sdk/alerts/alert_codes.dart';
import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';

class MeasurementController extends GetxController
    with StateMixin, GetTickerProviderStateMixin, ProgressHandlerMixin
    implements SessionInfoListener, VitalSignsListener, ImageDataListener {
  final _geustController = Get.find<GeustController>();
  final licenseKey = "5109AA-AA2AB0-4FCBA4-D140D7-480067-AC54E7";
  final measurementDuration = 60;
  Session? _session;
  final Rx<SessionState?> sessionState = Rx<SessionState?>(null);
  final RxnString error = RxnString();
  final RxnString warning = RxnString();
  final RxString pulseRate = "".obs;
  final RxnString finalResultsString = RxnString();
  final RxString genderType = "".obs;
  final RxDouble age = 0.0.obs;
  final RxDouble weight = 0.0.obs;
  final RxDouble height = 0.0.obs;
  final RxBool isStarted = false.obs;
  RxBool isLoading = false.obs;
  RxString smokerType = ''.obs;
  RxBool isMeasurementCanceled = false.obs;
  RxList<String> vitlaList = <String>[].obs;
  @override
  final RxBool showImageValidity = false.obs;
  Rx<VitalSignsResults> vitalsResults = VitalSignsResults().obs;
  final Rx<sdk_image_data.ImageData?> imageData = Rx<sdk_image_data.ImageData?>(
    null,
  );
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    animationController.addListener(() {
      progress.value = (animationController.value * 100).toInt();
      if (animationController.isCompleted) {
        isStarted.value = false;
      }
    });
    ever<String?>(warning, (value) {
      if (value != null && value.isNotEmpty) {}
    });

    // Show alert on error
    ever<String?>(error, (value) {
      if (value != null && value.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          isMeasurementCanceled.value = true;
          resetProgress();
          stopProgress();
          startStopButtonClicked();
        });
      }
    });
  }

  screenInFocus(
    bool focus,
    String genderType,
    double age,
    double weight,
    double height,
    String smokerType,
  ) async {
    if (focus) {
      if (!await _requestCameraPermission()) {
        return;
      }
      createSession(genderType, age, weight, height, smokerType);
    } else {
      _terminateSession();
    }
  }

  Future<void> startStopButtonClicked() async {
    showImageValidity.value = false;
    final state = sessionState.value;
    debugPrint("Start scanning $state");
    Future.delayed(Duration(seconds: 5), () {
      if (sessionState.value == SessionState.ready) {
        isMeasurementCanceled.value = false;
        isStarted.value = true;
        _startMeasuring().then((v) {
          isLoading.value = false;
          startProgress(seconds: 60);
        });

        debugPrint("Start scanning $state");
      } else if (state == SessionState.processing) {
        isLoading.value = false;
        isStarted.value = false;
        stopMeasuring();
      }
    });
  }

  @override
  void onImageData(sdk_image_data.ImageData imageData) {
    this.imageData.value = imageData;
    debugPrint("Image validity: ${imageData.imageValidity}");
    showImageValidity.value = true;
    switch (imageData.imageValidity) {
      case ImageValidity.valid:
        handleValid("Perfect! Please hold it.");
        break;

      case ImageValidity.invalidDeviceOrientation:
        handleInvalid("Retrun to the portrait mode.");
        break;

      case ImageValidity.invalidRoi:
      case ImageValidity.faceTooFar:
        handleInvalid("Please move your face closer to the camera.");
        break;

      case ImageValidity.tiltedHead:
        handleInvalid(
          "Make sure your head is upright and centered in the frame.",
        );
        break;

      case ImageValidity.unevenLight:
        handleInvalid(
          "Ensure your face is clearly visible with no shadows or bright spots.",
        );
        break;

      default:
        handleInvalid("Unknown Error");
        break;
    }
  }

  @override
  void onVitalSign(VitalSign vitalSign) {
    if (vitalSign.type == VitalSignTypes.pulseRate) {
      pulseRate.value = (vitalSign as VitalSignPulseRate).value.toString();
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
    vitlaList.value = [
      vitalsResults.value.getResult(VitalSignTypes.wellnessIndex).toString(),
      vitalsResults.value.getResult(VitalSignTypes.wellnessIndex).toString(),
      vitalsResults.value.getResult(VitalSignTypes.respirationRate).toString(),
      vitalsResults.value.getResult(VitalSignTypes.pulseRate).toString(),
      vitalsResults.value.getResult(VitalSignTypes.prq).toString(),
      vitalsResults.value.getResult(VitalSignTypes.bloodPressure).toString(),
      vitalsResults.value.getResult(VitalSignTypes.oxygenSaturation).toString(),
      vitalsResults.value.getResult(VitalSignTypes.hemoglobin).toString(),
      vitalsResults.value.getResult(VitalSignTypes.hemoglobinA1C).toString(),
      vitalsResults.value.getResult(VitalSignTypes.ascvdRisk).toString(),
      vitalsResults.value.getResult(VitalSignTypes.heartAge).toString(),
      vitalsResults.value
          .getResult(VitalSignTypes.highBloodPressureRisk)
          .toString(),
      vitalsResults.value
          .getResult(VitalSignTypes.highHemoglobinA1CRisk)
          .toString(),
      vitalsResults.value
          .getResult(VitalSignTypes.highFastingGlucoseRisk)
          .toString(),
      vitalsResults.value
          .getResult(VitalSignTypes.highTotalCholesterolRisk)
          .toString(),
      vitalsResults.value
          .getResult(VitalSignTypes.lowHemoglobinRisk)
          .toString(),
      vitalsResults.value.getResult(VitalSignTypes.stressIndex).toString(),
      vitalsResults.value.getResult(VitalSignTypes.sdnn).toString(),
      vitalsResults.value.getResult(VitalSignTypes.lfhf).toString(),
    ];
    debugPrint("Stress index $vitlaList");
    debugPrint(
      "Stress index${vitalsResults.value.getResult(VitalSignTypes.stressIndex)}",
    );
    if (vitalsResults.value.getResult(VitalSignTypes.pulseRate) != null) {
      startStopButtonClicked();
      if (scanType.value == "add-guest") {
        _geustController.addGuest(vitalsResults.value).whenComplete(() {
          AppNavigation.off(
            AppRoutes.analyzingHealthData,
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
    // if (warningData.code ==
    //     AlertCodes.measurementCodeMisdetectionDurationExceedsLimitWarning) {
    //   pulseRate.value = "";
    // }
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
    stopMeasuring();
    _terminateSession();
    _reset();
  }

  @override
  void onEnabledVitalSigns(SessionEnabledVitalSigns enabledVitalSigns) {}

  @override
  void onLicenseInfo(LicenseInfo licenseInfo) {}

  Future<void> createSession(
    String genderType,
    double age,
    double weight,
    double height,
    String smokerType,
  ) async {
    if (_session != null) {
      await _terminateSession();
    }
    _reset();

    debugPrint("user2 Information $genderType$weight$height,$age,$smokerType");
    var userInformation = UserInformation(
      sex: genderType == "Male" ? Sex.male : Sex.female,
      age: 30.0,
      weight: weight,
      height: height,
      smokingStatus:
          smokerType == "Smoker"
              ? SmokingStatus.smoker
              : SmokingStatus.nonSmoker,
    );
    try {
      _session = await FaceSessionBuilder()
          .withUserInformation(userInformation)
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

  Future<void> stopMeasuring() async {
    try {
      _reset();
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
    pulseRate.value = "";
    finalResultsString.value = null;
    isStarted.value = false;
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
