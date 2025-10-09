import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

class BuildCardWidget extends StatelessWidget {
  const BuildCardWidget({
    super.key,
    required this.healthDetailsList,
    required this.isBasicVital,
  });
  final RxList<HealthDetailList> healthDetailsList;
  final RxBool isBasicVital;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: healthDetailsList.length,
        itemBuilder: (context, index) {
          var result = healthDetailsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child:
                isBasicVital.isTrue
                    ? IndoSakuraCommonCard(
                      confidenceLevel: result.vitalConfidence.toString(),
                      isSdkType: true,
                      isLowGood: AppMethods.stringToBool(result.isTypeVital!),
                      vitalName: result.vitalName!,
                      vitalCondition: result.vitalRange!,
                      vitalDescription: result.vitalDescription!,
                      vitalStatus: result.vitalStatus!,
                      vitalValue: result.vitalValue!,
                      vitalHeading: result.vitalHeading!,
                      vitalMass: result.vitalUnit!,
                      vitalSubList: result.vitalSubList!,
                      onInfoTop: () {
                        AppNavigation.to(
                          AppRoutes.vitalDescriptions,
                          arguments: {"vitalKey": result.vitalKey},
                        );
                      },
                    )
                    : IndoSakuraCommonCard(
                      confidenceLevel: "",
                      isSdkType: true,
                      isLowGood: false,
                      vitalName: result.vitalName!,
                      vitalCondition: "",
                      vitalDescription: result.vitalDescription!,
                      vitalStatus: "",
                      vitalValue: "",
                      vitalHeading: "",
                      vitalMass: "",
                      vitalSubList: [],
                      onInfoTop: () {
                        // AppNavigation.to(
                        //   AppRoutes.vitalDescriptions,
                        //   arguments: {"vitalKey": result.vitalKey},
                        // );
                      },
                    ),
          );
        },
      );
    });
  }
}
