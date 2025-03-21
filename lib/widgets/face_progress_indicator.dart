import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class FaceProgressIndicator extends StatelessWidget {
 const  FaceProgressIndicator({super.key, required this.pages,required this.valueCurrentIndex,this.isLarge=false});
   final ValueNotifier<int> valueCurrentIndex;
  final List<dynamic> pages;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder<int>(
            valueListenable: valueCurrentIndex,
            builder: (context, currentIndex, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => 
                  isLarge?AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width:  AppDimensions.width(64),
                    height: AppDimensions.height(5),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(8.0),
                      // shape: BoxShape.circle,
                      color: currentIndex == index ? AppColors.primary : AppColors.progressColorDeactive,
                    ),
                  ): AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width:  AppDimensions.width(23),
                    height: AppDimensions.height(6),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(8.0),
                      // shape: BoxShape.circle,
                      color: currentIndex == index ? AppColors.primary : AppColors.progressColorDeactive,
                    ),
                  ),
                ),
              );
            },
          );
  }
}