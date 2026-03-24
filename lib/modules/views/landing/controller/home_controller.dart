import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/latest_wellness_model.dart';
import 'package:ntt_data/modules/views/landing/repositories/home_repository.dart';

class HomeController extends GetxController {
  HomeController({required this.homeRepository});
  final HomeRepository homeRepository;
  Rx<LatestWellnessModel> wellnessModel = LatestWellnessModel().obs;
  RxDouble wellnessScore = 0.0.obs;
  Future<void> getWellnessScore() async {
    try {
      final response = await homeRepository.getLetestscore();
      if (response.statusCode == 200) {
        final result = response.data;
        wellnessModel.value = result!;
        wellnessScore.value =
            double.tryParse(wellnessModel.value.wellnessIndex ?? '') ?? 0.0;
      } else {
        AppSnackbar.show(
          title: "Error",
          message: response.message,
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
