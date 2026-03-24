import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/kintsungi_questionaries_response.dart';
import 'package:ntt_data/modules/views/phq/repositories/phq_repository.dart';

class PhqController extends GetxController {
  PhqController({required this.phqRepository});
  final PhqRepository phqRepository;
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
    var responseData = await phqRepository.questionaryKintsugi();

    if (responseData.statusCode == 200) {
      var result = responseData.data!;
      phqTwoQuestion.value = result.questionnaires![0].questions!;
      gad7Question.value = result.questionnaires![2].questions!;
      phq9Question.value = result.questionnaires![1].questions!;
      isLoading(false);
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
      isLoading(false);
    }
  }

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
}
