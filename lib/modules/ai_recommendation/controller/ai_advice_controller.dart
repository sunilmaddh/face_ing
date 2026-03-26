import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/modules/ai_recommendation/models/ai_reccamandation_response.dart';
import 'package:ntt_data/modules/ai_recommendation/repositories/ai_advice_repository.dart';

class AiAdviceController extends BaseController {
  AiAdviceController({required this.adviceRepository});

  final AiAdviceRepository adviceRepository;

  final aiResponse = Rxn<AiRecamendationResponse>();
  Future<void> fetchAiRecommendation() async {
    try {
      showLoading(true);

      final response = await adviceRepository.getAiAdvice();

      if (response.statusCode != 200 || response.data == null) {
        setError(response.message ?? "Something went wrong");
        return;
      }

      aiResponse.value = response.data!;
    } catch (e, stack) {
      debugPrint("Exception: $e");
      debugPrintStack(stackTrace: stack);
      setError(e.toString());
    } finally {
      showLoading(false);
    }
  }
}
