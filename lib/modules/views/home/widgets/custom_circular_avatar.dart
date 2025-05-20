import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
    this.radius = 50.0,
    this.image = "",
    this.color = AppColors.primary,
    this.widget = const SizedBox(),
  });
  final double radius;
  final String image;
  final Color color;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: radius, // Size of the circle
        // backgroundImage:Image.memory(bytes), // Background color
        child: Center(child: widget),
      ),
    );
  }
}
