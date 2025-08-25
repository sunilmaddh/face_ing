import 'package:flutter/widgets.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class VitalNavigationService {
  void goToAnalyzing({VoidCallback? action}) {
    AppNavigation.off(
      AppRoutes.analyzingHealthData,
      action: () {
        action?.call();
      },
    );
  }

  void goToReport({required bool isFullStory}) {
    final route =
        isFullStory ? AppRoutes.analyzingHealthData : AppRoutes.allReportScreen;
    AppNavigation.off(route, action: () {});
  }
}
