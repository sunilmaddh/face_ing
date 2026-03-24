import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/data/models/ai_reccamandation_response.dart';
import 'package:ntt_data/modules/views/ai_recommendation/repositories/ai_advice_repository.dart';

class AiAdviceController extends GetxController {
  AiAdviceController({required this.adviceRepository});
  final AiAdviceRepository adviceRepository;
  RxBool isAlLoading = false.obs;
  Rx<AiRecamendationResponse> airesponse = AiRecamendationResponse().obs;

  @override
  void onInit() {
    super.onInit();
    aIRecamendation();
  }

  Future<void> aIRecamendation() async {
    try {
      isAlLoading(true);
      var responseData = await adviceRepository.getAiAdvice();
      int statusCode = responseData.statusCode;
      if (statusCode == 200) {
        final data = responseData.data!;
        airesponse.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAlLoading(false);
    }
  }
}
