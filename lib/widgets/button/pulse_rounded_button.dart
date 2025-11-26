import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class PulseRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final bool isEnable;
  final bool isSubmit;
  final bool isPrevious;

  const PulseRoundedButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.circleColor,
    this.size = 50.0,
    this.isEnable = true,
    this.isSubmit = false,
    this.isPrevious = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: isEnable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor:
              isEnable ? AppColors.primary : AppColors.checkBoxBorderColor,
          elevation: 0,
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isSubmit) {
      return const Text(
        "Save",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (isPrevious) {
      return const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
        size: 18,
      );
    } else {
      return Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18);
    }
  }
}
