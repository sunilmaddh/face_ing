import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/demo/status_gauge_list.dart';
import 'package:ntt_data/demo/vital_graph_piachart.dart';
import 'package:ntt_data/demo/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/custom_line_chart_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/widgets/vital_gauge_paichart.dart';
import 'package:ntt_data/test_main.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatelessWidget {
  VitalGraphFirstCard({super.key});
  List<Widget> tabWidget = [];
  var vitalHelper = VitalGraphHelper();
  final _vitalController = Get.find<VitalGraphController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height(610),
      child: GraphTabBarWidget(
        isNotRadius: false,
        tabWidgets: VitalGraphHelper.tabGraphWidgets,
        tabBarWidgets: [
          _buildVitalGridSection(),
          _buildVitalGridSection(),
          _buildVitalGridSection(),
          _buildVitalGridSection(),
          _buildVitalGridSection(),
          _buildVitalGridSection(),
          _buildVitalGridSection(),
        ],
      ),
    );
  }

  // _buildVitalSection(_vitalController.ahrvResponse),
  Widget _buildVitalGridSection() {
    return Padding(
      padding: AppDimensions.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 7,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return
          // Expanded(
          //   child: CommonGraphCard(
          //     widget: Flexible(
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: 155,
          //         child: GaugeWithBadges(),
          //       ),
          //     ),
          //   ),
          // );
          CommonGraphCard(
            widget: SizedBox(
              height: 120,
              child: Expanded(
                child: Padding(
                  padding: AppDimensions.only(left: 30),
                  child: CustomLineChartWidget(),
                ),
              ),
            ),
          );
          // VitalGraphWidget(
          //   leftTitle: const [],
          //   bottomTitles: const [],
          //   vitalValue: const [],
          //   vitalName: "1",
          // ),
          // );
        },
      ),
    );
  }

  _buildVitalSection(Rx<AdvancedHeartRateVariability> vitalResponse) {
    var data = vitalResponse.value.vitalType;
    return GraphTabBarWidget(
      tabWidgets: List.generate(
        vitalResponse.value.vitalType!.length,
        (i) => Obx(() {
          return Tab(text: vitalResponse.value.vitalType![i]);
        }),
      ),
      tabBarWidgets: List.generate(
        vitalResponse.value.vitalTypeDetails!.length,

        (i) => Obx(() {
          return isNumeric(
                vitalResponse.value.vitalTypeDetails![i].healthList.first.value
                    .toString(),
              )
              ? CommonGraphCard(
                widget: VitalGraphWidget(
                  leftTitle: vitalResponse.value.vitalTypeDetails![i].yValues,

                  bottomTitles:
                      vitalResponse.value.vitalTypeDetails![i].xValues,
                  vitalValue:
                      vitalResponse.value.vitalTypeDetails![i].healthList,
                  vitalName: data![i],
                ),
              )
              : VitalPieChart(
                vitalValue: vitalResponse.value.vitalTypeDetails![i].healthList,
                controller: _vitalController,
              );
        }),
      ),
      isNotRadius: true,
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
