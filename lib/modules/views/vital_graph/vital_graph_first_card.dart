import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/demo/status_gauge_list.dart';
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
              ? VitalGraphWidget(
                leftTitle: vitalResponse.value.vitalTypeDetails![i].yValues,

                bottomTitles: vitalResponse.value.vitalTypeDetails![i].xValues,
                vitalValue: vitalResponse.value.vitalTypeDetails![i].healthList,
                vitalName: data![i],
              )
              : StatusList(
                healthList: vitalResponse.value.vitalTypeDetails![i].healthList,
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
