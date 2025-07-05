import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  final String image;
  final Widget widget;
  final double radius;

  const CustomCircularAvatar({
    super.key,
    required this.image,
    required this.widget,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = image.isNotEmpty;

    return CircleAvatar(
      radius: radius,

      backgroundImage: hasImage ? NetworkImage(image) : null,
      child:
          hasImage ? null : widget, // Show fallback widget (like initial text)
    );
  }
}
