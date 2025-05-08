import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/widget/geust_user_history_card.dart';
import 'package:ntt_data/modules/views/profile/vitals_data_screen.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

// ignore: must_be_immutable
class GeustUserHistoryScreen extends StatefulWidget {
  GeustUserHistoryScreen({super.key});

  @override
  State<GeustUserHistoryScreen> createState() => _GeustUserHistoryScreenState();
}

class _GeustUserHistoryScreenState extends State<GeustUserHistoryScreen> {
  final _controller = Get.find<GeustController>();

  final _searchController = TextEditingController();

  List<Widget> tabWidgets = [
    Tab(text: "Vitals"),
    Tab(text: "Wellness"),
    Tab(text: "Additional"),
  ];

  List<Widget> tabBarWidgets = [VitalsDataScreen()];

  @override
  void initState() {
    _controller.getGeustHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedButton(
        onPressed: () {
          AppNavigation.to(AppRoutes.addNewGeustScreen);
        },
        isAdd: true,
        isAppBar: false,
        size: AppDimensions.height(58),
      ),
      appBar: CustomAppBar(title: "Geust user"),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.padding(15)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomFormField(
                prefixIcon: Icon(Icons.search, color: AppColors.searchColor),
                label: "",
                hint: "Type to search",
                controller: _searchController,
              ),
              SizedBox(height: 20),

              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.guestList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (contex, index) {
                    var result = _controller.guestList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GeustUserHistoryCard(
                        gender: result.gender.toString(),
                        name: result.name.toString(),
                        height: result.height.toString(),
                        weight: result.weight.toString(),
                        time: result.date.toString(),
                        onTop: () {
                          _controller.getGeustDetails(
                            result.guestId.toString(),
                          );
                        },
                        onDelete: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
