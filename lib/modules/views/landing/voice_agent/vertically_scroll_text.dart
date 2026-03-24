import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class VerticalAutoScroll extends StatefulWidget {
  final String text;

  const VerticalAutoScroll({super.key, required this.text});

  @override
  State<VerticalAutoScroll> createState() => _VerticalAutoScrollState();
}

class _VerticalAutoScrollState extends State<VerticalAutoScroll> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollAfterBuild();
  }

  @override
  void didUpdateWidget(covariant VerticalAutoScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _scrollAfterBuild();
    }
  }

  void _scrollAfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
  }

  void _autoScroll() {
    if (!_controller.hasClients) return;

    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 10),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: "Manrope",
          fontWeight: FontWeight.w600,
          fontSize: AppDimensions.font(18),
          color: AppColors.primary,
        ),
      ),
    );
  }
}
