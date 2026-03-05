import 'package:get/get.dart';
import '../models/phq_model.dart';

class Gad7Controller extends GetxController {
  final selectedAnswers = <int, int>{}.obs;

  final PhqAssessment assessment = PhqAssessment(
    type: 'gad-7',
    questions: [
      PhqQuestion(
        question: 'Feeling nervous, anxious, or on edge',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Not being able to stop or control worrying',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Worrying too much about different things',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Trouble relaxing',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: "Being so restless that it's hard to sit still",
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Becoming easily annoyed or irritable',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question: 'Feeling afraid as if something awful might happen',
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

  int getTotalScore() {
    return selectedAnswers.values.fold(0, (sum, value) => sum + value);
  }
}
