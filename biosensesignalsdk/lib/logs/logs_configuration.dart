import 'package:biosensesignal_flutter_sdk/logs/logs_level.dart';

class LogsConfiguration {
  final LogsLevel logsLevel;
  final bool saveLogsToPublicFolder;

  LogsConfiguration({required this.logsLevel, required this.saveLogsToPublicFolder});
}