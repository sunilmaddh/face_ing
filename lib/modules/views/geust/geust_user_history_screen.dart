import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/constants/app_colors.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/widget/geust_user_history_card.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';
import 'package:ntt_data/widgets/fields/custom_form_field.dart';

// ignore: must_be_immutable
class GeustUserHistoryScreen extends StatefulWidget {
  const GeustUserHistoryScreen({super.key});

  @override
  State<GeustUserHistoryScreen> createState() => _GeustUserHistoryScreenState();
}

class _GeustUserHistoryScreenState extends State<GeustUserHistoryScreen> {
  final _controller = Get.find<GeustController>();
  final _searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getGeustHistory();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoundedButton(
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _controller.clearData();
            AppNavigation.to(
              AppRoutes.addNewGeustScreen,
              action: () {
                _controller.getGeustHistory();
              },
            );
          });
        },
        isAdd: true,
        isAppBar: false,
        size: AppDimensions.height(58),
      ),
      appBar: CustomAppBar(
        onTop: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigation.back();
          });
        },
        title: "Guest History",
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.padding(15)),
        child: Obx(
          () =>
              _controller.isLoading.isTrue
                  ? ShimmerLoadingScreen()
                  : _controller.guestList.isEmpty
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        AppAssets.noDataImage,
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                  : ListView(
                    children: [
                      // CustomFormField(
                      //   prefixIcon: Icon(Icons.search, color: AppColors.searchColor),
                      //   label: "",
                      //   hint: "Type to search",
                      //   controller: _searchController,
                      //   onChanged: (query) {
                      //     // _controller.search(query!);
                      //   },
                      // ),
                      // SizedBox(height: 20),

                      // _controller.filteredItems.isNotEmpty
                      //     ? ListView.builder(
                      //       reverse: true,
                      //       shrinkWrap: true,
                      //       itemCount: _controller.filteredItems.length,
                      //       physics: NeverScrollableScrollPhysics(),
                      //       itemBuilder: (contex, index) {
                      //         var result = _controller.filteredItems[index];
                      //         return Padding(
                      //           padding: const EdgeInsets.only(bottom: 10),
                      //           child: GeustUserHistoryCard(
                      //             gender: result.gender.toString(),
                      //             name: result.name.toString(),
                      //             height: result.height.toString(),
                      //             weight: result.weight.toString(),
                      //             time: result.date.toString(),
                      //             onTop: () {
                      //               _controller.getGeustDetails(
                      //                 result.guestId.toString(),
                      //               );
                      //             },
                      //             onDelete: () {
                      //               _controller.removeGuest(
                      //                 guestId: result.guestId,
                      //               );
                      //             },
                      //           ),
                      //         );
                      //       },
                      //     )
                      // :
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _controller.guestList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (contex, index) {
                          var result = _controller.guestList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: GeustUserHistoryCard(
                              guestImage: result.guestImage.toString(),
                              gender: result.gender.toString(),
                              name: result.name.toString(),
                              height: result.height.toString(),
                              weight: result.weight.toString(),
                              time: result.date.toString(),
                              onTop: () {
                                _controller.getGeustDetails(
                                  result.guestId.toString(),
                                  false,
                                );
                              },
                              onDelete: () {
                                _controller.removeGuest(
                                  guestId: result.guestId,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],

                    //   Obx(
                    //     () =>
                    //         _controller.guestList.isNotEmpty
                    //             ? ListView.builder(
                    //               shrinkWrap: true,
                    //               itemCount: _controller.guestList.length,
                    //               physics: NeverScrollableScrollPhysics(),
                    //               itemBuilder: (contex, index) {
                    //                 var result = _controller.guestList[index];
                    //                 return Padding(
                    //                   padding: const EdgeInsets.only(bottom: 10),
                    //                   child: GeustUserHistoryCard(
                    //                     gender: result.gender.toString(),
                    //                     name: result.name.toString(),
                    //                     height: result.height.toString(),
                    //                     weight: result.weight.toString(),
                    //                     time: result.date.toString(),
                    //                     onTop: () {
                    //                       _controller.getGeustDetails(
                    //                         result.guestId.toString(),
                    //                       );
                    //                     },
                    //                     onDelete: () {
                    //                       _controller.removeGuest(
                    //                         guestId: result.guestId,
                    //                       );
                    //                     },
                    //                   ),
                    //                 );
                    //               },
                    //             )
                    //             : ShimmerLoadingScreen(),
                    //   ),
                    // ],
                  ),
        ),
      ),
    );
  }
}
