

import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
class ScanButton extends StatelessWidget {
  
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final double width;

  const ScanButton({
    super.key,
   
    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = 16.0,
    this.width=128.0
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: AppDimensions.width(width),
        height: AppDimensions.height(50),
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(children: [
            CommonAssets.svgAsset(AppAssets.scan),
             Text(
            "Start face Scan",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          ],)
         
        ),
      ),
    );
  }
}
