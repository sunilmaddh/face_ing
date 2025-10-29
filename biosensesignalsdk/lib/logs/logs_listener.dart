import 'package:biosensesignal_flutter_sdk/logs/logs_info.dart';

abstract class LogsListener {
  void onLogsReady(LogsInfo logsInfo);
}
