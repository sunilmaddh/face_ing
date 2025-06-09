import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    super.key,
    required this.tabWidgets,
    required this.tabBarWidgets,
  });
  final List<Widget> tabWidgets;
  final List<Widget> tabBarWidgets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: DefaultTabController(
        length: 7, // Number of tabs
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.tabBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: AppDimensions.font(16),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Gilroy-Medium",
                ),
                labelPadding: EdgeInsets.zero, // Removes internal gap
                dividerColor: Colors.transparent,
                labelColor: AppColors.btntext,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                tabs:
                    tabWidgets.map((tab) {
                      return Tab(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                          ), // Your custom spacing
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.width(16),
                            vertical: AppDimensions.height(8),
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
            Expanded(child: TabBarView(children: tabBarWidgets)),
          ],
        ),
      ),
    );
  }
}
