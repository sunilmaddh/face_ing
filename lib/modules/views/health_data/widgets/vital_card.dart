import 'package:flutter/material.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/indo_common_card.dart';

class VitalCard extends StatelessWidget {
  const VitalCard({
    super.key,
    required this.vitalName,
    this.vitalValue,
    this.vitalConfidence,
    this.vitalKey,
    this.vitalCondition,
    this.vitalMass,
    required this.vitalStatus,
    this.imageAsset,
    required this.vitalHeading,
    required this.vitalDescription,
    this.isExpand = false,
    this.isVitalActive = true,
    this.expandedWidget = const SizedBox(),
  });

  final String vitalName;
  final String? vitalValue;
  final String? vitalConfidence;
  final String? vitalKey;
  final String? vitalCondition;
  final String? vitalMass;
  final String vitalStatus;
  final String? imageAsset;
  final String vitalHeading;
  final String vitalDescription;
  final bool isExpand;
  final bool isVitalActive;
  final Widget expandedWidget;

  @override
  Widget build(BuildContext context) {
    return IndoCommonCard(
      confidenceLevel: vitalConfidence ?? "",
      imageAsset: imageAsset ?? '',
      isVitalActive: isVitalActive,
      vitalName: vitalName,
      vitalValue: vitalValue ?? 'N/A',
      vitalCondition: vitalCondition ?? '',
      vitalMass: vitalMass ?? "",
      vitalStatus: vitalStatus,
      vitalHeading: vitalHeading,
      vitalDescription: vitalDescription,
      isExpand: isExpand,
      expandedWidget: expandedWidget,
      onTop: () {
        AppNavigation.to(
          AppRoutes.vitalDescriptions,
          arguments: {"vitalKey": vitalKey},
        );
      },
      onInfoTop: () {},
    );
  }
}
