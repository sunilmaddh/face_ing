import 'package:get/get.dart';
import '../models/phq_model.dart';

class Phq9Controller extends GetxController {
  final currentQuestionIndex = 0.obs;
  final selectedAnswers = <int, int>{}.obs;

  final PhqAssessment assessment = PhqAssessment(
    type: 'phq-9',
    questions: [
      PhqQuestion(
        question: 'Little interest or pleasure in doing things',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Feeling down, depressed, or hopeless',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Trouble falling/staying asleep, or sleeping too much',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Feeling tired or having little energy',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Poor appetite or overeating',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Feeling bad about yourself or that you\'re a failure',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Trouble concentrating on things',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Moving/speaking slowly or being fidgety/restless',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Thoughts that you would be better off dead or hurting yourself',
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
