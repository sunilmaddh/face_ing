import 'package:get/get.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class AppMethods {
  static var dataList = <Map<String, dynamic>>[].obs;

  ///  Common method to store question & answer
  static List<Map<String, dynamic>> storeQuestionAnswer(
    String question,
    String id,
    dynamic answer,
  ) {
    if (answer != null) {
      dataList.removeWhere((element) => element["question"] == question);

      dataList.add({"id": id, "question": question, "answer": answer});
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
