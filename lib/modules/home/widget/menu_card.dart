import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.menuTitle, required this.image});
  final String menuTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      color: AppColors.homeCardColor,
      widget: InkWell(
        child: SizedBox(
          height: AppDimensions.height(149),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, fit: BoxFit.fitWidth),

              10.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppDimensions.height(12.0),
                    width: AppDimensions.width(12.0),
                    child: SvgPicture.asset(AppAssets.correct),
                  ),
                  5.horizontalSpace,
                  CommonText.labelLarge(
                    menuTitle,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
