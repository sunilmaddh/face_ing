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
  final isLoading;

  const ScanButton({
    super.key,

    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = 10.0,
    this.width = 128.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        alignment: Alignment.center,
        width: AppDimensions.width(width),
        height: AppDimensions.height(50),
        duration: const Duration(milliseconds: 200),
        // padding: EdgeInsets.symmetric(vertical: padding, horizontal: 12),
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
        child:
            isLoading
                ? const CircularProgressIndicator(color: AppColors.btntext)
                : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonAssets.svgAsset(AppAssets.scan),
                      Text(
                        "Start face Scan",
                        style: TextStyle(
                          color: textColor,
                          fontSize: AppDimensions.font(16),

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
