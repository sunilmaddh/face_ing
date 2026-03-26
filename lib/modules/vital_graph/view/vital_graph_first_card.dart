import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/bottomsheet_helper.dart';
import 'package:ntt_data/modules/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/widgets/bar_chart/vital_graph_empty_widget.dart';
import 'package:ntt_data/modules/vital_graph/widgets/bar_chart/vital_graph_widget.dart';
import 'package:ntt_data/modules/vital_graph/widgets/bar_chart/vital_graph_widget_string.dart';
import 'package:ntt_data/modules/vital_graph/widgets/common_graph_card.dart';
import 'package:ntt_data/modules/vital_graph/widgets/line_chart/custom_line_bar_chart_string.dart';
import 'package:ntt_data/modules/vital_graph/widgets/line_chart/custom_line_chart_widget.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class VitalGraphFirstCard extends StatefulWidget {
  const VitalGraphFirstCard({super.key, required this.guestId});

  final String guestId;

  @override
  State<VitalGraphFirstCard> createState() => _VitalGraphFirstCardState();
}

class _VitalGraphFirstCardState extends State<VitalGraphFirstCard>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final VitalGraphController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<VitalGraphController>();

    _tabController = TabController(
      length: VitalGraphHelper.tabGraphWidgets.length,
      vsync: this,
    );
  }

  List<Widget> _buildTabViews() {
    return [
      BuildVitalGridSectionWidget(
        vitalResponse: controller.wellnessGraphResponse,
      ),
      BuildVitalGridSectionWidget(vitalResponse: controller.vitalSignResponse),
      BuildVitalGridSectionWidget(vitalResponse: controller.bloodlessResponse),
      BuildVitalGridSectionWidget(vitalResponse: controller.risksResponse),
      BuildVitalGridSectionWidget(vitalResponse: controller.stressResponse),
      BuildVitalGridSectionWidget(vitalResponse: controller.hrvResponse),
      BuildVitalGridSectionWidget(vitalResponse: controller.ahrvResponse),
    ];
  }

  void _handleTabChanged(int index) {
    if (widget.guestId.isNotEmpty && index > 0) {
      BottomsheetHelper.showBottomSheetAlert(context, _tabController);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height(610.h),
      child: GraphTabBarWidget(
        tabController: _tabController,
        isNotRadius: false,
        tabWidgets: VitalGraphHelper.tabGraphWidgets,
        tabBarWidgets: _buildTabViews(),
        onTabChanged: _handleTabChanged,
      ),
    );
  }
}

class BuildVitalGridSectionWidget extends StatelessWidget {
  BuildVitalGridSectionWidget({super.key, required this.vitalResponse});

  final Rx<AdvancedHeartRateVariability> vitalResponse;
  final VitalGraphController controller = Get.find<VitalGraphController>();

  bool get isMonthly => controller.isGraphFilterType.value.contains("Monthly");

  @override
  Widget build(BuildContext context) {
    final result = vitalResponse.value.vitalTypeDetails ?? [];

    return Padding(
      padding: AppDimensions.symmetric(horizontal: 8.w, vertical: 5.h),
      child:
          isMonthly
              ? _buildMonthlyList(result)
              : _buildDailyOrWeeklyList(result),
    );
  }

  Widget _buildMonthlyList(List<VitalTypeDetail> result) {
    return ListView.builder(
      padding: AppDimensions.only(bottom: 100),
      itemCount: result.length,
      itemBuilder: (context, index) {
        final item = result[index];
        return Padding(
          padding: AppDimensions.only(bottom: 10),
          child: _buildMonthlyGraphCard(item),
        );
      },
    );
  }

