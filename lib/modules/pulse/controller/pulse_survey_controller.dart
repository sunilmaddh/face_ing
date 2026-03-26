import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_model.dart';
import 'package:ntt_data/modules/pulse/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/modules/pulse/repositories/pulse_survey_repository.dart';

class PulseSurveyController extends BaseController {
  PulseSurveyController({required this.pulseSurveyRepository});

  final PulseSurveyRepository pulseSurveyRepository;

  final Rx<PulseSurveyQuestionListModel> pulseSurveyList =
      PulseSurveyQuestionListModel().obs;
  final RxList<Question> pulseQuestionList = <Question>[].obs;
  final RxList<PulseSurveyADay> pulseSurveyADayList = <PulseSurveyADay>[].obs;
  final Rx<PulseSurveyModel> pulseSevryModel = PulseSurveyModel().obs;

  final RxBool isPulseSurveryLoading = false.obs;
  final RxBool isPulseQuestionListLoading = false.obs;
  final RxBool isEnable = false.obs;

  bool isNavigating = false;

  final List<Map<String, dynamic>> pulseList = [];

  PageController? pageController;

  Future<void> getPulseQuetionList() async {
    isPulseQuestionListLoading(true);

    try {
      final response = await pulseSurveyRepository.getPulseSurveyQuestionList();
      if (response.statusCode == 200) {
        final result = response.data;
        pulseSurveyList.value = result ?? PulseSurveyQuestionListModel();
        pulseQuestionList.value = pulseSurveyList.value.questions ?? [];
      } else {
        setError(response.message ?? "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      setError("Something went wrong");
    } finally {
      isPulseQuestionListLoading(false);
    }
  }

  Future<void> storePulseQuetionList() async {
    showLoading(true);

    try {
      final responseData = await pulseSurveyRepository.storePulseSurvey(
        data: pulseList,
      );

      if (responseData.statusCode == 200) {
        isEnable.value = false;
        await fetchPulseSurvey();
        pulseList.clear();
      } else {
        setError(responseData.message ?? "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      setError("Something went wrong");
    } finally {
      showLoading(false);
    }
  }

  Future<void> fetchPulseSurvey() async {
    isPulseSurveryLoading(true);

    try {
      final responseData = await pulseSurveyRepository.getPulseSurveyResult();

      if (responseData.statusCode == 200) {
        final result = responseData.data;

        if (!isNavigating && result != null) {
          pulseSevryModel.value = result;
          pulseSurveyADayList.value = result.pulseSurveyADayList ?? [];
        }
      } else {
        setError(responseData.message ?? "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      setError("Something went wrong");
    } finally {
      isPulseSurveryLoading(false);
    }
  }

  void storeQuestionAnswer(String id, String question, String selectedAnswers) {
    if (selectedAnswers.isEmpty) return;

    final existingIndex = pulseList.indexWhere(
      (element) => element["questionId"] == id,
    );

    if (existingIndex != -1) {
      pulseList[existingIndex]["answer"] = selectedAnswers;
    } else {
      pulseList.add({
        "questionId": id,
        "pulseSurveyQuestion": question,
        "answer": selectedAnswers,
      });
    }

    debugPrint("pulseList : $pulseList");
  }

  void setPageController(PageController controller) {
    pageController = controller;
  }

  void moveToNextPage() {
    if (pageController == null) return;

    final currentPage = pageController!.page?.round() ?? 0;

    if (currentPage < pulseQuestionList.length - 1) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.ease,
      );
      isEnable.value = false;
    }
  }

  int getSelectedIndex(String questionId, List<dynamic> options) {
    final index = pulseList.indexWhere(
      (element) => element["questionId"] == questionId,
    );

    if (index == -1) return -1;

    final selected = pulseList[index]["answer"];
    return options.indexOf(selected);
  }

  @override
  void onClose() {
    pageController?.dispose();
    super.onClose();
  }
}
