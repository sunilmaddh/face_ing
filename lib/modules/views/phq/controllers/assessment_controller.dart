import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/data/models/kintsugi_result_response.dart';
import '../../../../data/repository/services/phq_services.dart';

class AssessmentController extends GetxController {
  static AssessmentController get instance => Get.find();

  Rx<KintsigiRusltResponse> resultResponse = KintsigiRusltResponse().obs;

  final phq2Answers = <int>[].obs;
  final phq9Answers = <int>[].obs;
  final gad7Answers = <int>[].obs;
  RxBool isFromHomeScreen = false.obs;
  RxString createDate = "".obs;
  final _phqServices = PhqServices();
  final isLoading = false.obs;
  final sessionId = ''.obs;
  RxBool isGettingResult = false.obs;
  Rx<Depression> depressionResponse = Depression().obs;
  Rx<Anxiety> anxietyResponse = Anxiety().obs;
  void setPhq2Answers(Map<int, int> answers) {
    phq2Answers.value = List.generate(
      answers.length,
      (index) => answers[index] ?? 0,
    );
  }

  void setPhq9Answers(Map<int, int> answers) {
    phq9Answers.value = List.generate(
      answers.length,
      (index) => answers[index] ?? 0,
    );
  }

  void setGad7Answers(Map<int, int> answers) {
    gad7Answers.value = List.generate(
      answers.length,
      (index) => answers[index] ?? 0,
    );
  }

  Future<bool> submitAssessment({required String sessionID}) async {
    try {
      isLoading.value = true;
      final response = await _phqServices.submitAssessment(
        phq2: phq2Answers,
        phq9: phq9Answers,
        gad7: gad7Answers,
        sessionId: sessionID,
      );
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        // Get.to(() => PhqResultScreen());

        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getResult() async {
    try {
      isGettingResult(true);
      final response = await _phqServices.getResult(sessionId.value);
      if (response['statusCode'] == 200) {
        var result = KintsigiRusltResponse.fromJson(
          response[AppConstents.response],
        );
        debugPrint(result.toString());
        depressionResponse.value = result.result!.depression!;
        anxietyResponse.value = result.result!.anxiety!;
        createDate.value = result.result!.createdAt!;
        isGettingResult(false);
        return response['responseBody'];
      } else {
        isGettingResult(false);
      }
    } catch (e) {
      isGettingResult(false);
    }
  }

  Future<void> getSession() async {
    try {
      isGettingResult(true);
      final response = await _phqServices.getSession();
      if (response['statusCode'] == 200) {
        var result = KintsigiRusltResponse.fromJson(
          response[AppConstents.response],
        );
        debugPrint(result.toString());
        depressionResponse.value = result.result!.depression!;
        anxietyResponse.value = result.result!.anxiety!;
        createDate.value = result.result!.createdAt!;
        debugPrint(
          "Depression ${depressionResponse.value.aiPrediction.toString()}",
        );
        isGettingResult(false);
        return response['responseBody'];
      } else {
        isGettingResult(false);
      }
    } catch (e) {
      isGettingResult(false);
    }
  }

  void reset() {
    phq2Answers.clear();
    phq9Answers.clear();
    gad7Answers.clear();
  }
}
