import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/modules/home/models/latest_wellness_model.dart';
import 'package:ntt_data/modules/home/repositories/home_repository.dart';

class HomeController extends BaseController {
  HomeController({required this.homeRepository});

  final HomeRepository homeRepository;

  final wellnessModel = Rxn<LatestWellnessModel>();
  final wellnessScore = 0.0.obs;

  Future<void> getWellnessScore() async {
    try {
      showLoading(true);

      final response = await homeRepository.getLetestscore();

      if (response.statusCode != 200 || response.data == null) {
        setError(response.message);
        return;
      }

      final result = response.data!;
      wellnessModel.value = result;
      wellnessScore.value = double.tryParse(result.wellnessIndex ?? '') ?? 0.0;
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }
}
