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
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
      child: DefaultTabController(
        length: tabWidgets.length, // Number of tabs
        child: Container(
          color: AppColors.btntext,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: AppDimensions.symmetric(horizontal: 15),
                // padding: EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
                // alignment: Alignment.centerLeft,
                decoration:
                    isNotRadius
                        ? BoxDecoration()
                        : BoxDecoration(
                          color: AppColors.btntext,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 1,
                            color: AppColors.historyCardColor,
                          ),
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
                  indicatorPadding: AppDimensions.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  indicator:
                      isNotRadius == false
                          ? BoxDecoration(
                            color: AppColors.historyCardColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 1,
                              color: AppColors.historyCardColor,
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

              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: tabBarWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
