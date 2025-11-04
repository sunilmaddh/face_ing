import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/pulse_survey_model.dart';
import 'package:ntt_data/data/models/pulse_survey_question_list_model.dart';
import 'package:ntt_data/data/repository/services/pulse_services.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class PulseSurveyController extends GetxController {
  final _pulseSevices = PulseServices();
  Rx<PulseSurveyQuestionListModel> pulseSurveyList =
      PulseSurveyQuestionListModel().obs;
  RxList<Question> pulseQuestionList = <Question>[].obs;
  RxList<PulseSurveyADay> pulseSurveyADayList = <PulseSurveyADay>[].obs;

  Rx<PulseSurveyModel> pulseSevryModel = PulseSurveyModel().obs;
  RxBool isPulseSurveryLoading = false.obs;
  RxBool isPulseQuestionListLoading = false.obs;
  RxBool isEnable = false.obs;

  // List<Map<String, dynamic>> pulseList = [];

  Future<void> getPulseQuetionList() async {
    isPulseQuestionListLoading(true);
    try {
      Map<String, dynamic> responseData =
          await _pulseSevices.getPulseQuestionListServices();

      final int? statusCode = responseData['statusCode'] as int?;
      if (statusCode == null) {
        isPulseQuestionListLoading(false);
        throw Exception("Missing statusCode in response");
      }
      if (statusCode == 200) {
        final result = responseData[AppConstents.response];
        pulseSurveyList.value = PulseSurveyQuestionListModel.fromJson(result);
        pulseQuestionList.value = pulseSurveyList.value.questions!;
        debugPrint("Wellness Score Result: $result");
        isPulseQuestionListLoading(false);
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData['message'] ?? "Something went wrong",
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
      Map<String, dynamic> responseData = await _pulseSevices
          .savePulseServeyServices(data: data);

      final int? statusCode = responseData['statusCode'] as int?;
      if (statusCode == null) {
        throw Exception("Missing statusCode in response");
      }
      if (statusCode == 200) {
        AppSnackbar.show(title: "Success", message: "Save Successfull");
        final result = responseData[AppConstents.response];
        // AppNavigation.off(AppRoutes.landingSceen);
        AppNavigation.off(AppRoutes.landingSceen);
        await fetchPulseSurvey();
        debugPrint("Wellness Score Result: $result");
        pulseList.clear();
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData['message'] ?? "Something went wrong",
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
      Map<String, dynamic> responseData = await _pulseSevices
          .fetchPulseServeyServices(data: data);

      final int? statusCode = responseData['statusCode'] as int?;
      if (statusCode == null) {
        throw Exception("Missing statusCode in response");
      }
      if (statusCode == 200) {
        final result = responseData[AppConstents.response];
        pulseSevryModel.value = PulseSurveyModel.fromJson(result);
        pulseSurveyADayList.value = pulseSevryModel.value.pulseSurveyADayList!;
        debugPrint("Wellness Score Result: $result");
        isPulseSurveryLoading(false);
      } else {
        AppSnackbar.show(
          title: "Error",
          message: responseData['message'] ?? "Something went wrong",
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
}
