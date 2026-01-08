import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/indo_common_card.dart';

class VitalCartWidget extends StatelessWidget {
  VitalCartWidget({super.key, required this.allList});
  final List<Map<String, dynamic>> allList;

  final _measurementController = Get.find<MeasurementController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: AppDimensions.only(bottom: 10),
      shrinkWrap: true,
      itemCount: allList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: AppDimensions.symmetric(horizontal: 10, vertical: 10),
          child: IndoCommonCard(
            confidenceLevel: allList[index]["vitalConfidence"] ?? "",
            imageAsset: allList[index]["imageAsset"] ?? '',
            isVitalActive: allList[index]["isVitalActive"] ?? true,
            vitalName: allList[index]["vitalName"],
            vitalValue: allList[index]["vitalValue"] ?? '',
            vitalCondition: allList[index]["vitalCondition"] ?? '',
            vitalMass: allList[index]["vitalMass"] ?? "",
            vitalStatus: allList[index]["vitalStatus"],
            vitalHeading: allList[index]["vitalHeading"],
            vitalDescription: allList[index]["vitalDescription"],
            isExpand: allList[index]["isExpand"] ?? false,
            expandedWidget: allList[index]["expandedWidget"] ?? SizedBox(),
            onInfoTop: () {
              AppNavigation.to(
                AppRoutes.vitalDescriptions,
                arguments: {"vitalKey": allList[index]["vitalKey"]},
              );
            },
          ),
        );
      },
    );
  }
}
