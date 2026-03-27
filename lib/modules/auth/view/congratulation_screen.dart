import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/api_constants.dart';
import 'package:ntt_data/core/constants/app_strings.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PrimaryButton(
        text: "Thank you",
        onPressed: () {
          AppNavigation.to(AppRoutes.landingSceen);
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonAssets.svgAsset(
                AppAssets.tickCircle,
                height: AppDimensions.height(104),
                width: AppDimensions.width(104),
              ),
              SizedBox(height: AppDimensions.height(70)),
              CommonText.text(
                AppStrings.congratsText,
                textAlign: TextAlign.center,
                maxLines: 2,
                fontSize: AppDimensions.font(22),
                fontWeight: FontWeight.w600,
                color: AppColors.conTitle,
              ),
              SizedBox(height: AppDimensions.height(20)),
              CommonText.text(
                AppStrings.congratsDescription,
                textAlign: TextAlign.center,
                maxLines: 3,
                fontSize: AppDimensions.font(20),
                fontWeight: FontWeight.w400,
                color: AppColors.conDiscription,
              ),
              SizedBox(height: AppDimensions.height(20)),
            ],
          ),
        ),
      ),
    );
  }
}
