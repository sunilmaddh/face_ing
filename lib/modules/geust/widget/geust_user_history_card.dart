import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/dialog/common_dialog.dart';
import 'package:ntt_data/modules/home/widget/custom_circular_avatar.dart';
import 'package:ntt_data/modules/profile/helper/profile_helper.dart';
import 'package:ntt_data/widgets/button/primary_button.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/circular_image_with_shimmer.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class GeustUserHistoryCard extends StatelessWidget {
  GeustUserHistoryCard({
    super.key,
    required this.name,
    required this.height,
    required this.weight,
    required this.time,
    required this.gender,
    required this.onTop,
    required this.onDelete,
    required this.guestImage,
    required this.onReScan,
    required this.guestOptionList,
    required this.onOptionList,
  });

  final String name;
  final String height;
  final String weight;
  final String gender;
  final String guestImage;
  final String time;
  final VoidCallback onTop;
  final VoidCallback onDelete;
  final VoidCallback onReScan;
  final Function(String) onOptionList;
  String? newTime;
  String? date;
  final List<Map<String, String>> guestOptionList;

  @override
  Widget build(BuildContext context) {
    final result = ProfileHelper().extractDateAndTime(time);
    date = result['date'] ?? "";
    newTime = result['time'] ?? "";
    return CommonCard(
      radius: AppDimensions.radius(16),
      widget: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.width(15),
          vertical: AppDimensions.height(20),
        ),
        child: SizedBox(
          height: AppDimensions.height(322),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          guestImage.isNotEmpty
                              ? CircularImageWithShimmer(imageUrl: guestImage)
                              : CustomCircularAvatar(
                                color: AppColors.guestIconColor,
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
                          InkWell(
                            onTap: () {
                              CommonDialog().editGuestDialog(
                                guestOptionList: guestOptionList,
                                context: context,
                                onConfirm: (value) {
                                  onOptionList(value);
                                },
                                onCancel: () {},
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: AppDimensions.height(30),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.editButton,
                                height: AppDimensions.height(20),
                                width: AppDimensions.width(20),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          SizedBox(
                            width: AppDimensions.width(200),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                text: name,
                                style: TextStyle(
                                  fontSize: AppDimensions.font(14),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ), // Default style
                              ),
                            ),
                          ),
                          // RichText(
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 1,
                          //   text: TextSpan(
                          //     text:
                          //         gender.isNotEmpty
                          //             ? "(${gender.substring(0, 1).toUpperCase()})"
                          //             : "",
                          //     style: TextStyle(
                          //       fontSize: AppDimensions.font(14),
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w500,

                          //       // Default style
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      // SizedBox(
                      //   width: AppDimensions.width(100),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       SizedBox(
                      //         width: AppDimensions.width(120),
                      //         child: CommonText.text(
                      //           maxLines: 3,

                      //           name,
                      //           fontSize: AppDimensions.font(16),
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //       SizedBox(width: 5),
                      //       CommonText.text(
                      //         gender.isNotEmpty
                      //             ? "(${gender.substring(0, 1).toUpperCase()})"
                      //             : "",
                      //         fontSize: AppDimensions.font(16),
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          CommonDialog().showDeleteUserDialog(
                            context: context,
                            onConfirm: onDelete,
                            title: "Want to Remove the Guest?",
                            message:
                                "Are you sure you want to remove? This action cannot be undone",
                            confirmText: "Delete",
                          );
                        },
                        child: CustomCircularAvatar(
                          widget: Icon(
                            Icons.close,
                            color: AppColors.blackColor,
                          ),
                          color: AppColors.btntext,
                          radius: AppDimensions.padding(15.0),
                        ),
                      ),
                      SizedBox(height: AppDimensions.height(15)),
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
                  height: AppDimensions.height(205),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonCard(
                          widget: SizedBox(
                            width: MediaQuery.of(context).size.width,

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: "Profile Created on:",
                                    style: TextStyle(
                                      fontSize: AppDimensions.font(14),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), // Default style
                                    children: [
                                      TextSpan(
                                        text: " $date",
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

                                  child: CommonText.text(
                                    "View history",
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppDimensions.font(14),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.height(40),
                                  width: AppDimensions.width(115),
                                  child: PrimaryButton(
                                    text: "Rescan",
                                    onPressed: onReScan,
                                  ),
                                ),
                                // CommonAssets.svgAsset(AppAssets.share),
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
