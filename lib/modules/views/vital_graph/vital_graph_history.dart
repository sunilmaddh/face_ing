import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/vital_graph_first_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class VitalGraphHistory extends StatelessWidget {
  VitalGraphHistory({super.key});

  final _vitalGraphController = Get.find<VitalGraphController>();
  String gusetId = Get.arguments["guestId"] ?? "";

  List<String> filterType = ["Today", "Weakly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: AppDimensions.height(95),
        // color: Colors.amber,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              // ✅ Center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // ✅ Center horizontally
              children: List.generate(filterType.length, (index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      _vitalGraphController.selectedIndex.value = index;
                    },
                    child: Padding(
                      padding: AppDimensions.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: CommonText.text(
                        filterType[index],
                        fontFamily: "Manrope",
                        fontSize: AppDimensions.font(20.0),
                        color:
                            _vitalGraphController.selectedIndex == index
                                ? AppColors.primary
                                : Color(0xffE0E0E0),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                // ✅ Center vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // ✅ Center horizontally
                children: List.generate(filterType.length, (index) {
                  return Container(
                    margin: AppDimensions.symmetric(horizontal: 3.0),
                    height: AppDimensions.height(10),
                    width: AppDimensions.width(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _vitalGraphController.selectedIndex == index
                              ? AppColors.primary
                              : Color(0xffE0E0E0),
                      // borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),

      appBar: CustomAppBar(
        onTop: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigation.back();
          });
        },
        title: "History",
      ),
      backgroundColor: AppColors.btntext,
      body: Padding(
        padding: AppDimensions.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   padding: AppDimensions.symmetric(vertical: 20),
            //   color: AppColors.btntext,
            //   child: FirstLineVitalWidget(guestId: gusetId),
            // ),
            Obx(
              () =>
                  _vitalGraphController.isLoading.isTrue
                      ? CircularProgressIndicator()
                      : _vitalGraphController
                              .vitalGraphResponse
                              .value
                              .wellness !=
                          null
                      ? VitalGraphFirstCard()
                      : Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.noMeasurementTaken),
                            10.verticalSpace,
                            CommonText.text(
                              "No Measurements were taken during this period",
                            ),
                          ],
                        ),
                      ),
            ),
            // 30.verticalSpace,

            // Obx(
            //   () => Visibility(
            //     visible:
            //         _vitalGraphController.vitalGraphResponse.value.dateRange !=
            //         null,

            //     child: Padding(
            //       padding: AppDimensions.symmetric(horizontal: 10),
            //       child: SizedBox(
            //         width: MediaQuery.of(context).size.width,
            //         child: CommonCard(
            //           widget: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: CommonText.text(
            //               textAlign: TextAlign.center,
            //               fontFamily: AppTextStyles.fontFamilyGilroy,
            //               fontSize: AppDimensions.font(13),
            //               fontWeight: FontWeight.w700,
            //               _vitalGraphController
            //                   .vitalGraphResponse
            //                   .value
            //                   .dateRange
            //                   .toString(),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
