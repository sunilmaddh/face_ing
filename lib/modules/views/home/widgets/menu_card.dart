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
      widget: SizedBox(
        height: AppDimensions.height(133),
        width: AppDimensions.width(148),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, fit: BoxFit.fitWidth),

            // Container(
            //   decoration: BoxDecoration(
            //     color: AppColors.btntext,
            //     shape: BoxShape.circle,
            //     border: Border.all(color: Color(0xffE0E0E0).withOpacity(0.2)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color(0xff000000).withOpacity(0.1),
            //         blurRadius: 4,
            //       ),
            //     ],
            //   ),
            //   child: Image.asset(AppAssets.voiceScan, fit: BoxFit.fitWidth),
            // ),
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
                CommonText.text(
                  menuTitle,
                  fontFamily: "DM Sans",
                  fontSize: AppDimensions.font(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
