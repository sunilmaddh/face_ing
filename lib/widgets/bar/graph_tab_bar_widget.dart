import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class GraphTabBarWidget extends StatelessWidget {
  GraphTabBarWidget({
    super.key,
    required this.tabWidgets,
    required this.tabBarWidgets,
    required this.isNotRadius,
  });
  final List<Widget> tabWidgets;
  final List<Widget> tabBarWidgets;
  bool isNotRadius = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: DefaultTabController(
        length: 7, // Number of tabs
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
              // alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.btntext,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start, // add this line
                padding: EdgeInsets.zero,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize:
                      isNotRadius
                          ? AppDimensions.font(12)
                          : AppDimensions.font(16),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Gilroy-Medium",
                ),
                labelPadding: EdgeInsets.zero, // Removes internal gap
                dividerColor: Colors.transparent,
                labelColor:
                    isNotRadius ? AppColors.primary : AppColors.blackColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.zero,
                indicator:
                    isNotRadius == false
                        ? BoxDecoration(
                          color: AppColors.historyCardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: AppColors.searchColor,
                          ),
                        )
                        : BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 3,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                tabs:
                    tabWidgets.map((tab) {
                      return Tab(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                          ), // Your custom spacing
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                isNotRadius ? 0 : AppDimensions.width(10),
                            // vertical: AppDimensions.height(8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(child: tab),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: AppDimensions.height(10)),
            isNotRadius == false
                ? Divider(
                  height: 2,
                  thickness: 4,
                  color: AppColors.historyCardColor,
                )
                : SizedBox.shrink(),

            // SizedBox(height: AppDimensions.height(20)),
            Expanded(child: TabBarView(children: tabBarWidgets)),
          ],
        ),
      ),
    );
  }
}
