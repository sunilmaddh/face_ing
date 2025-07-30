import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';

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

  static String? validateDOB(String? dob) {
    if (dob == null || dob.trim().isEmpty) {
      return "Please select DOB";
    }

    try {
      // Parse with strict format
      final parseDate = DateFormat("dd/MM/yyyy").parseStrict(dob.trim());

      final now = DateTime.now();
      final minAllowedDate = DateTime(now.year - 18, now.month, now.day);

      if (parseDate.isAfter(minAllowedDate)) {
        return "Age should be 18+";
      }
    } catch (e) {
      return "Invalid date format. Use dd/MM/yyyy";
    }

    return null;
  }

  static String? validateHeight(String? height) {
    if (height == null || height.isEmpty) {
      return "Please enter height";
    } else {
      final parsedHeight = double.tryParse(height);
      if (parsedHeight == null) {
        return "Please enter a valid number";
      } else if (parsedHeight < 130.0) {
        return "Height must be 130 or greater";
      }
    }
    return null;
  }

  static String? validateWeight(String? weight) {
    if (weight == null || weight.isEmpty) {
      return "Please enter weight";
    } else {
      final parsedWeight = double.tryParse(weight);
      if (parsedWeight == null) {
        return "Please enter a valid number";
      } else if (parsedWeight < 40.0) {
        return "Weight must be 40 or greater";
      }
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return "Please enter name";
    } else if (!GuestHalper.isValidInput(name)) {
      return "Please enter valid name";
    }
    return null;
  }

  List<Map<String, String>> guestOptionList = [
    {"name": "Update Profile Photo", "isOptionType": "Photo"},
    {"name": "Update Profile Details", "isOptionType": "Details"},
  ];

  Future<void> editProfilePicture(
    CommonMixin commonController,
    guestId,
    isGuest,
    final VoidCallback whenComplete,
  ) async {
    ImagePickerBottomsheet.showImagePickerBottomSheet(
      onGalleryTap: () async {
        await commonController
            .uploadProfileFromGallery("false", guestId, isGuest)
            .whenComplete(() {
              whenComplete();
            });
      },
      onCameraTap: () async {
        await commonController
            .uploadProfileFromCamera("false", guestId, isGuest)
            .whenComplete(() {
              whenComplete();
            });
      },
    );
  }
}
