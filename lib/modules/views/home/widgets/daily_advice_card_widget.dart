import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/home/widgets/circle_card_widget.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class DailyAdviceCardWidget extends StatelessWidget {
  const DailyAdviceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      widget: Container(
        margin: AppDimensions.symmetric(vertical: 15, horizontal: 15),
        alignment: Alignment.center,
        padding: AppDimensions.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.dailyAd),
            fit: BoxFit.fill,
          ),
        ),

        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText.text(
                    "Daily Advice",
                    fontWeight: FontWeight.w800,
                    fontSize: AppDimensions.font(16),
                    color: AppColors.btntext,
                  ),
                  8.verticalSpace,
                  SizedBox(
                    width: AppDimensions.width(180),
                    child: CommonText.text(
                      "Personalized insights for your day.",
                      fontSize: 10,
                      color: AppColors.btntext,
                      maxLines: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              CircleCardWidget(
                size: 30,
                widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAssets.aiAdivice,
                    height: AppDimensions.height(30),
                    width: AppDimensions.width(30),
                    color: AppColors.bottomTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
