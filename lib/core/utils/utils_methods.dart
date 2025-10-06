// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class UtilMethods {
  static String stringParser(dynamic value) {
    if (value == false || value == null) {
      return '';
    } else {
      return value.toString();
    }
  }

  static String boolAsStringParser(dynamic value) {
    if (value == "false" || value == null) {
      return 'false';
    } else {
      return value.toString();
    }
  }

  static bool boolValueParser(dynamic value) {
    if (value == false || value == null) {
      return false;
    } else if (value is bool) {
      return value;
    } else {
      return false;
    }
  }

  static double doubleValueParser(dynamic value) {
    if (value == false || value == null) {
      return 0;
    } else if (value is double || value is int) {
      return double.parse("$value");
    } else {
      return 0;
    }
  }

  static List listParser(dynamic value) {
    if (value == false || value == null) {
      return [];
    } else {
      return value;
    }
  }

  static int intParser(dynamic value) {
    if (value == false || value == null) {
      return 0;
    } else {
      return value;
    }
  }

  static DateTime dateTimeParser(dynamic value) {
    try {
      if (value == false || value == null) {
        return DateTime.now();
      } else {
        return DateTime.parse(value);
      }
    } catch (error) {
      return DateTime.now();
    }
  }

  static int daysBetween(DateTime fromDate, DateTime toDate) {
    fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day);
    toDate = DateTime(toDate.year, toDate.month, toDate.day);
    return (toDate.difference(fromDate).inHours / 24).round();
  }

  static String convertDate(String date) {
    try {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return date; // Return the original date if there's an error
    }
  }
}
