import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/demo/vital_graph_piachart.dart';
import 'package:ntt_data/demo/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatelessWidget {
  VitalGraphFirstCard({super.key});
  List<Widget> tabWidget = [];
  var vitalHelper = VitalGraphHelper();
  final _vitalController = Get.find<VitalGraphController>();
  @override
  Widget build(BuildContext context) {
    // tabWidget = <Widget>[
    //   _buildWidget(_vitalController.wellnessGraphResponse),

    // Obx(
    //   () => _buildWidget(
    //     vitalSign.vitalType!.map((title) => Tab(text: title)).toList(),

    //     List.generate(
    //       vitalSign.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: vitalSign.vitalTypeDetails![i].yValues,
    //         bottomTitles: vitalSign.vitalTypeDetails![i].xValues,
    //         vitalValue: vitalSign.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // Obx(
    //   () => _buildWidget(
    //     bloodless.vitalType!.map((title) => Tab(text: title)).toList(),
    //     List.generate(
    //       bloodless.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: bloodless.vitalTypeDetails![i].yValues,
    //         bottomTitles: bloodless.vitalTypeDetails![i].xValues,
    //         vitalValue: bloodless.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // Obx(
    //   () => _buildWidget(
    //     risks.vitalType!.map((title) => Tab(text: title)).toList(),
    //     List.generate(
    //       risks.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: risks.vitalTypeDetails![i].yValues,
    //         bottomTitles: risks.vitalTypeDetails![i].xValues,
    //         vitalValue: risks.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // Obx(
    //   () => _buildWidget(
    //     stress.vitalType!.map((title) => Tab(text: title)).toList(),
    //     List.generate(
    //       stress.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: stress.vitalTypeDetails![i].yValues,
    //         bottomTitles: stress.vitalTypeDetails![i].xValues,
    //         vitalValue: stress.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // Obx(
    //   () => _buildWidget(
    //     hrv.vitalType!.map((title) => Tab(text: title)).toList(),
    //     List.generate(
    //       hrv.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: hrv.vitalTypeDetails![i].yValues,
    //         bottomTitles: hrv.vitalTypeDetails![i].xValues,
    //         vitalValue: hrv.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // Obx(
    //   () => _buildWidget(
    //     ahrv.vitalType!.map((title) => Tab(text: title)).toList(),
    //     List.generate(
    //       ahrv.vitalTypeDetails!.length,
    //       (i) => VitalGraphWidget(
    //         leftTitle: ahrv.vitalTypeDetails![i].yValues,
    //         bottomTitles: ahrv.vitalTypeDetails![i].xValues,
    //         vitalValue: ahrv.vitalTypeDetails![i].healthList,
    //       ),
    //     ),
    //   ),
    // ),
    // ];
    return SizedBox(
      height: AppDimensions.height(500),
      child: GraphTabBarWidget(
        isNotRadius: false,
        tabWidgets: VitalGraphHelper.tabGraphWidgets,
        tabBarWidgets: [
          _buildVitalSection(_vitalController.wellnessGraphResponse),
          _buildVitalSection(_vitalController.vitalSignesponse),
          _buildVitalSection(_vitalController.bloodlessResponse),
          _buildVitalSection(_vitalController.risksResponse),
          _buildVitalSection(_vitalController.stressResponse),
          _buildVitalSection(_vitalController.hrvResponse),
          _buildVitalSection(_vitalController.ahrvResponse),
        ],
      ),
    );
  }

  _buildVitalSection(Rx<AdvancedHeartRateVariability> vitalResponse) {
    return GraphTabBarWidget(
      tabWidgets: List.generate(
        vitalResponse.value.vitalType!.length,
        (i) => Obx(() => Tab(text: vitalResponse.value.vitalType![i])),
      ),
      tabBarWidgets: List.generate(
        vitalResponse.value.vitalTypeDetails!.length,
        (i) => Obx(
          () =>
          // isNumeric(
          //       vitalResponse
          //           .value
          //           .vitalTypeDetails![i]
          //           .healthList
          //           .first
          //           .value
          //           .toString(),
          //     )
          //     ?
          VitalGraphWidget(
            leftTitle: vitalResponse.value.vitalTypeDetails![i].yValues,

            bottomTitles: vitalResponse.value.vitalTypeDetails![i].xValues,
            vitalValue: vitalResponse.value.vitalTypeDetails![i].healthList,
          ),
          // : VitalPieChart(
          //   vitalValue:
          //       vitalResponse.value.vitalTypeDetails![i].healthList,
          //   controller: _vitalController,
          // ),
        ),
      ),
      isNotRadius: true,
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
