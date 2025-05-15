import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    this.width = 143,
    this.height = 160,
    required this.title,
    this.value = "",
    this.valueCenter = "",
    this.mass = "",
    this.image = "",
    this.leftPadding = 0.0,
    this.isHeartRate = false,
    this.isCenter = false,
    this.bigImage = "",
    this.backgroundImage = "",
    this.isTextOnly = false,
    this.centerImage = "",
  });
  final String title;
  final String value;
  final String valueCenter;
  final String mass;
  final String image;
  final bool isTextOnly;
  final bool isHeartRate;
  final double leftPadding;
  final double width;
  final double height;
  final bool isCenter;
  final String centerImage;
  final String backgroundImage;
  final String bigImage;
  @override
  Widget build(BuildContext context) {
    Color textColor =
        value.toUpperCase() == "HIGH"
            ? Colors.orange
            : value.toUpperCase() == "LOW"
            ? Colors.red
            : value.toUpperCase() == "MEDIUM"
            ? Colors.green
            : AppColors.primary;
    return CommonCard(
      radius: AppDimensions.radius(18),
      widget: SizedBox(
        // width: AppDimensions.width(width),
        height: AppDimensions.height(height),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.height(10),
            vertical: AppDimensions.height(10),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(Icons.info_outline),
                    ),
                  ),
                  CommonText.text(
                    maxLines: 4,
                    title,
                    fontSize: AppDimensions.font(16),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.height(60)),

              ///This is for when no imaage
              if (isTextOnly == true)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText.text(
                        value,
                        fontSize: AppDimensions.font(24),
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                      CommonText.text(
                        mass,
                        fontSize: AppDimensions.font(14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),

              ///This is for imaage with center text
              if (backgroundImage.isNotEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(backgroundImage),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonText.text(
                          value,
                          fontSize: AppDimensions.font(24),
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (image.isNotEmpty)
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  width: AppDimensions.width(width),
                  height: 320,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(image, fit: BoxFit.contain),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: value,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),

                            TextSpan(
                              text: " $mass", // Replace with appropriate unit
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ///This is for title, image and value in column
              if (centerImage.isNotEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 34,
                        child: SvgPicture.asset(centerImage),
                      ),
                      SizedBox(height: 10),
                      CommonText.text(
                        value,
                        fontSize: AppDimensions.font(24),
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                      CommonText.text(
                        mass,
                        fontSize: AppDimensions.font(14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),

              // if (centerImage.isNotEmpty)
              //   Stack(
              //     children: [
              //       SvgPicture.asset(centerImage),
              //       Positioned(
              //         bottom: 20,
              //         left: AppDimensions.height(leftPadding),
              //         child: CommonText.text(
              //           valueCenter,
              //           fontSize: AppDimensions.font(14),
              //           fontWeight: FontWeight.w400,
              //           color: AppColors.blackColor,
              //         ),
              //       ),
              //     ],
              //   ),
              SizedBox(height: AppDimensions.height(20)),
              // if (image.isEmpty && leftPadding == 0.0)
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       CommonText.text(
              //         value,

              //         fontSize: AppDimensions.font(24),
              //         fontWeight: FontWeight.w700,
              //         color: AppColors.primary,
              //       ),
              //       CommonText.text(
              //         mass,
              //         fontSize: AppDimensions.font(14),
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.blackColor,
              //       ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),

      //   Stack(
      //     children: [
      //       Positioned(
      //         top: 0,
      //         right: 0,
      //         child: IconButton(
      //           padding: EdgeInsets.all(0),
      //           onPressed: () {},
      //           icon: Icon(Icons.info_outline),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.symmetric(
      //           horizontal: AppDimensions.height(10),
      //           vertical: AppDimensions.height(30),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             CommonText.text(
      //               maxLines: 4,
      //               title,
      //               fontSize: AppDimensions.font(16),
      //               fontWeight: FontWeight.w600,
      //               color: AppColors.blackColor,
      //             ),
      //             SizedBox(height: AppDimensions.height(10)),

      //             if (centerImage.isNotEmpty)
      //               Stack(
      //                 children: [
      //                   SvgPicture.asset(centerImage),
      //                   Positioned(
      //                     bottom: 20,
      //                     left: AppDimensions.height(leftPadding),
      //                     child: CommonText.text(
      //                       valueCenter,
      //                       fontSize: AppDimensions.font(14),
      //                       fontWeight: FontWeight.w400,
      //                       color: AppColors.blackColor,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             SizedBox(height: AppDimensions.height(20)),
      //             if (image.isEmpty && leftPadding == 0.0)
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   RichText(
      //                     text: TextSpan(
      //                       children: [
      //                         TextSpan(
      //                           text: value,
      //                           style: const TextStyle(
      //                             fontSize: 24,
      //                             fontWeight: FontWeight.w700,
      //                             color: AppColors.primary,
      //                           ),
      //                         ),

      //                         TextSpan(
      //                           text: " $mass", // Replace with appropriate unit
      //                           style: const TextStyle(
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w400,
      //                             color: AppColors.blackColor,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //           ],
      //         ),
      //       ),

      //       if (bigImage.isNotEmpty)
      //         Padding(
      //           padding: EdgeInsets.only(top: AppDimensions.height(140)),
      //           child: Positioned(
      //             bottom: 0,
      //             right: 0,
      //             left: 0,
      //             child: Expanded(
      //               child: SvgPicture.asset(
      //                 bigImage,
      //                 fit: BoxFit.fitWidth,
      //                 width: MediaQuery.of(context).size.width,
      //               ),
      //             ),
      //           ),
      //         ),

      //       // Positioned(
      //       //   bottom: 10,
      //       //   child: Padding(
      //       //     padding: EdgeInsets.symmetric(horizontal: 10),
      //       //     child: Column(
      //       //       crossAxisAlignment: CrossAxisAlignment.start,
      //       //       mainAxisSize: MainAxisSize.max,
      //       //       children: [
      //       //         CommonText.text(
      //       //           value,
      //       //           fontSize: AppDimensions.font(24),
      //       //           fontWeight: FontWeight.w700,
      //       //           color: AppColors.primary,
      //       //         ),
      //       //         CommonText.text(
      //       //           mass,
      //       //           fontSize: AppDimensions.font(14),
      //       //           fontWeight: FontWeight.w400,
      //       //           color: AppColors.blackColor,
      //       //         ),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //       if (image.isNotEmpty)
      //         Container(
      //           padding: EdgeInsets.only(top: 30, bottom: 15),
      //           width: AppDimensions.width(width),
      //           height: 320,
      //           alignment: Alignment.bottomCenter,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               SvgPicture.asset(image, fit: BoxFit.contain),

      //               RichText(
      //                 text: TextSpan(
      //                   children: [
      //                     TextSpan(
      //                       text: value,
      //                       style: const TextStyle(
      //                         fontSize: 24,
      //                         fontWeight: FontWeight.w700,
      //                         color: AppColors.primary,
      //                       ),
      //                     ),

      //                     TextSpan(
      //                       text: " $mass", // Replace with appropriate unit
      //                       style: const TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w400,
      //                         color: AppColors.blackColor,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               // Padding(
      //               //   padding: EdgeInsets.symmetric(horizontal: 10),
      //               //   child: CommonText.text(
      //               //     value,
      //               //     fontSize: AppDimensions.font(24),
      //               //     fontWeight: FontWeight.w700,
      //               //     color: AppColors.primary,
      //               //   ),
      //               // ),
      //               // Padding(
      //               //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //               //   child: CommonText.text(
      //               //     mass,
      //               //     fontSize: AppDimensions.font(14),
      //               //     fontWeight: FontWeight.w400,
      //               //     color: AppColors.blackColor,
      //               //   ),
      //               // ),
      //             ],
      //           ),
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
