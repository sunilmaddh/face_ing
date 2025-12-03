import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/first_line_vital_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/vital_graph_first_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';

// ignore: must_be_immutable
class VitalGraphHistory extends StatefulWidget {
  const VitalGraphHistory({super.key});

  @override
  State<VitalGraphHistory> createState() => _VitalGraphHistoryState();
}

class _VitalGraphHistoryState extends State<VitalGraphHistory> {
  final _vitalGraphController = Get.find<VitalGraphController>();

  String gusetId = Get.arguments["guestId"] ?? "";

  List<String> filterType = ["Weekly", "Monthly"];
  @override
  void initState() {
    callFunction();
    super.initState();
  }

  callFunction() {
    _vitalGraphController.isGraphFilterType.value = "Weekly";
    if (gusetId.isNotEmpty) {
      VitalGraphHelper().callForGuestWithFilter("7D", gusetId, true);
    } else {
      VitalGraphHelper().callForUserWithFilter("7D", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: AppDimensions.height(95),

        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(filterType.length, (index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      _vitalGraphController.selectedIndex.value = index;

                      if (filterType[index] == "Weekly") {
                        _vitalGraphController.isGraphFilterType.value =
                            "Weekly";
                        VitalGraphHelper().callForUserWithDateRange(
                          "7D",
                          _vitalGraphController.selectedDate.value ?? "",
                        );
                      } else {
                        _vitalGraphController.isGraphFilterType.value =
                            "Monthly";
                        VitalGraphHelper().callForUserWithDateRange(
                          "4W",
                          _vitalGraphController.selectedMonthDate.value ?? "",
                        );
                      }
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

                crossAxisAlignment: CrossAxisAlignment.center,
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
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  100, // adjust for padding/appbar
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: AppDimensions.symmetric(vertical: 20),
                    color: AppColors.btntext,
                    child: FirstLineVitalWidget(guestId: gusetId),
                  ),
                  Obx(() {
                    if (_vitalGraphController.isLoading.isTrue) {
                      return Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (_vitalGraphController
                            .vitalGraphResponse
                            .value
                            .wellness !=
                        null) {
                      return VitalGraphFirstCard(gusetId: gusetId);
                    } else {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppAssets.noMeasurementTaken),
                              10.verticalSpace,
                              CommonText.text(
                                "No Measurement Taken Period Selection",
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _vitalGraphController.isGraphFilterType.value = "";
    _vitalGraphController.selectedIndex.value = 0;
    _vitalGraphController.selectedDate.value = "";
    _vitalGraphController.selectedMonthDate.value = "";
    _vitalGraphController.selectedMonthIndex.value = DateTime.now().month - 1;

    super.dispose();
  }
}
