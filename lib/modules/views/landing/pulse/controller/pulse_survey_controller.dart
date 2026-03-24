import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/data/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/modules/views/landing/pulse/repositories/pulse_survey_repository.dart';

class PulseSurveyController extends GetxController {
  PulseSurveyController({required this.pulseSurveyRepository});
  final PulseSurveyRepository pulseSurveyRepository;
  Rx<PulseSurveyQuestionListModel> pulseSurveyList =
      PulseSurveyQuestionListModel().obs;
  RxList<Question> pulseQuestionList = <Question>[].obs;
  RxList<PulseSurveyADay> pulseSurveyADayList = <PulseSurveyADay>[].obs;

  Rx<PulseSurveyModel> pulseSevryModel = PulseSurveyModel().obs;
  RxBool isPulseSurveryLoading = false.obs;
  RxBool isPulseQuestionListLoading = false.obs;
  RxBool isEnable = false.obs;

  bool isNavigating = false;

  // List<Map<String, dynamic>> pulseList = [];

  Future<void> getPulseQuetionList() async {
    isPulseQuestionListLoading(true);
    try {
      var response = await pulseSurveyRepository.getPulseSurveyQuestionList();
      if (response.statusCode == 200) {
        final result = response.data!;
        pulseSurveyList.value = result;
        pulseQuestionList.value = pulseSurveyList.value.questions!;
        isPulseQuestionListLoading(false);
      } else {
        AppSnackbar.show(
          title: "Error",
          message: response.message,
          isError: true,
        );
        isPulseQuestionListLoading(false);
      }
    } catch (e) {
      isPulseQuestionListLoading(false);
      debugPrint(e.toString());
    } finally {
      isPulseQuestionListLoading(false);
    }
  }

  List<Map<String, dynamic>> pulseList = [];
  Future<void> storePulseQuetionList() async {
    try {
      var data = pulseList;
      var responseData = await pulseSurveyRepository.storePulseSurvey(
        data: data,
      );

      if (responseData.statusCode == 200) {
        // final result = responseData.data;
        isEnable.value = false;
        await fetchPulseSurvey();
        pulseList.clear();
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData.message,
          isError: true,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchPulseSurvey() async {
    isPulseSurveryLoading(true);
    try {
      var data = pulseList;
      var responseData = await pulseSurveyRepository.getPulseSurveyResult();

      if (responseData.statusCode == 200) {
        final result = responseData.data;
        if (!isNavigating) {
          pulseSevryModel.value = result!;
          pulseSurveyADayList.value =
              pulseSevryModel.value.pulseSurveyADayList!;
          isPulseSurveryLoading(false);
        }
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData.message,
          isError: true,
        );
        isPulseSurveryLoading(false);
      }
    } catch (e) {
      isPulseSurveryLoading(false);
      debugPrint(e.toString());
    } finally {
      isPulseSurveryLoading(false);
    }
  }

  void storeQuestionAnswer(String id, String question, String selectedAnswers) {
    if (selectedAnswers.isEmpty) return;

    // Check if this question already exists in the list
    final existingIndex = pulseList.indexWhere(
      (element) => element["questionId"] == id,
    );

    if (existingIndex != -1) {
      // Update the existing answer
      pulseList[existingIndex]["answer"] = selectedAnswers;
    } else {
      // Add new answer if not already present
      pulseList.add({
        "questionId": id,
        "pulseSurveyQuestion": question,
        "answer": selectedAnswers,
      });
    }
    debugPrint("pulseList : $pulseList");
  }

  PageController? pageController;

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

    if (index == -1) return -1; // Not answered yet

    final selected = pulseList[index]["answer"];
    return options.indexOf(selected);
  }
}
