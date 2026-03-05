import 'package:get/get.dart';
import '../../../../data/repository/services/phq_services.dart';

class AssessmentController extends GetxController {
  static AssessmentController get instance => Get.find();

  final phq2Answers = <int>[].obs;
  final phq9Answers = <int>[].obs;
  final gad7Answers = <int>[].obs;

  final _phqServices = PhqServices();
  final isLoading = false.obs;
  final sessionId = ''.obs;

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

  Future<bool> submitAssessment() async {
    try {
      isLoading.value = true;
      final response = await _phqServices.submitAssessment(
        phq2: phq2Answers,
        phq9: phq9Answers,
        gad7: gad7Answers,
        sessionId: "f82ba129-bb2d-48c6-8bdd-f2026bbc4421",
      );
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        sessionId.value = response['responseBody']['sessionId'] ?? '';
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> getResult() async {
    if (sessionId.isEmpty) return null;
    try {
      final response = await _phqServices.getResult(sessionId.value);
      if (response['statusCode'] == 200) {
        return response['responseBody'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void reset() {
    phq2Answers.clear();
    phq9Answers.clear();
    gad7Answers.clear();
  }
}
