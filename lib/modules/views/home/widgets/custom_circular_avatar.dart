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
    final hasImage = image.isNotEmpty;
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
      backgroundImage: hasImage ? NetworkImage(image) : null,
      child:
          hasImage ? null : widget, // Show fallback widget (like initial text)
    );
  }
}
