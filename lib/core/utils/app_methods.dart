import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/enum/health_tab_enum.dart';
import 'package:ntt_data/modules/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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
      final index = dataList.indexWhere(
        (element) => element[AppConstents.question] == question,
      );

      if (index != -1) {
        dataList[index][AppConstents.answer] = selectedAnswers;
        dataList[index][AppConstents.id] = id;
      } else {
        dataList.add({
          AppConstents.id: id,
          AppConstents.question: question,
          AppConstents.answer: selectedAnswers,
        });
      }
    }

    healthMenuData.value = dataList;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  late AnimationController animationController;

  AnimationController storeController() => animationController;

  AnimationController sendController(AnimationController controller) {
    animationController = controller;
    return animationController;
  }

  Future<double> calculateAge(String birthDate) async {
    final formats = [
      DateFormat(AppConstents.ddMMyyyySlash),
      DateFormat(AppConstents.mmDDyyyySlash),
      DateFormat(AppConstents.yyyyMMddSlash),
      DateFormat(AppConstents.yyyyMMddDash),
      DateFormat(AppConstents.ddMMyyyyDash),
      DateFormat(AppConstents.mmDDyyyyDash),
    ];

    DateTime? parsedDate;

    for (final format in formats) {
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
      throw FormatException("${AppConstents.invalidDateFormat}: $birthDate");
    }

    final today = DateTime.now();
    var age = today.year - parsedDate.year;

    if (today.month < parsedDate.month ||
        (today.month == parsedDate.month && today.day < parsedDate.day)) {
      age--;
    }

    return age.toDouble();
  }

  void logout() async {
    await IndoSharedPreference.instance.saveUserId("");
    await IndoSharedPreference.instance.saveOnBoard(AppConstents.falseValue);
    AppNavigation.offAll(AppRoutes.loginScreen);
  }

  static String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static bool stringToBool(String value) {
    return value.toLowerCase() == AppConstents.trueValue;
  }

  static String? validateDOB(String? dob) {
    if (dob == null || dob.trim().isEmpty) {
      return AppConstents.selectDob;
    }

    try {
      final parseDate = DateFormat(
        AppConstents.ddMMyyyySlash,
      ).parseStrict(dob.trim());
      final now = DateTime.now();
      final minAllowedDate = DateTime(now.year - 18, now.month, now.day);

      if (parseDate.isAfter(minAllowedDate)) {
        return AppConstents.ageLimit;
      } else if (!validateDate(dob)) {
        return AppConstents.invalidDate;
      } else if (parseDate.year < 1925) {
        return AppConstents.yearLimit;
      }
    } catch (e) {
      return AppConstents.invalidDate;
    }
    return null;
  }

  Future<String> convertDateFormatToYY(String date) async {
    final formats = [
      DateFormat(AppConstents.ddMMyyyySlash),
      DateFormat(AppConstents.yyyyMMddSlash),
    ];

    DateTime? parsedDate;
    for (final format in formats) {
      try {
        parsedDate = format.parseStrict(date);
        break;
      } catch (_) {
        continue;
      }
    }

    if (parsedDate == null) {
      throw FormatException("${AppConstents.invalidDateFormat}: $date");
    }

    return DateFormat(AppConstents.yyyyMMddSlash).format(parsedDate);
  }

  Future<String> convertDateFormateToDD(String date) async {
    final formats = [
      DateFormat(AppConstents.ddMMyyyySlash),
      DateFormat(AppConstents.yyyyMMddSlash),
    ];

    DateTime? parsedDate;
    for (final format in formats) {
      try {
        parsedDate = format.parseStrict(date);
        break;
      } catch (_) {
        continue;
      }
    }

    if (parsedDate == null) {
      throw FormatException("${AppConstents.invalidDateFormat}: $date");
    }

    return DateFormat(AppConstents.ddMMyyyySlash).format(parsedDate);
  }

  static bool validateDate(String date) {
    final regex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
    );
    return regex.hasMatch(date);
  }

  static String? validateHeight(String? height) {
    if (height == null || height.isEmpty) {
      return AppConstents.enterHeight;
    }

    final parsedHeight = double.tryParse(height);
    if (parsedHeight == null) {
      return AppConstents.validNumber;
    } else if (parsedHeight < 130.0) {
      return AppConstents.heightMin;
    } else if (parsedHeight > 230.0) {
      return AppConstents.heightMax;
    }

    return null;
  }

  static String? validateWeight(String? weight) {
    if (weight == null || weight.isEmpty) {
      return AppConstents.enterWeight;
    }

    final parsedWeight = double.tryParse(weight);
    if (parsedWeight == null) {
      return AppConstents.validNumber;
    } else if (parsedWeight < 40.0) {
      return AppConstents.weightMin;
    } else if (parsedWeight > 155.0) {
      return AppConstents.weightMax;
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return AppConstents.enterName;
    } else if (!GuestHelper.isValidInput(name)) {
      return AppConstents.validName;
    }
    return null;
  }

  final List<Map<String, String>> guestOptionList = [
    {
      AppConstents.name: AppConstents.updateProfilePhoto,
      AppConstents.optionType: AppConstents.photo,
    },
    {
      AppConstents.name: AppConstents.updateProfileDetails,
      AppConstents.optionType: AppConstents.details,
    },
  ];

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return null;
    }
    if (!GetUtils.isEmail(email.trim())) {
      return AppConstents.enterEmail;
    }
    return null;
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
    return await _battery.batteryLevel;
  }

  Future<bool> getBatterySaveMode() async {
    return await _battery.isInBatterySaveMode;
  }

  static final List<HealthTab> guestTabs = [
    HealthTab.basicVitalSigns,
    HealthTab.bloodlessBloodTests,
    HealthTab.risks,
    HealthTab.stress,
    HealthTab.heartRateVariability,
    HealthTab.advancedHeartRateVariability,
  ];

  static List<Widget> get tabWidgets =>
      HealthTab.values.map((tab) => Tab(text: tab.title)).toList();

  static List<Widget> get tabGuestWidget =>
      guestTabs.map((tab) => Tab(text: tab.title)).toList();

  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  Future<void> toggleWakelock(bool enable) async {
    if (enable) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}
