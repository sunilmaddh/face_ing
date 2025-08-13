import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/views/profile/helper/profile_helper.dart';

class DialogHelper {
  void showBatteryLevelAlertDialog(BuildContext context) {
    CommonDialog().showScanDialog(
      confirmText: "Try Again",
      title: "Your batter is low",
      message:
          "Please charge your battery level to at least 20% in order to start a new measurement",
      context: context,
      onConfirm: () {
        // TODO: Implement start scan logic here
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  static void showScanFailedDialog(BuildContext context) {
    CommonDialog().showScanDialog(
      title: "Scan Failed",
      message:
          "Possible causes include low light, misalignment, or camera error. Would you like to try again?",
      context: Get.context!,
      onConfirm: () {},
      onCancel: () {
        Get.back();
      },
      confirmText: 'Try Again',
    );
  }

  static void showStopAlertDialog(BuildContext context) {
    CommonDialog().showScanDialog(
      title: "Scan Alert",
      message:
          "The scan has been stopped. Do you want to start the scan again?",
      context: context,
      onConfirm: () {
        // controller
        //     .stopMeasuring();
      },
      onCancel: () {
        Get.back();
      },
      confirmText: 'Try Again',
    );
  }

  static void showLogoutDialog(BuildContext context, bool isLoading) {
    CommonDialog().showLogoutDialog(
      isLogoutLoading: isLoading,
      title: "Want to Logout?",
      message: "Are you sure want to logout?",
      context: context,
      onConfirm: () async {
        await ProfileHelper().logoutHelper();

        // controller
        //     .stopMeasuring();
      },
      onCancel: () {
        Get.back();
      },
      confirmText: 'Yes',
    );
  }
}
