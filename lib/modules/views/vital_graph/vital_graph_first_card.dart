import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/bottomsheet_helper.dart';
import 'package:ntt_data/core/utils/extentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/bar_chart/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/bar_chart/vital_graph_widget_string.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/gauge/caterigical_guage.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/common_graph_card.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/line_chart/custom_line_bar_chart_string.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/line_chart/custom_line_chart_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/gauge/vital_guage.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatefulWidget {
  const VitalGraphFirstCard({super.key, required this.gusetId});

  final String gusetId;

  @override
  State<VitalGraphFirstCard> createState() => _VitalGraphFirstCardState();
}

class _VitalGraphFirstCardState extends State<VitalGraphFirstCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabWidget = [];

  var vitalHelper = VitalGraphHelper();

  final _vitalController = Get.find<VitalGraphController>();

  @override
  void initState() {
    _tabController = TabController(
      length: VitalGraphHelper.tabGraphWidgets.length,
      vsync: this,
    );
    super.initState();
  }

  // late var value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height(610),
      child: GraphTabBarWidget(
        tabController: _tabController,
        isNotRadius: false,
        tabWidgets: VitalGraphHelper.tabGraphWidgets,
        tabBarWidgets: [
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.wellnessGraphResponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.vitalSignesponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.bloodlessResponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.risksResponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.stressResponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.hrvResponse,
          ),
          BuildVitalGridSectionWidget(
            vitalResponse: _vitalController.ahrvResponse,
          ),
        ],
        onTabChanged: (index) {
          if (widget.gusetId.isNotEmpty) {
            if (index > 0) {
              BottomsheetHelper.showBottomSheetAlert(context, _tabController);
            }
          }
        },
      ),
    );
  }
}

class BuildVitalGridSectionWidget extends StatelessWidget {
  BuildVitalGridSectionWidget({super.key, required this.vitalResponse});
  final Rx<AdvancedHeartRateVariability> vitalResponse;

  final _vitalController = Get.find<VitalGraphController>();
  @override
  Widget build(BuildContext context) {
    var result = vitalResponse.value.vitalTypeDetails!;
    return Padding(
      padding: AppDimensions.all(8.0),
      child:
          _vitalController.isGraphFilterType.contains("Monthly")
              ? ListView.builder(
                padding: AppDimensions.only(bottom: 100),
                itemCount: result.length,

                itemBuilder: (context, index) {
                  var healthList = VitalGraphHelper().normalizeHealthData(
                    result[index].xValues!,
                    result[index].healthList!,
                  );
                  return Padding(
                    padding: AppDimensions.only(bottom: 10),
                    child: CommonGraphCard(
                      // vitalValue: result[index].vitalValue!.toFirstCaps(),
                      widget:
                          !isNumeric(result[index].healthList!.first.value!)
                              ? VitalGraphWidgetString(
                                leftTitle: result[index].yValues!,
                                bottomTitles: result[index].xValues!,
                                vitalValue: healthList,
                                vitalName: result[index].vitalName!,
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: VitalGraphWidget(
                                  leftTitle: result[index].yValues!,
                                  bottomTitles: result[index].xValues!,
                                  vitalValue: healthList,
                                  vitalName: result[index].vitalName!,
                                ),
                              ),
                      vitalName: result[index].vitalName!,
                      avg: result[index].vitalAvgValue!,
                      unit: result[index].vitalUnit!,
                      statusList: result[index].vitalStatusList!,
                      healthList: result[index].healthList!,
                    ),
                  );
                },
              )
              : _vitalController.isGraphFilterType.value == "Today"
              ? Padding(
                padding: AppDimensions.only(bottom: 70),
                child: GridView.builder(
                  itemCount: result.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.67,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    var value = double.tryParse(result[index].vitalValue!);
                    return Padding(
                      padding: AppDimensions.only(bottom: 0),
                      child: CommonGraphCard(
                        vitalValue: result[index].vitalValue!.toFirstCaps(),
                        widget: Padding(
                          padding: AppDimensions.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child:
                              isNumeric(result[index].vitalValue!)
                                  ? SizedBox(
                                    height: AppDimensions.height(120),
                                    child: VitalGauge(
                                      vitalName: result[index].vitalName!,
                                      value: value!,
                                    ),
                                  )
                                  : SizedBox(
                                    height: AppDimensions.height(120),
                                    child: CategoricalGauge(
                                      vitalName: result[index].vitalName!,
                                      currentStatus: result[index].vitalValue!,
                                    ),
                                  ),
                        ),
                        vitalName: result[index].vitalName.toString(),
                        avg: "",
                        unit: result[index].vitalUnit.toString(),
                        statusList: result[index].vitalStatusList!,
                        healthList: result[index].healthList!,
                      ),
                    );
                  },
                ),
              )
              : Padding(
                padding: AppDimensions.only(bottom: 70),
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    var healthList = VitalGraphHelper().normalizeHealthData(
                      result[index].xValues!,
                      result[index].healthList!,
                    );

                    debugPrint(healthList.toList().toString());
                    return !isNumeric(result[index].healthList!.first.value!)
                        ? Padding(
                          padding: AppDimensions.only(bottom: 10),
                          child: CommonGraphCard(
                            vitalValue: "",
                            widget: Padding(
                              padding: AppDimensions.symmetric(
                                horizontal: 0,
                                vertical: 10,
                              ),
                              child: CustomLineBarChart(
                                leftTitles: result[index].yValues!,
                                bottomTitles: result[index].xValues!,
                                vitalValues: healthList,
                                vitalName: result[index].vitalName!,
                              ),
                            ),
                            vitalName: result[index].vitalName.toString(),
                            avg: "",
                            unit: result[index].vitalUnit.toString(),
                            statusList: result[index].vitalStatusList!,
                            healthList: healthList,
                          ),
                        )
                        : Padding(
                          padding: AppDimensions.only(bottom: 10),
                          child: CommonGraphCard(
                            // vitalValue: result[index].vitalValue!,
                            widget: Padding(
                              padding:
                                  result[index].vitalName == "PNS Index" ||
                                          result[index].vitalName == "SNS Index"
                                      ? AppDimensions.only(
                                        left: 10,
                                        right: 10,
                                        top: 20,
                                        bottom: 60,
                                      )
                                      : AppDimensions.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                              child: CustomLineChartWidget(
                                leftTitles: result[index].yValues!,
                                bottomTitles: result[index].xValues!,
                                vitalValues: healthList,
                                vitalName: result[index].vitalName!,
                              ),
                            ),
                            vitalName: result[index].vitalName.toString(),
                            avg: result[index].vitalAvgValue.toString(),
                            unit: result[index].vitalUnit.toString(),
                            statusList: result[index].vitalStatusList!,
                            healthList: healthList,
                          ),
                        );
                  },
                ),
              ),
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  double getVitalValue(String v) {
    if (isNumeric(v)) {
      return double.parse(v);
    }
    return 0.0;
  }
}
