import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor, surfaceTintColor;
  final Widget? leading;
  final bool isCenterTitle;
  final Color textColor;
  final VoidCallback onTop;
  final bool isLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.primary,
    this.leading,
    this.isLeading = true,

    required this.onTop,
    this.isCenterTitle = true,
    this.surfaceTintColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: surfaceTintColor,
      leading:
          isLeading
              ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RoundedButton(onPressed: onTop),
              )
              : SizedBox.shrink(),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: textColor,
          fontFamily: "Manrope",
          fontSize: AppDimensions.font(18),
        ),
      ),
      centerTitle: isCenterTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
