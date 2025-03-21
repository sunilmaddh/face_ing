import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class DynamicCard extends StatelessWidget {
  final Color color;
  final double elevation;
  final double radius;
  final double margin;
  final Widget widget;
  const DynamicCard({super.key,  this.color=AppColors.primary, this.elevation=4.0,  this.radius=8.0,  this.margin=8.0, required this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),    
      margin: EdgeInsets.all(margin),
      child: widget
    );
  }
}