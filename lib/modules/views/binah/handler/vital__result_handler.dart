import 'package:biosensesignal_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/handler/vital_navigation_service.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/dialog/dialog_halper.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';

class VitalResultsHandler {
  final Rx<VitalSignsResults> vitalsResults;
  final RxBool isFirstEver;
  final RxBool isScanningDone;
  final RxString scanType;
  final GeustController _guestController;
  final RxString guestId;
  final VitalNavigationService _navigation;

  VitalResultsHandler({
    required this.vitalsResults,
    required this.isFirstEver,
    required this.isScanningDone,
    required this.scanType,
    required GeustController guestController,
    required this.guestId,
    required VitalNavigationService navigation,
  }) : _guestController = guestController,
       _navigation = navigation;

  Future<void> handleFinalResults(VitalSignsResults finalResults) async {
    try {
      _safeLogResults(finalResults);
      vitalsResults.value = finalResults;
      final isInvalid = await ProgressHandlerMixin.checkingVitalResult(
        vitalsResults.value,
      );
      if (!isScanningDone.isTrue) {
        _timeoutFallback();
        return;
      }
      if (isInvalid) {
        _handleInvalidResults();
        return;
      }
      _handleValidResults(finalResults);
    } catch (e, s) {
      _handleException(e, s);
    }
  }

  // ----------------- PRIVATE HELPERS -----------------

  void _safeLogResults(VitalSignsResults finalResults) {
    try {
      debugPrint("Final Results received: ${finalResults.getResults()}");
      debugPrint(
        "HRV → SD1: ${finalResults.getResult(VitalSignTypes.sd1)}, "
        "SD2: ${finalResults.getResult(VitalSignTypes.sd2)}, "
        "PRQ: ${finalResults.getResult(VitalSignTypes.prq)}",
      );
      debugPrint(
        "Stress index: ${finalResults.getResult(VitalSignTypes.stressIndex)}",
      );
    } catch (e, s) {
      debugPrint("Error logging results: $e\n$s");
    }
  }

  void _timeoutFallback() {
    Future.delayed(const Duration(seconds: 5), () {
      isFirstEver.value = false;
      isScanningDone.value = false;
    });
  }

  void _handleInvalidResults() {
    if (isFirstEver.isTrue) {
      debugPrint("SDK Error: Invalid results in onFinal");
      isFirstEver.value = false;
      isScanningDone.value = false;
      DialogHelper.showScanFailedDialog(Get.context!);
    }
  }

  void _handleValidResults(VitalSignsResults finalResults) async {
    final isFullStory = await IndoSharedPreference.instance.getHistoryType();
    isFirstEver.value = false;
    if (finalResults.getResult(VitalSignTypes.pulseRate) == null) {
      debugPrint("Pulse Rate missing, stopping flow");
      return;
    }
    if (scanType.value == "add-guest") {
      _guestController.addGuest(finalResults).whenComplete(() {
        _navigation.goToReport(
          action: () {
            isScanningDone(false);
            GuestHalper().clearData();
            _guestController.getGeustHistory();
            Get.back();
          },
          isFullStory: isFullStory,
        );
      });
    } else {
      _guestController
          .storeBinahHealthForUser(
            finalResults,
            guestId: scanType.value == "re-scan" ? guestId.value : '',
            isUser: scanType.value == "re-scan" ? 'false' : 'true',
          )
          .whenComplete(() {
            _navigation.goToReport(
              isFullStory: isFullStory,
              action: () {
                isScanningDone(false);
              },
            );
          });
    }
  }

  void _handleException(dynamic e, StackTrace s) {
    debugPrint("Exception in handleFinalResults: $e\n$s");
    isFirstEver.value = false;
    isScanningDone.value = false;
    DialogHelper.showScanFailedDialog(Get.context!);
  }
}