  Widget _buildDailyOrWeeklyList(List<VitalTypeDetail> result) {
    return Padding(
      padding: AppDimensions.only(bottom: 70),
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          final item = result[index];
          return Padding(
            padding: AppDimensions.only(bottom: 10),
            child: _buildLineChartCard(item),
          );
        },
      ),
    );
  }

  Widget _buildMonthlyGraphCard(VitalTypeDetail item) {
    final healthList = _normalizedHealthList(item);
    final isEmpty = item.healthList?.isEmpty ?? true;
    final isNumeric = _isNumericHealthList(item);

    if (isEmpty) {
      return CommonGraphCard(
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              VitalGraphEmptyWidget(
                leftTitle: item.yValues ?? [],
                bottomTitles: item.xValues ?? [],
                vitalValue: healthList,
                vitalName: item.vitalName ?? '',
              ),
              CommonText.text("No Measurement Taken Period Selection"),
            ],
          ),
        ),
        vitalName: item.vitalName ?? '',
        avg: "",
        unit: "",
        statusList: item.vitalStatusList ?? [],
        healthList: item.healthList ?? [],
      );
    }

    return CommonGraphCard(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            isNumeric
                ? VitalGraphWidget(
                  leftTitle: item.yValues ?? [],
                  bottomTitles: item.xValues ?? [],
                  vitalValue: healthList,
                  vitalName: item.vitalName ?? '',
                )
                : VitalGraphWidgetString(
                  leftTitle: item.yValues ?? [],
                  bottomTitles: item.xValues ?? [],
                  vitalValue: healthList,
                  vitalName: item.vitalName ?? '',
                ),
      ),
      vitalName: item.vitalName ?? '',
      avg: item.vitalAvgValue ?? '',
      unit: item.vitalUnit ?? '',
      statusList: item.vitalStatusList ?? [],
      healthList: item.healthList ?? [],
    );
  }

  Widget _buildLineChartCard(VitalTypeDetail item) {
    final healthList = _normalizedHealthList(item);
    final isEmpty = item.healthList?.isEmpty ?? true;
    final isNumeric = _isNumericHealthList(item);

    if (isEmpty) {
      return CommonGraphCard(
        widget: Padding(
          padding: AppDimensions.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              CustomLineChartWidget(
                leftTitles: item.yValues ?? [],
                bottomTitles: item.xValues ?? [],
                vitalValues: healthList,
                vitalName: item.vitalName ?? '',
              ),
              CommonText.text("No Measurement Taken Period Selection"),
            ],
          ),
        ),
        vitalName: item.vitalName ?? '',
        avg: "",
        unit: "",
        statusList: item.vitalStatusList ?? [],
        healthList: healthList,
      );
    }

    if (!isNumeric) {
      return CommonGraphCard(
        vitalValue: "",
        widget: Padding(
          padding: AppDimensions.symmetric(horizontal: 0, vertical: 10),
          child: CustomLineBarChart(
            leftTitles: item.yValues ?? [],
            bottomTitles: item.xValues ?? [],
            vitalValues: healthList,
            vitalName: item.vitalName ?? '',
          ),
        ),
        vitalName: item.vitalName ?? '',
        avg: "",
        unit: item.vitalUnit ?? '',
        statusList: item.vitalStatusList ?? [],
        healthList: healthList,
      );
    }

    return CommonGraphCard(
      widget: Padding(
        padding: AppDimensions.symmetric(horizontal: 10, vertical: 20),
        child: CustomLineChartWidget(
          leftTitles: item.yValues ?? [],
          bottomTitles: item.xValues ?? [],
          vitalValues: healthList,
          vitalName: item.vitalName ?? '',
        ),
      ),
      vitalName: item.vitalName ?? '',
      avg: item.vitalAvgValue ?? '',
      unit: item.vitalUnit ?? '',
      statusList: item.vitalStatusList ?? [],
      healthList: healthList,
    );
  }

  List<HealthList> _normalizedHealthList(VitalTypeDetail item) {
    return VitalGraphHelper().normalizeHealthData(
      item.xValues ?? [],
      item.healthList ?? [],
    );
  }

  bool _isNumericHealthList(VitalTypeDetail item) {
    final healthList = item.healthList;
    if (healthList == null || healthList.isEmpty) return false;
    final value = healthList.first.value ?? '';
    return AppMethods.isNumeric(value);
  }

  double getVitalValue(String value) {
    if (AppMethods.isNumeric(value)) {
      return double.parse(value);
    }
    return 0.0;
  }
}
