import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    super.key,
    required this.tabWidgets,
    required this.tabBarWidgets,
    this.isNotRadius = false,
    this.tabController,
    this.onTabChanged, // 👈 new callback
  });

  final List<Widget> tabWidgets;
  final List<Widget> tabBarWidgets;
  final bool isNotRadius;
  final TabController? tabController;
  final ValueChanged<int>? onTabChanged; // 👈 callback for tab index change

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with SingleTickerProviderStateMixin {
  TabController? _internalController;

  TabController get _controller =>
      widget.tabController ?? _internalController!; // unified controller

  @override
  void initState() {
    super.initState();

    // Create internal controller only if external one not given
    if (widget.tabController == null) {
      _internalController = TabController(
        length: widget.tabWidgets.length,
        vsync: this,
      );
    }

    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        widget.onTabChanged?.call(_controller.index);
      }
    });
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Tab Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.btntext,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TabBar(
              controller: _controller,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: TextStyle(
                fontSize: AppDimensions.font(16),
                fontWeight: FontWeight.w400,
                fontFamily: "Gilroy-Medium",
              ),
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              labelColor: AppColors.btntext,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator:
                  widget.isNotRadius
                      ? const BoxDecoration()
                      : BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
              tabs:
                  widget.tabWidgets.map((tab) {
                    return Tab(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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

          SizedBox(height: AppDimensions.height(20)),

          // 🔹 Tab View
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: widget.tabBarWidgets,
            ),
          ),
        ],
      ),
    );
  }
}
