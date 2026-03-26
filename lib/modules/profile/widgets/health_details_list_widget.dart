import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

class HealthDetailsListWidget extends StatelessWidget {
  final List<HealthDetailList> healthDetailsList;

  const HealthDetailsListWidget({super.key, required this.healthDetailsList});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: healthDetailsList.length,
        itemBuilder: (context, index) {
          final result = healthDetailsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IndoSakuraCommonCard(
              confidenceLevel: result.vitalConfidence.toString(),
              isSdkType: true,
              isLowGood: AppMethods.stringToBool(result.isTypeVital ?? 'false'),
              vitalName: result.vitalName ?? '',
              vitalCondition: result.vitalRange ?? '',
              vitalDescription: result.vitalDescription ?? '',
              vitalStatus: result.vitalStatus ?? '',
              vitalValue: result.vitalValue ?? '',
              vitalHeading: result.vitalHeading ?? '',
              vitalMass: result.vitalUnit ?? '',
              vitalSubList: result.vitalSubList ?? [],
              onInfoTop: () {
                AppNavigation.to(
                  AppRoutes.vitalDescriptions,
                  arguments: {"vitalKey": result.vitalKey},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
