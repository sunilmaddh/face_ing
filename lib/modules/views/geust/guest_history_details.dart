import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/dialog/bottomsheet_helper.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bar/custom_tab_bar_view.dart';
import 'package:ntt_data/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/fields/common_text.dart';
import 'package:ntt_data/widgets/indo_sakura_common_card.dart';

// ignore: must_be_immutable
class GuestHistoryDetails extends StatefulWidget {
  const GuestHistoryDetails({super.key});

  @override
  State<GuestHistoryDetails> createState() => _GuestHistoryDetailsState();
}

class _GuestHistoryDetailsState extends State<GuestHistoryDetails>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<GeustController>();
  late TabController _tabController;
  List<Widget> tabWidget = [];

  @override
  void initState() {
    super.initState();

    // total tab count based on your AppMethods.tabGuestWidget
    _tabController = TabController(
      length: AppMethods.tabGuestWidget.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabWidget = [
      BuildCardWidget(
        healthDetailsList: _controller.basicVitalSigns,
        isBasicVital: true.obs,
      ),
      BuildCardWidget(
        healthDetailsList: _controller.bloodlessBloodTests,
        isBasicVital: false.obs,
      ),
      BuildCardWidget(
        healthDetailsList: _controller.risks,
        isBasicVital: false.obs,
      ),
      BuildCardWidget(
        healthDetailsList: _controller.stress,
        isBasicVital: false.obs,
      ),
      BuildCardWidget(
        healthDetailsList: _controller.heartRateVariability,
        isBasicVital: false.obs,
      ),
      BuildCardWidget(
        healthDetailsList: _controller.advancedHeartRateVariability,
        isBasicVital: false.obs,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onTop: () => AppNavigation.back(),
        title: "Guest Health Reports",
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.historyCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomTabBarView(
          tabController: _tabController,
          isNotRadius: false,
          tabWidgets: AppMethods.tabGuestWidget,
          tabBarWidgets: tabWidget,
          onTabChanged: (value) {
            if (value > 0) {
              BottomsheetHelper.showBottomSheetAlert(context, _tabController);
            }
          }, // 👈 pass it here if supported
        ),
      ),
    );
  }
}

class BuildCardWidget extends StatelessWidget {
  const BuildCardWidget({
    super.key,
    required this.healthDetailsList,
    required this.isBasicVital,
  });
  final RxList<HealthDetailList> healthDetailsList;
  final RxBool isBasicVital;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (healthDetailsList.isEmpty) {
        return Center(
          child: CommonText.text("You can view all results after registering."),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: healthDetailsList.length,
        itemBuilder: (context, index) {
          var result = healthDetailsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child:
                isBasicVital.isTrue
                    ? IndoSakuraCommonCard(
                      confidenceLevel: result.vitalConfidence.toString(),
                      isSdkType: true,
                      isLowGood: stringToBool(result.isTypeVital!),
                      vitalName: result.vitalName!,
                      vitalCondition: result.vitalRange!,
                      vitalDescription: result.vitalDescription!,
                      vitalStatus: result.vitalStatus!,
                      vitalValue: result.vitalValue!,
                      vitalHeading: result.vitalHeading!,
                      vitalMass: result.vitalUnit!,
                      vitalSubList: result.vitalSubList!,
                      onInfoTop: () {
                        AppNavigation.to(
                          AppRoutes.vitalDescriptions,
                          arguments: {"vitalKey": result.vitalKey},
                        );
                      },
                    )
                    : IndoSakuraCommonCard(
                      confidenceLevel: "",
                      isSdkType: true,
                      isLowGood: false,
                      vitalName: result.vitalName!,
                      vitalCondition: result.vitalRange!,
                      vitalDescription: result.vitalDescription!,
                      vitalStatus: "",
                      vitalValue: "",
                      vitalHeading: "",
                      vitalMass: "",
                      vitalSubList: [],
                      onInfoTop: () {},
                    ),
          );
        },
      );
    });
  }

  bool stringToBool(String value) => value.toLowerCase() == 'true';
}
