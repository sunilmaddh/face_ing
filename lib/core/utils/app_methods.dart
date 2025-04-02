import 'package:get/get.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AppMethods {
  static var dataList = <Map<String, dynamic>>[].obs;
  static var answerList = <Map<String, dynamic>>[].obs;

  ///  Common method to store question & answer
  static List<Map<String, dynamic>> storeQuestionAnswer(
    String id,
    String question,
    List<dynamic> selectedAnswers, // List of selected answers
  ) {
    if (selectedAnswers.isNotEmpty) {
      // Find if the question already exists in the dataList
      var existingEntry = dataList.firstWhere(
        (element) => element["question"] == question,
        orElse: () => {},
      );

      if (existingEntry != null) {
        // If entry exists, update the answers for that question
        existingEntry["answer"] = selectedAnswers;
      } else {
        // If entry does not exist, add a new entry with the selected answers
        dataList.add({
          "id": id,
          "question": question,
          "answer": selectedAnswers,
        });
      }
    } else {
      // If answers are empty, remove the question from the dataList
      dataList.removeWhere((element) => element["question"] == question);
    }

    print("Updated Data List: $dataList");
    return dataList;
  }

  static List<Map<String, dynamic>> getstoreQuestionAnswer() {
    return dataList;
  }

  void logout() async {
    StorageHelper.remove("userId");
    StorageHelper.remove("isOnboard");
    StorageHelper.remove("authToken"); // If you store an auth token
    StorageHelper.remove("userProfile"); // Any other stored user data
    AppNavigation.offAll(AppRoutes.loginScreen);
  }
}
