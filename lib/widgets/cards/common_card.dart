import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({super.key,  this.color=AppColors.btntext, required this.widget,  this.padding=8.0,  this.radius=8.0});

  final Color color;
  final Widget widget;
  final double padding;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius)),
            child: widget);
  }
}