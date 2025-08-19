import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/test_main.dart';
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

    // Try parsing with all formats
    for (var format in formats) {
      try {
        parsedDate = format.parseStrict(birthDate);

        // ✅ Reject 2-digit years
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
      // Parse with strict format
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
      } else if (parsedWeight > 200.0) {
        return "Weight must be 200 or less";
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

  List<Widget> tabWidgets = [
    Tab(text: "All"),
    Tab(text: "Basic Vital Signs"),
    Tab(text: "Bloodless Blood Tests"),
    Tab(text: "Risks"),
    Tab(text: "Stress"),
    Tab(text: "Heart Rate Variability"),
    Tab(text: "Advanced Heart Rate Variability"),
  ];
  List<Widget> tabGraphWidgets = [
    Tab(text: "Wellness"),
    Tab(text: "Basic Vital Signs"),
    Tab(text: "Bloodless Blood Tests"),
    Tab(text: "Risks"),
    Tab(text: "Stress"),
    Tab(text: "Heart Rate Variability"),
    Tab(text: "Advanced Heart Rate Variability"),
  ];
  List<Widget> tabWellnessWidgets = [Tab(text: "Wellness")];
  List<Widget> tabVitalSignWidgets = [
    Tab(text: "Breathing Rate"),
    Tab(text: "Pulse Rate(Heart Rate)"),
    Tab(text: "PRQ"),
    Tab(text: "Blood Pressure"),
    Tab(text: "Oxyzen Saturation"),
  ];
  List<Widget> tabBBTWidgets = [
    Tab(text: "Hemoglobin"),
    Tab(text: "Hemoglobin A1C"),
  ];
  List<Widget> tabRiskWidgets = [
    Tab(text: "ASCVD Risk"),
    Tab(text: "High Blood Pressure Risk"),
    Tab(text: "High HbA1c Risk"),
    Tab(text: "High Fasting Glucose Risk"),
    Tab(text: "High Total Cholesterol Risk"),
    Tab(text: "Low Hemoglobin Risk"),
  ];
  List<Widget> tabStressWidgets = [Tab(text: "Stress Level")];
  List<Widget> tabHRBWidgets = [Tab(text: "HRV SDNN")];
  List<Widget> tabAHRVWidgets = [
    Tab(text: "PNS Zone"),
    Tab(text: "PNS INdex"),
    Tab(text: "SNS Zone"),
    Tab(text: "SNS Index"),
    Tab(text: "SD1"),
    Tab(text: "SD2"),
    Tab(text: "LF/HF"),
  ];

  List<Widget> tabBarWellnessWidget = <Widget>[VitalGraphWidget()];
  List<Widget> tabBarVitalSignWidget = <Widget>[
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
  ];
  List<Widget> tabBarBloodlessWidget = <Widget>[
    VitalGraphWidget(),
    VitalGraphWidget(),
  ];
  List<Widget> tabBarRiskWidget = <Widget>[
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
  ];
  List<Widget> tabBarStressWidget = <Widget>[VitalGraphWidget()];
  List<Widget> tabBaHRVWidget = <Widget>[VitalGraphWidget()];
  List<Widget> tabBaAHRVWidget = <Widget>[
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
    VitalGraphWidget(),
  ];
}
