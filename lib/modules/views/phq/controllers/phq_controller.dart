import 'package:get/get.dart';
import '../models/phq_model.dart';

class PhqController extends GetxController {
  final currentQuestionIndex = 0.obs;
  final selectedAnswers = <int, int>{}.obs;

  final PhqAssessment assessment = PhqAssessment(
    type: 'phq-2',
    questions: [
      PhqQuestion(
        question: 'Over the last 2 weeks, how often have you been bothered by little interest or pleasure in doing things?',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Over the last 2 weeks, how often have you been bothered by feeling down, depressed, or hopeless?',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
    ],
  );

  void selectAnswer(int questionIndex, int value) {
    selectedAnswers[questionIndex] = value;
  }

  int? getSelectedAnswer(int questionIndex) {
    return selectedAnswers[questionIndex];
  }

  bool get allQuestionsAnswered =>
      selectedAnswers.length == assessment.questions.length;

  void nextQuestion() {
    if (currentQuestionIndex.value < assessment.questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  int getTotalScore() {
    return selectedAnswers.values.fold(0, (sum, value) => sum + value);
  }
}
