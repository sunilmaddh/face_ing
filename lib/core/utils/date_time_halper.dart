// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Converts UTC time string to device's local time and returns formatted string
  static String formatUtcToLocal(String utcString) {
    try {
      DateTime utcDateTime = DateTime.parse('${utcString}Z');

      // Convert to local time
      DateTime localDateTime = utcDateTime.toLocal();

      // Format the local time properly using 24-hour clock
      String formatted = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(localDateTime);

      return formatted;
    } catch (e) {
      return 'Invalid date';
    }
  }
}
