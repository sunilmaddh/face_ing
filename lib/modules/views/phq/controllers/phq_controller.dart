import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/kintsungi_questionaries_response.dart';
import 'package:ntt_data/data/repository/services/voice_service.dart';
import '../models/phq_model.dart';

class PhqController extends GetxController {
  final currentQuestionIndex = 0.obs;
  final selectedPhTwoAnswers = <int, int>{}.obs;
  final selectedPh9Answers = <int, int>{}.obs;
  final selectedG7Answers = <int, int>{}.obs;
  RxBool isLoading = false.obs;
  RxList<QuestionOfKintsugi> phqTwoQuestion = <QuestionOfKintsugi>[].obs;
  RxList<QuestionOfKintsugi> gad7Question = <QuestionOfKintsugi>[].obs;
  RxList<QuestionOfKintsugi> phq9Question = <QuestionOfKintsugi>[].obs;
  @override
  void onInit() {
    kintsugiQuestionApi();
    super.onInit();
  }

  Future<void> kintsugiQuestionApi() async {
    isLoading(true);
    Map<String, dynamic> responseData =
        await VoiceService().questionaryKintsugiApi();
    int statusCode = responseData["statusCode"];
    if (statusCode == 200) {
      var result = KintsigiQuestionariesResponse.fromJson(
        responseData[AppConstents.response],
      );
      phqTwoQuestion.value = result.questionnaires![0].questions!;
      gad7Question.value = result.questionnaires![2].questions!;
      phq9Question.value = result.questionnaires![1].questions!;
      isLoading(false);
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
      isLoading(false);
    }
  }

  final PhqAssessment assessment = PhqAssessment(
    type: 'phq-2',
    questions: [
      PhqQuestion(
        question:
            'Over the last 2 weeks, how often have you been bothered by little interest or pleasure in doing things?',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
      PhqQuestion(
        question:
            'Over the last 2 weeks, how often have you been bothered by feeling down, depressed, or hopeless?',
        options: [
          PhqOption(value: 0, response: 'Not at all'),
          PhqOption(value: 1, response: 'Several days'),
          PhqOption(value: 2, response: 'More than half the days'),
          PhqOption(value: 3, response: 'Nearly every day'),
        ],
      ),
    ],
  );

  void selectPhTwoAnswer(int questionIndex, int value) {
    selectedPhTwoAnswers[questionIndex] = value;
  }

  int? getPhTwoSelectedAnswer(int questionIndex) {
    return selectedPhTwoAnswers[questionIndex];
  }

  void selectPh9Answer(int questionIndex, int value) {
    selectedPh9Answers[questionIndex] = value;
  }

  int? getPh9SelectedAnswer(int questionIndex) {
    return selectedPh9Answers[questionIndex];
  }

  void selectPh7Answer(int questionIndex, int value) {
    selectedG7Answers[questionIndex] = value;
  }

  int? getPh7SelectedAnswer(int questionIndex) {
    return selectedG7Answers[questionIndex];
  }

  bool get allPhTwoQuestionsAnswered =>
      selectedPhTwoAnswers.length == phqTwoQuestion.length;
  bool get allPh9QuestionsAnswered =>
      selectedPh9Answers.length == phq9Question.length;
  bool get allG7QuestionsAnswered =>
      selectedG7Answers.length == gad7Question.length;

  void nextQuestion() {
    if (currentQuestionIndex.value < phqTwoQuestion.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  // int getTotalScore() {
  //   return selectedAnswers.values.fold(0, (sum, value) => sum + value);
  // }
}
