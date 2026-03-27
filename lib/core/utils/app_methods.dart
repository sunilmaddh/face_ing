import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/constants/date_formats.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/storage/app_preferences.dart';
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
        (element) => element[ApiConstants.question] == question,
      );

      if (index != -1) {
        dataList[index][ApiConstants.answer] = selectedAnswers;
        dataList[index][ApiConstants.id] = id;
      } else {
        dataList.add({
          ApiConstants.id: id,
          ApiConstants.question: question,
          ApiConstants.answer: selectedAnswers,
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
      DateFormat(DateFormats.ddMMyyyySlash),
      DateFormat(DateFormats.mmDDyyyySlash),
      DateFormat(DateFormats.yyyyMMddSlash),
      DateFormat(DateFormats.yyyyMMddDash),
      DateFormat(DateFormats.ddMMyyyyDash),
      DateFormat(DateFormats.mmDDyyyyDash),
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
      throw FormatException(
        "${ValidationStrings.invalidDateFormat}: $birthDate",
      );
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
    await AppPreferences.instance.saveUserId("");
    await AppPreferences.instance.saveOnBoard(ApiConstants.falseValue);
    AppNavigation.offAll(AppRoutes.loginScreen);
  }

  static String capitalizeFirst(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static bool stringToBool(String value) {
    return value.toLowerCase() == ApiConstants.trueValue;
  }

  static String? validateDOB(String? dob) {
    if (dob == null || dob.trim().isEmpty) {
      return ValidationStrings.selectDob;
    }

    try {
      final parseDate = DateFormat(
        DateFormats.ddMMyyyySlash,
      ).parseStrict(dob.trim());
      final now = DateTime.now();
      final minAllowedDate = DateTime(now.year - 18, now.month, now.day);

      if (parseDate.isAfter(minAllowedDate)) {
        return ValidationStrings.ageLimit;
      } else if (!validateDate(dob)) {
        return ValidationStrings.invalidDate;
      } else if (parseDate.year < 1925) {
        return ValidationStrings.yearLimit;
      }
    } catch (e) {
      return ValidationStrings.invalidDate;
    }
    return null;
  }

  Future<String> convertDateFormatToYY(String date) async {
    final formats = [
      DateFormat(DateFormats.ddMMyyyySlash),
      DateFormat(DateFormats.yyyyMMddSlash),
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
      throw FormatException("${ValidationStrings.invalidDateFormat}: $date");
    }

    return DateFormat(DateFormats.yyyyMMddSlash).format(parsedDate);
  }

  Future<String> convertDateFormateToDD(String date) async {
    final formats = [
      DateFormat(DateFormats.ddMMyyyySlash),
      DateFormat(DateFormats.yyyyMMddSlash),
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
      throw FormatException("${ValidationStrings.invalidDateFormat}: $date");
    }

    return DateFormat(DateFormats.ddMMyyyySlash).format(parsedDate);
  }

  static bool validateDate(String date) {
    final regex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(19|20)\d{2}$',
    );
    return regex.hasMatch(date);
  }

  static String? validateHeight(String? height) {
    if (height == null || height.isEmpty) {
      return ValidationStrings.enterHeight;
    }

    final parsedHeight = double.tryParse(height);
    if (parsedHeight == null) {
      return ValidationStrings.validNumber;
    } else if (parsedHeight < 130.0) {
      return ValidationStrings.heightMin;
    } else if (parsedHeight > 230.0) {
      return ValidationStrings.heightMax;
    }

    return null;
  }

  static String? validateWeight(String? weight) {
    if (weight == null || weight.isEmpty) {
      return ValidationStrings.enterWeight;
    }

    final parsedWeight = double.tryParse(weight);
    if (parsedWeight == null) {
      return ValidationStrings.validNumber;
    } else if (parsedWeight < 40.0) {
      return ValidationStrings.weightMin;
    } else if (parsedWeight > 155.0) {
      return ValidationStrings.weightMax;
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return ValidationStrings.enterName;
    } else if (!GuestHelper.isValidInput(name)) {
      return ValidationStrings.validName;
    }
    return null;
  }

  final List<Map<String, String>> guestOptionList = [
    {
      ApiConstants.nameKey: AppStrings.updateProfilePhoto,
      ApiConstants.optionType: AppStrings.photo,
    },
    {
      ApiConstants.nameKey: AppStrings.updateProfileDetails,
      ApiConstants.optionType: AppStrings.details,
    },
  ];

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return null;
    }
    if (!GetUtils.isEmail(email.trim())) {
      return ValidationStrings.enterEmail;
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
      AppPreferences.instance.saveUserName(name),
      AppPreferences.instance.saveGenderType(gender.toString()),
      AppPreferences.instance.saveHeight(height.toString()),
      AppPreferences.instance.saveWeight(weight.toString()),
      AppPreferences.instance.saveAge(dob.toString()),
      AppPreferences.instance.saveSmokerType(smokerType.toString()),
      AppPreferences.instance.saveHistoryType(isFullHistory),
      if (userImage.isNotEmpty)
        AppPreferences.instance.saveUserImage(userImage),
      if (email.isNotEmpty) AppPreferences.instance.saveUserEmail(email),
    ]);
  }

  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }

  Future<bool> getBatterySaveMode() async {
    return await _battery.isInBatterySaveMode;
  }

  Future<void> toggleWakelock(bool enable) async {
    if (enable) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }

  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
