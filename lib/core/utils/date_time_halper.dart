import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Converts UTC time string to device's local time and returns formatted string
  static String formatUtcToLocal(String utcString) {
    try {
      print("api Time: $utcString");
      DateTime utcDateTime = DateTime.parse('${utcString}Z');
      ;
      print("UTC Time: $utcDateTime");

      // Convert to local time
      DateTime localDateTime = utcDateTime.toLocal();

      // Format the local time properly using 24-hour clock
      String formatted = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(localDateTime);

      print("Local Time: $formatted");

      return formatted;
    } catch (e) {
      print("Date parsing error: $e");
      return 'Invalid date';
    }
  }
}
