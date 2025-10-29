import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/latest_wellness_model.dart';
import 'package:ntt_data/data/repository/services/home_services.dart';

class HomeController extends GetxController {
  final _homeServices = HomeServices();
  Rx<LatestWellnessModel> wellnessModel = LatestWellnessModel().obs;

  RxDouble wellnessScore = 0.0.obs;

  Future<void> getWellnessScore() async {
    try {
      final responseData = await _homeServices.getLatestWellnessScore();

      final int? statusCode = responseData['statusCode'] as int?;
      if (statusCode == null) {
        throw Exception("Missing statusCode in response");
      }

      if (statusCode == 200) {
        final result = responseData[AppConstents.response];
        debugPrint("Wellness Score Result: $result");

        wellnessModel.value = LatestWellnessModel.fromJson(result);
        wellnessScore.value =
            double.tryParse(wellnessModel.value.wellnessIndex ?? '') ?? 0.0;
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData['message'] ?? "Something went wrong",
          isError: true,
        );
      }
    } catch (e, stack) {
      debugPrint("getWellnessScore error: $e");
      debugPrint(stack.toString());
      AppSnackbar.show(title: "Error", message: e.toString(), isError: true);
    }
  }
}
