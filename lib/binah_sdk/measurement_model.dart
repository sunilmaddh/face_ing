import 'dart:async';
import 'package:biosensesignal_flutter_sdk/images/image_validity.dart';
import 'package:biosensesignal_flutter_sdk/license/license_details.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_blood_pressure.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_mean_rri.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:biosensesignal_flutter_sdk/images/image_data_listener.dart';
import 'package:biosensesignal_flutter_sdk/images/image_data.dart'
    as sdk_image_data;
import 'package:biosensesignal_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:biosensesignal_flutter_sdk/session/session.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_listener.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:biosensesignal_flutter_sdk/alerts/warning_data.dart';
import 'package:biosensesignal_flutter_sdk/alerts/error_data.dart';
import 'package:biosensesignal_flutter_sdk/license/license_info.dart';
import 'package:biosensesignal_flutter_sdk/session/session_state.dart';
import 'package:biosensesignal_flutter_sdk/session/session_enabled_vital_signs.dart';
import 'package:biosensesignal_flutter_sdk/session/session_info_listener.dart';
import 'package:biosensesignal_flutter_sdk/alerts/alert_codes.dart';
import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';

class MeasurementModel extends ChangeNotifier
    implements SessionInfoListener, VitalSignsListener, ImageDataListener {
  final licenseKey = "5109AA-AA2AB0-4FCBA4-D140D7-480067-AC54E7";
  final measurementDuration = 60;
  Session? _session;
  sdk_image_data.ImageData? imageData;

  String? error;
  String? warning;
  SessionState? sessionState;
  String? pulseRate;
  String? finalResultsString;
  String imageValidityString = "";
  bool showImageValidity = false;

  screenInFocus(bool focus) async {
    if (focus) {
      if (!await _requestCameraPermission()) {
        return;
      }

      _createSession();
    } else {
      _terminateSession();
    }
  }

  void startStopButtonClicked() {
    showImageValidity = false;
    switch (sessionState) {
      case SessionState.ready:
        _startMeasuring();
        break;
      case SessionState.processing:
        _stopMeasuring();
        break;
      default:
        break;
    }
  }

  @override
  void onImageData(sdk_image_data.ImageData imageData) {
    this.imageData = imageData;
    if (imageData.imageValidity != ImageValidity.valid) {
      showImageValidity = true;
      switch (imageData.imageValidity) {
        case ImageValidity.invalidDeviceOrientation:
          imageValidityString = "Invalid Orientation";
          break;
        case ImageValidity.invalidRoi:
          imageValidityString = "Face Not Detected";
          break;
        case ImageValidity.tiltedHead:
          imageValidityString = "Titled Head";
          break;
        case ImageValidity.faceTooFar:
          imageValidityString = "You are Too Far";
          break;
        case ImageValidity.unevenLight:
          imageValidityString = "Uneven Lighting";
          break;
      }
    } else {
      showImageValidity = false;
    }
    notifyListeners();
  }

  @override
  void onVitalSign(VitalSign vitalSign) {
    if (vitalSign.type == VitalSignTypes.bloodPressure) {
      pulseRate = "PR: ${(vitalSign as VitalSignBloodPressure).value}";
      notifyListeners();
    }
  }

  /////////
  @override
  void onFinalResults(VitalSignsResults finalResults) async {
    var pulseRateValue =
        (finalResults.getResult(VitalSignTypes.pulseRate)
                as VitalSignPulseRate?)
            ?.value ??
        "N/A";
    var meanRriValue =
        (finalResults.getResult(VitalSignTypes.meanRri) as VitalSignMeanRri?)
            ?.value ??
        "N/A";
    finalResultsString = "Pulse Rate: $pulseRateValue\nMean RRi: $meanRriValue";
    notifyListeners();
  }

  @override
  void onWarning(WarningData warningData) {
    if (warning != null) {
      return;
    }

    if (warningData.code ==
        AlertCodes.measurementCodeMisdetectionDurationExceedsLimitWarning) {
      pulseRate = "";
    }

    warning = "Warning: ${warningData.code}";
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      warning = null;
    });
  }

  @override
  void onError(ErrorData errorData) {
    error = "Error: ${errorData.code}";
    notifyListeners();
  }

  @override
  void onSessionStateChange(SessionState sessionState) {
    this.sessionState = sessionState;
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

    notifyListeners();
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
          //.withAnalytics()
          .build(LicenseDetails(licenseKey));
    } on HealthMonitorException catch (e) {
      error = "Error: ${e.code}";
      notifyListeners();
    }
  }

  Future<void> _startMeasuring() async {
    try {
      _reset();
      await _session?.start(measurementDuration);
      notifyListeners();
    } on HealthMonitorException catch (e) {
      error = "Error: ${e.code}";
    }
  }

  Future<void> _stopMeasuring() async {
    try {
      await _session?.stop();
    } on HealthMonitorException catch (e) {
      error = "Error: ${e.code}";
    }
  }

  Future<void> _terminateSession() async {
    await _session?.terminate();
    _session = null;
  }

  void _reset() {
    error = null;
    warning = null;
    pulseRate = null;
    finalResultsString = null;
    notifyListeners();
  }

  Future<bool> _requestCameraPermission() async {
    PermissionStatus result;
    result = await Permission.camera.request();
    return result.isGranted;
  }
}
