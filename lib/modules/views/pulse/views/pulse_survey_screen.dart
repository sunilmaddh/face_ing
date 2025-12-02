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
  final bool fromBottomNav;
  const PulseSurveyScreen({super.key, this.fromBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.historyCardColor,
      appBar: CustomAppBar(
        isCenterTitle: false,
        title: "Pulse Survey",
        isLeading: fromBottomNav,
        onTop: () => Get.back(),
      ),

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -1.0),
            fit: BoxFit.fitWidth,
            image: AssetImage(AppAssets.pulseScreen1),
          ),
        ),

        child: Column(
          children: [
            // TOP PART (Circle Center)
            Expanded(
              child: Center(
                child: CircleCardWidget(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 110,
                      child: Container(
                        margin: const EdgeInsets.all(17),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CommonText.text(
                          AppConstents.howDoYouFeelToday,
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // BUTTON
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: PrimaryButton(
                width: AppDimensions.width(243),
                text: "Start Pulse Survey",
                onPressed: () {
                  AppNavigation.to(AppRoutes.pulseProgressWidget);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
