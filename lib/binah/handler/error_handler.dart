import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorHandler {
  final RxnString error = RxnString();
  final RxnString warning = RxnString();

  void onError(String code) {
    error.value = "Error: $code";
    debugPrint("❌ Error: $code");
  }

  void onWarning(String code) {
    warning.value = "Warning: $code";
    debugPrint("⚠️ Warning: $code");
    Future.delayed(const Duration(seconds: 1), () => warning.value = null);
  }

  void clear() {
    error.value = null;
    warning.value = null;
  }
}
