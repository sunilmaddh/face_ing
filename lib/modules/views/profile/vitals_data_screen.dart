import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class VitalsDataScreen extends StatelessWidget {
  const VitalsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          
          Padding(
            padding:  EdgeInsets.symmetric(vertical: AppDimensions.height(10.0)),
            child: CommonCard(
                        
                        widget: SizedBox(width:  MediaQuery.of(context).size.width,height: 40,child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Measurement taken at',
                              style: TextStyle(fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500), // Default style
                              children: [
                                TextSpan(
                                  text: ' 10:17 AM',
                                  style: TextStyle(fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w700),
                                ),
                               
                              ],
                            ),
                          ),
                        ),),color: AppColors.measurmentTakenCardColor,),
          ),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [CommonText.text("Weight",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500),
                        CommonText.text("50KG",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500)],),
                        SizedBox(height: AppDimensions.height(10),),
                        Divider(height: 1,color: AppColors.deviderColor,),
                         SizedBox(height: AppDimensions.height(10),),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [CommonText.text("Height",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500),
                        CommonText.text("150CM",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500)],),
                        SizedBox(height: AppDimensions.height(10),),
                        Divider(height: 1,color: AppColors.deviderColor,),
                         SizedBox(height: AppDimensions.height(10),),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [CommonText.text("Weight",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500),
                        CommonText.text("50KG",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500)],),
                        SizedBox(height: AppDimensions.height(10),),
                        Divider(height: 1,color: AppColors.deviderColor,),
                         SizedBox(height: AppDimensions.height(10),),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [CommonText.text("Height",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500),
                        CommonText.text("150CM",fontSize: AppDimensions.font(14), color: Colors.black,fontWeight: FontWeight.w500)],),
                        SizedBox(height: AppDimensions.height(10),),
                        Divider(height: 1,color: AppColors.deviderColor,),
                         SizedBox(height: AppDimensions.height(10),),
        ],),
      ),
    );
  }
}