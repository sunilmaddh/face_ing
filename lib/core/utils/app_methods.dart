import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';

class AppMethods {
  static var dataList = <Map<String, dynamic>>[].obs;
  static var answerList = <Map<String, dynamic>>[].obs;
  static RxList<Map<String, dynamic>> healthMenuData =
      <Map<String, dynamic>>[].obs;

  final Battery _battery = Battery();

  static void storeQuestionAnswer(
    String id,
    String question,
    List<dynamic> selectedAnswers,
  ) {
    if (selectedAnswers.isNotEmpty) {
      int index = dataList.indexWhere(
        (element) => element["question"] == question,
      );
      if (index != -1) {
        dataList[index]["answer"] = selectedAnswers;
        dataList[index]["id"] = id;
      } else {
        dataList.add({
          "id": id,
          "question": question,
          "answer": selectedAnswers,
        });
      }
    }

    healthMenuData.value = dataList;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
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
    debugPrint("Age input: $birthDate");

    // Supported date formats
    final formats = [
      DateFormat('dd/MM/yyyy'),
      DateFormat('MM/dd/yyyy'),
      DateFormat('yyyy/MM/dd'),
      DateFormat('yyyy-MM-dd'),
      DateFormat('dd-MM-yyyy'),
      DateFormat('MM-dd-yyyy'),
    ];

    DateTime? parsedDate;

    for (var format in formats) {
      try {
        parsedDate = format.parseStrict(birthDate);

        if (parsedDate.year < 1000) {
          parsedDate = null;
          continue;
        }

        break;
      } catch (_) {
        continue;
      }
    }

    if (parsedDate == null) {
      throw FormatException("Invalid date format or 2-digit year: $birthDate");
    }

    debugPrint("Parsed Date: $parsedDate");

    DateTime today = DateTime.now();
    int age = today.year - parsedDate.year;

    if (today.month < parsedDate.month ||
        (today.month == parsedDate.month && today.day < parsedDate.day)) {
      age--;
    }

    debugPrint("Calculated Age: $age");
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
      final parseDate = DateFormat("dd/MM/yyyy").parseStrict(dob.trim());
      parseDate.year;
      final now = DateTime.now();
      final minAllowedDate = DateTime(now.year - 18, now.month, now.day);
      if (parseDate.isAfter(minAllowedDate)) {
        return "Age should be 18+";
      } else if (!validateDate(dob)) {
        return "Invalid date format. Use dd/MM/yyyy";
      } else if (parseDate.year < 1925) {
        return "Year must be 1925 or greater";
      }
    } catch (e) {
      return "Invalid date format. Use dd/MM/yyyy";
    }
    return null;
  }

  Future<String> convertDateFormatToYY(String date) async {
    final formats = [DateFormat("dd/MM/yyyy"), DateFormat("yyyy/MM/dd")];

    DateTime? parsedDate;
    for (var format in formats) {
      try {
        parsedDate = format.parseStrict(date);
        break;
      } catch (_) {
        continue;
      }
    }

    if (parsedDate == null) {
      throw FormatException("Invalid date format: $date");
    }

    return DateFormat("yyyy/MM/dd").format(parsedDate);
  }

  Future<String> convertDateFormateToDD(String date) async {
    final formats = [DateFormat("dd/MM/yyyy"), DateFormat("yyyy/MM/dd")];
    DateTime? parsedDate;
    for (var format in formats) {
      try {
        parsedDate = format.parseStrict(date);
        break;
      } catch (_) {
        continue;
      }
    }

    if (parsedDate == null) {
      throw FormatException("Invalid date format: $date");
    }

    String newDate = DateFormat("dd/MM/yyyy").format(parsedDate);
    return newDate;
  }

  static bool validateDate(String date) {
    final regex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
    );
    return regex.hasMatch(date);
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
      } else if (parsedHeight > 230.0) {
        return "Height must be 230 or less";
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
      } else if (parsedWeight > 155.0) {
        return "Weight must be 155 or less";
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
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return null;
    }
    if (!GetUtils.isEmail(email.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

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

  static Future<void> storeUserData({
    required String name,
    required String weight,
    required String height,
    required String gender,
    required String dob,
    required String email,
    required String smokerType,
    required String userImage,
    required bool isFullHistory,
  }) async {
    await Future.wait([
      IndoSharedPreference.instance.saveUserName(name),
      IndoSharedPreference.instance.saveGenderType(gender.toString()),
      IndoSharedPreference.instance.saveHeight(height.toString()),
      IndoSharedPreference.instance.saveWeight(weight.toString()),
      IndoSharedPreference.instance.saveAge(dob.toString()),
      IndoSharedPreference.instance.saveSmokerType(smokerType.toString()),
      IndoSharedPreference.instance.saveHistoryType(isFullHistory),
      if (userImage.isNotEmpty)
        IndoSharedPreference.instance.saveUserImage(userImage),
      if (email.isNotEmpty) IndoSharedPreference.instance.saveUserEmail(email),
    ]);
  }

  Future<int> getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    return level;
  }

  Future<bool> getBatterySaveMode() async {
    final saveMode = await _battery.isInBatterySaveMode;
    return saveMode;
  }

  static const List<String> tabGuestTitles = [
    "Basic Vital Signs",
    "Bloodless Blood Tests",
    "Risks",
    "Stress",
    "Heart Rate Variability",
    "Advanced Heart Rate Variability",
  ];
  static const List<String> tabTitles = [
    "All",
    "Basic Vital Signs",
    "Bloodless Blood Tests",
    "Risks",
    "Stress",
    "Heart Rate Variability",
    "Advanced Heart Rate Variability",
  ];
  static final List<Widget> tabWidgets =
      tabTitles.map((title) => Tab(text: title)).toList();
  static final List<Widget> tabGuestWidget =
      tabGuestTitles.map((title) => Tab(text: title)).toList();

  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
