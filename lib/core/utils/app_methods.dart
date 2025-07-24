import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';

class AppMethods {
  static var dataList = <Map<String, dynamic>>[].obs;
  static var answerList = <Map<String, dynamic>>[].obs;
  static RxList<Map<String, dynamic>> healthMenuData =
      <Map<String, dynamic>>[].obs;

  static void storeQuestionAnswer(
    String id,
    String question,
    List<dynamic> selectedAnswers,
  ) {
    if (selectedAnswers.isNotEmpty) {
      // Check if the question already exists
      int index = dataList.indexWhere(
        (element) => element["question"] == question,
      );

      if (index != -1) {
        // Update existing entry
        dataList[index]["answer"] = selectedAnswers;
        dataList[index]["id"] = id; // Optionally update id too
        print("Updated existing entry: ${dataList[index]}");
      } else {
        // Add new entry
        dataList.add({
          "id": id,
          "question": question,
          "answer": selectedAnswers,
        });
        print("Added new entry: ${dataList.last}");
      }
    }

    print("Updated existing entry: ${dataList.toString()}");
    healthMenuData.value = dataList.value;
  }

  static List<Map<String, dynamic>> getstoreQuestionAnswer() {
    List<Map<String, dynamic>> data = dataList;
    dataList.clear();
    return dataList;
  }

  late AnimationController animationController;
  AnimationController storeController() {
    return animationController;
  }

  AnimationController sendController(AnimationController controller) {
    animationController = controller;
    return animationController;
  }

  Future<double> calculateAge(String birthDate) async {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(birthDate);
    debugPrint("Age 4 ${parsedDate.toString()}, ${parsedDate.year}");
    DateTime today = DateTime.now();
    int age = today.year - parsedDate.year;
    if (today.month < parsedDate.month ||
        (today.month == parsedDate.month && today.day < parsedDate.day)) {
      age--;
    }
    debugPrint("Age ${age.toString()}");
    return age.toDouble();
  }

  void logout() async {
    await IndoSharedPreference.instance.saveUserId("");
    await IndoSharedPreference.instance.saveOnBoard("false");
    AppNavigation.offAll(AppRoutes.loginScreen);
  }

  static String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }
}
