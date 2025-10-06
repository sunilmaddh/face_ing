import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';

class NetworkUtil {
  static Future<bool> isInternetConnected() async {
    bool isConnected = false;
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    for (var res in result) {
      isConnected =
          res == ConnectivityResult.mobile || res == ConnectivityResult.wifi;
    }
    return isConnected;
  }

  static Future<bool> checkInternet(BuildContext buildContext) async {
    bool isConnected = await isInternetConnected();
    if (isConnected) {
      return true;
    } else {
      CommonDialog().showDeleteUserDialog(
        isShowCancelButton: false,
        // ignore: use_build_context_synchronously
        context: buildContext,
        onConfirm: () {},
        title: "Connection Error",
        message: AppConstents.networkErroMessage,
        confirmText: "Ok",
      );
      return false;
    }
  }
}
