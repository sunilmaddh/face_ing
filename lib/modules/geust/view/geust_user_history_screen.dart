import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_view.dart';
import 'package:ntt_data/core/constants/app_assets.dart';
import 'package:ntt_data/core/utils/app_dimentions.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/date_time_halper.dart';
import 'package:ntt_data/data/services/profile_upload_services.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/geust/widget/geust_user_history_card.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/helper/profile_helper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';
import 'package:ntt_data/widgets/bar/custom_app_bar.dart';
import 'package:ntt_data/widgets/bottom_sheet/image_picker_bottomsheet.dart';
import 'package:ntt_data/widgets/button/rounded_button.dart';
import 'package:ntt_data/widgets/custom_shimmer.dart/shimmer_widget.dart';

class GeustUserHistoryScreen extends BaseView<GeustController> {
  const GeustUserHistoryScreen({super.key});

  @override
  bool get useDefaultLoader => false;

  @override
  void onInit(GeustController controller) {
    super.onInit(controller);

    // 🔥 replaces initState + postFrameCallback
    controller.getGeustHistory();
  }

  @override
  Widget buildView(BuildContext context, GeustController controller) {
    return Scaffold(
      floatingActionButton: RoundedButton(
        onPressed: () {
          AppNavigation.to(
            AppRoutes.addNewGeustScreen,
            action: () {
              // optional refresh
              // controller.getGeustHistory();
            },
          );
        },
        isAdd: true,
        isAppBar: false,
        size: AppDimensions.height(58),
      ),
      appBar: CustomAppBar(title: "Guest History"),
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.padding(15)),
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return ShimmerLoadingScreen(
              widget: ShimmerListItem(),
              itemCount: 8,
            );
          }

          if (controller.guestList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  AppAssets.noDataImage,
                  alignment: Alignment.center,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.guestList.length,
            itemBuilder: (context, index) {
              final result = controller.guestList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: GeustUserHistoryCard(
                  guestImage: result.guestImage.toString(),
                  gender: result.gender.toString(),
                  name: result.name.toString(),
                  height: result.height.toString(),
                  weight: result.weight.toString(),
                  time: DateTimeHelper.formatUtcToLocal(result.date.toString()),

                  onTop: () {
                    controller.guestId.value = result.guestId.toString();

                    controller.getGuestHealthHistory();
                  },

                  onDelete: () {
                    controller.removeGuest(guestId: result.guestId);
                  },

                  onReScan: () {
                    controller.callReScanMeasurement(
                      result.gender!,
                      result.dob!,
                      result.weight!,
                      result.height!,
                      result.smokerType!,
                      result.guestId!,
                      result.name!,
                    );
                  },

                  guestOptionList: AppMethods().guestOptionList,

                  onOptionList: (value) async {
                    if (value == "Photo") {
                      ImagePickerBottomsheet.showImagePickerBottomSheet(
                        onGalleryTap: () async {
                          final file = await ProfileUploadService()
                              .uploadProfileImage(
                                source: ImagePickSource.gallery,
                              );
                          if (file.path.isNotEmpty) {
                            await controller.uploadProfile(
                              imagePath: file.path,
                              guestId: result.guestId ?? "",
                              isGuest: "true",
                            );
                          }
                        },
                        onCameraTap: () async {
                          final file = await ProfileUploadService()
                              .uploadProfileImage(
                                source: ImagePickSource.camera,
                              );
                          if (file.path.isNotEmpty) {
                            await controller.uploadProfile(
                              imagePath: file.path,
                              guestId: result.guestId ?? "",
                              isGuest: 'true',
                            );
                          }
                        },
                      );
                    } else {
                      ProfileHelper().retainedData(
                        name: result.name.toString(),
                        weight: result.weight.toString(),
                        height: result.height.toString(),
                        gender: result.gender.toString(),
                        dob: result.dob.toString(),
                        smokerType: result.smokerType.toString(),
                        guestId: result.guestId.toString(),
                        userFlag: "false",
                        levelName: "Patient ID",
                        emailId: result.email.toString(),
                        profileController: Get.find<ProfileController>(),
                      );
                    }
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
