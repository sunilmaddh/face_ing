import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class CircleCardWidget extends StatelessWidget {
  CircleCardWidget({super.key, required this.widget, this.size = 205});

  final Widget widget;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: AppDimensions.width(size),
      height: AppDimensions.height(size),
      decoration: BoxDecoration(
        color: AppColors.btntext,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xffE0E0E0).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: Color(0xff000000).withOpacity(0.1), blurRadius: 4.r),
        ],
      ),
      child: widget,
    );
  }
}
