import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/data/models/ai_reccamandation_response.dart';
import 'package:ntt_data/data/repository/services/ai_services.dart';

class AiController extends GetxController {
  final _aiServices = Get.put(AiServices());
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
      Map<String, dynamic> responseData = await _aiServices.aiRecamendation();
      int statusCode = responseData["statusCode"];
      if (statusCode == 200) {
        final data = AiRecamendationResponse.fromJson(
          responseData[AppConstents.response],
        );
        airesponse.value = data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAlLoading(false);
    }
  }
}
