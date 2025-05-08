import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/common_assets.dart';
import 'package:ntt_data/core/utils/common_dialog.dart';
import 'package:ntt_data/modules/views/home/widgets/custom_circular_avatar.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class GeustUserHistoryCard extends StatelessWidget {
  const GeustUserHistoryCard({
    super.key,
    required this.name,
    required this.height,
    required this.weight,
    required this.time,
    required this.gender,
    required this.onTop,
    required this.onDelete,
  });

  final String name;
  final String height;
  final String weight;
  final String gender;
  final String time;
  final VoidCallback onTop;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: AppDimensions.radius(16),
      widget: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.width(15),
          vertical: AppDimensions.height(20),
        ),
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCircularAvatar(
                        widget: CommonText.text(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          name.isNotEmpty
                              ? name.substring(0, 1).toUpperCase()
                              : "",
                          color: AppColors.btntext,
                        ),
                        radius: AppDimensions.padding(24.0),
                      ),
                      SizedBox(height: 10),
                      CommonText.text(
                        name,
                        fontSize: AppDimensions.font(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          CommonDialog().showDeleteUserDialog(
                            context: context,
                            onConfirm: () {},
                          );
                        },
                        child: CustomCircularAvatar(
                          widget: Icon(Icons.close),
                          color: AppColors.btntext,
                          radius: AppDimensions.padding(20.0),
                        ),
                      ),
                      SizedBox(height: 15),
                      CommonText.text(
                        gender,
                        fontSize: AppDimensions.font(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.height(5)),
              CommonCard(
                widget: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonCard(
                          widget: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Measurement taken at',
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(14),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ), // Default style
                                  children: [
                                    TextSpan(
                                      text: ' $time',
                                      style: TextStyle(
                                        fontSize: AppDimensions.font(14),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          color: AppColors.measurmentTakenCardColor,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.padding(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText.text(
                                  "Weight",
                                  fontSize: AppDimensions.font(14),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                CommonText.text(
                                  "$weight KG",
                                  fontSize: AppDimensions.font(14),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.height(10)),
                            Divider(height: 1, color: AppColors.deviderColor),
                            SizedBox(height: AppDimensions.height(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText.text(
                                  "Height",
                                  fontSize: AppDimensions.font(14),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                CommonText.text(
                                  "$height cm",
                                  fontSize: AppDimensions.font(14),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.height(10)),
                            Divider(height: 1, color: AppColors.deviderColor),
                            SizedBox(height: AppDimensions.height(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: onTop,
                                  // onTap: () {
                                  //   CustomBottomSheet.show(
                                  //     title: "19 March, 2025",
                                  //     content: SizedBox(
                                  //       height: 500,
                                  //       width:
                                  //           MediaQuery.of(
                                  //             context,
                                  //           ).size.width,
                                  //       child: CustomTabBarView(
                                  //         tabWidgets: tabWidgets,
                                  //         tabBarWidgets: tabBarWidgets,
                                  //       ),
                                  //     ),
                                  //   );
                                  // },
                                  child: CommonText.text(
                                    "View history",
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.font(14),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                CommonAssets.svgAsset(AppAssets.share),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      color: AppColors.historyCardColor,
    );
  }
}
