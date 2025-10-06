import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/profile/helper/profile_helper.dart';
import 'package:ntt_data/widgets/cards/common_card.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class UserHistoryCard extends StatelessWidget {
  UserHistoryCard({super.key, required this.scanId, required this.dateTime});
  final String scanId;
  final String dateTime;
  String? time;
  String? date;

  @override
  Widget build(BuildContext context) {
    final result = ProfileHelper().extractDateAndTime(dateTime);
    date = result['date'] ?? "";
    time = result['time'] ?? "";
    return CommonCard(
      radius: AppDimensions.radius(16),
      widget: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.width(15),
          vertical: AppDimensions.height(20),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText.text(
                    "Date: ",
                    fontSize: AppDimensions.font(14),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Manrope",
                  ),
                  CommonText.text(
                    date.toString(),
                    fontSize: AppDimensions.font(16),
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Manrope",
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.height(5)),
              CommonCard(
                widget: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CommonCard(
                          widget: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Measurement taken at: ',
                                  style: TextStyle(
                                    fontSize: AppDimensions.font(14),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Manrope",
                                  ), // Default style
                                  children: [
                                    TextSpan(
                                      text: time,
                                      style: TextStyle(
                                        fontSize: AppDimensions.font(16),
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Manrope",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          color: AppColors.measurmentTakenCardColor,
                        ),
                        SizedBox(height: AppDimensions.height(10.0)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText.text(
                              "Scan Id: ",
                              fontSize: AppDimensions.font(14),
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Manrope",
                            ),
                            CommonText.text(
                              scanId,
                              fontSize: AppDimensions.font(14),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Manrope",
                            ),
                          ],
                        ),
                      ],
                    ),
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
