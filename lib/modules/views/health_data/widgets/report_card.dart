import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key,this.width=143, required this.title,  this.value="",  this.mass="",  this.image="",  this.isCenter=false});
  final String title;
  final String value;
  final String mass;
  final String image;
  final double width;
  final bool isCenter ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.width(width),
      child: CommonCard(
        radius: AppDimensions.radius(18),
        widget: Padding(
        padding:  EdgeInsets.symmetric(horizontal: AppDimensions.width(20),vertical: AppDimensions.height(26)),
        child: Stack(
          children: [
            
            Column(
              crossAxisAlignment:isCenter==true?CrossAxisAlignment.center: CrossAxisAlignment.start,
              children: [
              CommonText.text(
                maxLines: 2,
                title,fontSize: AppDimensions.font(16),fontWeight: FontWeight.w600,color: AppColors.blackColor), 


              //  image.isNotEmpty?  Center(child: Padding(
              //      padding:  EdgeInsets.only(top: AppDimensions.height(20)),
              //      child: SvgPicture.asset(image,fit: BoxFit.cover,height: AppDimensions.height(154),),
              //    )):SizedBox(),
                 SizedBox(height: AppDimensions.height(20),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [
                  CommonText.text(value,fontSize: AppDimensions.font(24),fontWeight: FontWeight.w700,color: AppColors.primary),
                  CommonText.text(mass,fontSize: AppDimensions.font(14),fontWeight: FontWeight.w400,color: AppColors.blackColor),
              ],)
            ],),
          ],
        ),
      )
      ),
    );
  }
}