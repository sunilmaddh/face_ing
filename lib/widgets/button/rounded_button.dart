import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final bool isAppBar;
  final bool isAdd;
  
  const RoundedButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.circleColor,
    this.size = 50.0,
    this.isAppBar=true,
    this.isAdd=false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style:isAppBar? ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: color,
          elevation: 0,
        ): ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
        child: isAppBar? SvgPicture.asset(AppAssets.back):isAdd==true?Icon(Icons.add,color: Colors.white):Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
