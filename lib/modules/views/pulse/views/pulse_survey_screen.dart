import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/home/widgets/circle_card_widget.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseSurveyScreen extends StatelessWidget {
  const PulseSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PrimaryButton(
        width: AppDimensions.width(243),
        text: "Start Pulse Survey",
        onPressed: () {
          AppNavigation.to(AppRoutes.pulseProgressWidget);
        },
      ),
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Pulse Survey",
        onTop: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppAssets.pulseScreen),
            ),
          ),
          child: Stack(
            children: [
              CircleCardWidget(
                widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 200,
                    child: Container(
                      margin: AppDimensions.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.btntext,
                        shape: BoxShape.circle,
                      ),
                      child: CommonText.text(
                        AppConstents.howDoYouFeelToday,
                        color: AppColors.primary,
                        fontSize: AppDimensions.font(20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
