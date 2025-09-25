import 'dart:async';
import 'dart:io';
import 'package:biosensesignal_flutter_sdk/session/demographics/sex.dart';
import 'package:biosensesignal_flutter_sdk/session/smoking_status.dart';
import 'package:biosensesignal_flutter_sdk/session/user_information.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/binah/handler/vital__result_handler.dart';
import 'package:ntt_data/binah/handler/vital_navigation_service.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/dialog/dialog_halper.dart';
import 'package:ntt_data/data/models/binah_scan_progress_message_response.dart';
import 'package:ntt_data/data/repository/services/measurement_services.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
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
import 'package:biosensesignal_flutter_sdk/health_monitor_exception.dart';

class MeasurementController extends GetxController
    with
        StateMixin,
        GetTickerProviderStateMixin,
        ProgressHandlerMixin,
        RadioStateMixin
    implements SessionInfoListener, VitalSignsListener, ImageDataListener {
  final _geustController = Get.find<GeustController>();
  final licenseKey = AppConstents.licenceKey;
  final measurementDuration = 60;
  Session? _session;
  final Rx<SessionState?> sessionState = Rx<SessionState?>(null);
  final RxnString error = RxnString();
  final RxnString warning = RxnString();
  final RxString pulseRate = "".obs;

  final RxString genderType = "".obs;
  final RxDouble age = 0.0.obs;
  final RxDouble weight = 0.0.obs;
  final RxDouble height = 0.0.obs;
  final RxBool isScanStop = false.obs;
  final RxBool isFirstEver = false.obs;
  late final VitalResultsHandler _resultsHandler;
  @override
  final RxBool isStarted = false.obs;
  final RxBool isScanningDone = false.obs;
  RxBool isLoading = false.obs;
  RxString smokerType = ''.obs;
  RxString guestId = "".obs;
  final TextEditingController smokerTypeController = TextEditingController();

  RxList<String> scanMessageList = <String>[].obs;

  RxList<String> vitlaList = <String>[].obs;
  @override
  // ignore: overridden_fields
  final RxBool showImageValidity = false.obs;
  Rx<VitalSignsResults> vitalsResults = VitalSignsResults().obs;
  final Rx<sdk_image_data.ImageData?> imageData = Rx<sdk_image_data.ImageData?>(
    null,
  );
  @override
  void onInit() {
    super.onInit();
    _resultsHandler = VitalResultsHandler(
      vitalsResults: vitalsResults,
      isFirstEver: isFirstEver,
      isScanningDone: isScanningDone,
      scanType: scanType,
      guestController: _geustController,
      guestId: guestId,
      navigation: VitalNavigationService(),
    );
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    animationController.addListener(() {
      progress.value = (animationController.value * 100).toInt();
      if (animationController.isCompleted) {
        if (isStarted.isTrue) {
          isScanningDone.value = true;
        } else {
          isScanningDone.value = false;
        }
        isStarted.value = false;
      }
    });

    // Show alert on error
    ever<String?>(error, (value) {
      if (value != null && value.isNotEmpty) {
        debugPrint("Sdk error $value");
        Future.delayed(Duration.zero, () async {
          isLoading.value = false;
          resetProgress();
          stopProgress();
          await _reset();
          if (isFirstEver.isTrue) {
            isFirstEver.value = false;
            isScanningDone.value = false;
            DialogHelper.showScanFailedDialog(Get.context!);
          }
        });
      }
    });
  }

  Future<void> screenInFocus(
    bool focus,
    String genderType,
    double age,
    double weight,
    double height,
    String smokerType,
  ) async {
    if (focus) {
      if (Platform.isAndroid) {
        if (!await _requestCameraPermission()) {
          return;
        }
      }
      await createSession(genderType, age, weight, height, smokerType);
    } else {
      await _terminateSession();
    }
  }

  Future<void> startStopButtonClicked() async {
    showImageValidity.value = false;
    final state = sessionState.value;
    debugPrint("Start scanning $state");
    Future.delayed(Duration(seconds: 5), () {
      if (sessionState.value == SessionState.ready) {
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
        handleInvalid("Return to portrait mode.");
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
    await _resultsHandler.handleFinalResults(finalResults);
  }

  @override
  void onWarning(WarningData warningData) {
    if (warning.value != null) return;
    warning.value = "Warning: ${warningData.code}";
    Future.delayed(const Duration(seconds: 1), () => warning.value = null);
  }

  @override
  void onError(ErrorData errorData) {
    error.value = "Error: ${errorData.code}";
    debugPrint("Error: ${errorData.code}");
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

  cloase() async {
    resetProgress();
    stopProgress();
    closeProgress();
    if (state == SessionState.processing) {
      stopMeasuring();
    }
    await _terminateSession();
    await _reset();
    scanMessageList.clear();
  }

  stopeasurement() async {
    resetProgress();
    stopProgress();
    closeProgress();
    await _reset();
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
    await _reset();
    debugPrint("user2 Information $genderType$weight$height,$age,$smokerType");
    var userInformation = UserInformation(
      sex: genderType == "Male" ? Sex.male : Sex.female,
      age: age,
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
      if (_session != null && sessionState.value == SessionState.ready) {
        await _session?.start(measurementDuration);
      }
      debugPrint("measurementDuration ${measurementDuration.toString()}");
    } on HealthMonitorException catch (e) {
      error.value = "Error: ${e.code}";
    }
  }

  Future<void> stopMeasuring() async {
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

  Future<void> _reset() async {
    error.value = null;
    warning.value = null;
    pulseRate.value = "";
    isLoading.value = false;
    isStarted.value = false;
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  Future<void> getScanMeassage() async {
    try {
      Map<String, dynamic> responseData =
          await MeasurementServices().getScanMesageServices();
      int statusCode = responseData[AppConstents.statusCode];
      if (statusCode == 200) {
        var result = BinahScanProgressMessageResponse.fromJson(
          responseData[AppConstents.response],
        );
        scanMessageList.value = result.scannedMessage!;
      } else {
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      }
    } catch (e) {
      AppSnackbar.show(title: "Exception", message: e.toString());
    }
  }
}
