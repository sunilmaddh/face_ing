import 'dart:io';

import 'package:biosensesignal_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/common_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/core/mixins/progress_mixin.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/guest_history_details_model.dart';
import 'package:ntt_data/data/models/guest_list_response_model.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/data/repository/services/geust_services.dart';
import 'package:ntt_data/modules/views/geust/helper/guest_halper.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

class GeustController extends GetxController
    with
        CheckboxStateMixin,
        RadioStateMixin,
        CommonMixin,
        ProgressHandlerMixin {
  final nameTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final dobTextController = TextEditingController();
  RxList<GuestHealthAnuraHistory> guestAnuraHistory =
      <GuestHealthAnuraHistory>[].obs;
  RxList<Map<String, dynamic>> anuraHIstoryDetails =
      <Map<String, dynamic>>[].obs;
  RxList<HealthDetailList> binahHIstoryDetails = <HealthDetailList>[].obs;
  RxList<UserHealthList> guestHealthList = <UserHealthList>[].obs;

  RxBool isLoading = false.obs;
  RxBool isHomeLoading = false.obs;
  RxList<GuestList> guestList = <GuestList>[].obs;
  RxString sdkType = "".obs;
  RxString genderType = "".obs;
  RxString geustDob = ''.obs;
  RxString guestId = "".obs;
  RxBool isTermAccepted = false.obs;
  RxList<HealthDetailList> healthDetailsList = <HealthDetailList>[].obs;
  RxList<GuestList> filteredItems = <GuestList>[].obs;

  Future<void> getGeustHistory() async {
    isLoading(true);
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {"userId": userID};
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: data);
    isLoading(false);
    int statusCode = resposneData[AppConstents.statusCode];
    try {
      if (statusCode == 200) {
        guestList.clear();
        profileUrl.value = File("");
        isProfile.value = false;
        filteredItems.clear();
        var data = GuestListResponseModel.fromJson(
          resposneData["responseBody"],
        );
        guestList.value = data.guestList!;
      } else if (statusCode == 500) {
        guestList.clear();
        filteredItems.clear();
      } else {
        guestList.clear();
        filteredItems.clear();
        AppSnackbar.show(title: "Error", message: "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getGeustDetails(
    String guestID,
    String scanId,
    bool isFullHistory,
  ) async {
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {
      "userId": userID,
      "guestId": guestID,
      "healthId": scanId,
      "isFullHistory": isFullHistory,
    };

    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustDetailsService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      var data = HealthDetailsResponseModel.fromJson(
        resposneData["responseBody"],
      );

      healthDetailsList.value = data.healthDetail!;
      AppNavigation.to(AppRoutes.guestHistoryDetails);

      debugPrint(data.toString());
    } else if (statusCode == 500) {
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wrong");
    }
  }

  Future<void> storeBinahHealthForUser(
    VitalSignsResults vitalSignResult, {
    required String guestId,
    required String isUser,
  }) async {
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = await GuestHalper().userMapData(
      userId: userID,
      guestId: guestId,
      isUser: isUser,
      vitalSignResult: vitalSignResult,
    );
    debugPrint(data.toString());
    Map<String, dynamic> responseData = await GeustServices()
        .storeBinahHealthForUserService(data: data);
    int statusCode = responseData[AppConstents.statusCode];
    if (statusCode == 200) {
      AppSnackbar.show(
        title: "Success",
        message: "Store health data Successfully",
      );
    } else if (statusCode == 500) {
      AppSnackbar.show(
        title: "Erro",
        message: "Something went wrong",
        isError: true,
      );
    } else {
      AppSnackbar.show(title: "Error", message: "Something went wron");
    }
  }

  Future<void> addGuest(VitalSignsResults vitalSignResult) async {
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = await GuestHalper().mapData(
      userId: userID,
      name: nameTextController.text,
      gender: selectionType.value,
      dob: dobTextController.text,
      weight: weightTextController.text,
      height: heightTextController.text,
      guestImage: userImage.value,
      vitalSignResult: vitalSignResult,
    );
    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices().addGeustService(
      data: data,
    );
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
    } else if (statusCode == 500) {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> removeGuest({required var guestId}) async {
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {"userId": userID, "guestId": guestId};

    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await GeustServices().deleteGuest(
      data: data,
    );
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
      AppSnackbar.show(title: "Success", message: "Guest remove successfully");
      getGeustHistory();
    } else if (statusCode == 500) {
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> getGuestHealthHistory() async {
    isLoading(true);
    var userID = await IndoSharedPreference.instance.getUserId();
    var data = {"userId": userID, "guestId": guestId.value, "isUser": "false"};
    debugPrint(data.toString());
    Map<String, dynamic> responseData = await GeustServices()
        .getUserHealthHistoryService(data: data);
    isLoading(false);
    int statusCode = responseData[AppConstents.statusCode];
    try {
      if (statusCode == 200) {
        guestHealthList.clear();
        var result = UserHistoryListModel.fromJson(
          responseData["responseBody"],
        );
        guestHealthList.value = result.userHealthList!;
        AppNavigation.to(
          AppRoutes.guestHealthHistoryList,
          arguments: {"guestId": guestId.value},
        );
      } else {
        guestHealthList.clear();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void dispose() {
    guestList.clear();
    GuestHalper().clearData();
    super.dispose();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredItems.clear();
    } else {
      filteredItems.value =
          guestList
              .where(
                (item) =>
                    item.name!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
  }
}
