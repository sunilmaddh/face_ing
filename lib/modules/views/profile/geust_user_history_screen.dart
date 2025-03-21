import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/profile_controller.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/modules/views/home/widgets/custom_circular_avatar.dart';
import 'package:ntt_data/modules/views/profile/vitals_data_screen.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

class GeustUserHistoryScreen extends StatelessWidget {
   GeustUserHistoryScreen({super.key});
   final _profileController=Get.find<ProfileController>();
final _searchController=TextEditingController();
 List<Widget> tabWidgets=[
                  Tab(text: "Vitals"),
                  Tab(text: "Wellness"),
                  Tab(text: "Additional"),];

List<Widget> tabBarWidgets=[VitalsDataScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:RoundedButton(onPressed: (){
        AppNavigation.to(AppRoutes.addNewGeustScreen);
      },isAdd: true,isAppBar: false,size: AppDimensions.height(58),),
      appBar: CustomAppBar(title: "Geust user"),body: Padding(
        padding:  EdgeInsets.all(AppDimensions.padding(15)),
        child: Column(children: [
          CustomFormField(prefixIcon: Icon(Icons.search,color: AppColors.searchColor), label: "", hint: "Type to search", controller: _searchController),
SizedBox(height: 20,),
          CommonCard(
            
            radius: AppDimensions.radius(16),
            widget: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppDimensions.width(15),vertical: AppDimensions.height(20)),
            child: SizedBox(height: 300,width: MediaQuery.of(context).size.width,child: Column(children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                CustomCircularAvatar(radius: AppDimensions.padding(24.0),),
                 SizedBox(height: 10,),
                CommonText.text("Riya Bhaumik",fontSize: AppDimensions.font(16),fontWeight: FontWeight.w700)
              ],),Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [              InkWell(
                  onTap: (){
                    _profileController.showDeleteUserDialog(context, (){});
                  },
                  child: CustomCircularAvatar(
                    widget: Icon(Icons.close),color: AppColors.btntext,
                    radius: AppDimensions.padding(20.0),),
                ),
                  SizedBox(height: 15,),
                  CommonText.text("Riya Bhaumik",fontSize: AppDimensions.font(16),fontWeight: FontWeight.w700)
            ],)],),
            SizedBox(height: AppDimensions.height(5),),
            CommonCard(widget: SizedBox(width:  MediaQuery.of(context).size.width,height: 200,child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppDimensions.padding(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        children: [
                          InkWell(
                            onTap: (){
                              CustomBottomSheet.show(
                              
                                title: "19 March, 2025", content: SizedBox(height: 500,width: MediaQuery.of(context).size.width,child: CustomTabBarView(tabWidgets: tabWidgets,tabBarWidgets: tabBarWidgets,),));
                            },
                            child: CommonText.text("View history",color: AppColors.primary,fontWeight: FontWeight.w600,fontSize: AppDimensions.font(14),decoration: TextDecoration.underline)),
                         CommonAssets.svgAsset(AppAssets.share)
                        ],
                      ),
                     
                  ],
                ),
              )
            ],)))
            ],),),
          ),
          color:AppColors.historyCardColor,),
        ],),
      ),);
  }
}