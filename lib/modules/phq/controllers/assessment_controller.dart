import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsugi_result_response.dart';
import 'package:ntt_data/modules/phq/repositories/phq_repository.dart';

class AssessmentController extends GetxController {
  AssessmentController({required this.phqRepository});
  static AssessmentController get instance => Get.find();

  final PhqRepository phqRepository;

  Rx<KintsigiRusltResponse> resultResponse = KintsigiRusltResponse().obs;

  final phq2Answers = <int>[].obs;
  final phq9Answers = <int>[].obs;
  final gad7Answers = <int>[].obs;
  RxBool isFromHomeScreen = false.obs;
  RxString createDate = "".obs;
  // final _phqServices = PhqServices();
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
      final response = await phqRepository.submitAssessment(
        phq2: phq2Answers,
        phq9: phq9Answers,
        gad7: gad7Answers,
        sessionId: sessionID,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      final response = await phqRepository.getResult(sessionId.value);
      if (response.statusCode == 200) {
        var result = response.data;
        debugPrint(result.toString());
        depressionResponse.value = result!.result!.depression!;
        anxietyResponse.value = result.result!.anxiety!;
        createDate.value = result.result!.createdAt!;
        isGettingResult(false);
        return;
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
      final response = await phqRepository.getSession();
      if (response.statusCode == 200) {
        var result = response.data;
        debugPrint(result.toString());
        depressionResponse.value = result!.result!.depression!;
        anxietyResponse.value = result.result!.anxiety!;
        createDate.value = result.result!.createdAt!;

        isGettingResult(false);
        return;
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
