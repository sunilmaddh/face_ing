import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/modules/phq/repositories/phq_repository.dart';
import 'package:ntt_data/modules/voice_agent/model/kintsungi_questionaries_response.dart';

class PhqController extends BaseController {
  PhqController({required this.phqRepository});
  final PhqRepository phqRepository;
  final RxInt currentQuestionIndex = 0.obs;
  final RxMap<int, int> selectedPhTwoAnswers = <int, int>{}.obs;
  final RxMap<int, int> selectedPh9Answers = <int, int>{}.obs;
  final RxMap<int, int> selectedG7Answers = <int, int>{}.obs;
  final RxList<QuestionOfKintsugi> phqTwoQuestion = <QuestionOfKintsugi>[].obs;
  final RxList<QuestionOfKintsugi> gad7Question = <QuestionOfKintsugi>[].obs;
  final RxList<QuestionOfKintsugi> phq9Question = <QuestionOfKintsugi>[].obs;
  @override
  void onInit() {
    super.onInit();
    kintsugiQuestionApi();
  }

  Future<void> kintsugiQuestionApi() async {
    showLoading(true);

    try {
      final responseData = await phqRepository.questionaryKintsugi();

      if (responseData.statusCode == 200 && responseData.data != null) {
        final result = responseData.data!;
        final questionnaires = result.questionnaires ?? [];

        phqTwoQuestion.value =
            questionnaires.length > 0
                ? (questionnaires[0].questions ?? [])
                : [];

        phq9Question.value =
            questionnaires.length > 1
                ? (questionnaires[1].questions ?? [])
                : [];

        gad7Question.value =
            questionnaires.length > 2
                ? (questionnaires[2].questions ?? [])
                : [];
      } else {
        setError(ValidationStrings.commonErrorMessage);
      }
    } catch (e) {
      setError(ValidationStrings.commonErrorMessage);
    } finally {
      showLoading(false);
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

  void resetSelections() {
    currentQuestionIndex.value = 0;
    selectedPhTwoAnswers.clear();
    selectedPh9Answers.clear();
    selectedG7Answers.clear();
  }
}
