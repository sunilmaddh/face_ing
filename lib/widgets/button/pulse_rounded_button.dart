import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class PulseRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final bool isEnable;
  final bool isSubmit;

  const PulseRoundedButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.circleColor,
    this.size = 50.0,
    this.isEnable = true,
    required this.isSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: isEnable ? onPressed : null,
        style:
            isEnable == false
                ? ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.checkBoxBorderColor,
                  elevation: 0,
                )
                : ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
        child:
            isSubmit == true
                ? CommonText.text("Save", color: AppColors.btntext)
                : Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
