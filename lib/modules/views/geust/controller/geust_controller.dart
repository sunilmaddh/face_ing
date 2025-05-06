import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/mixins/checkbox_state_mixin.dart';
import 'package:ntt_data/core/mixins/gender_state_mixin.dart';
import 'package:ntt_data/data/repository/services/geust_services.dart';

class GeustController extends GetxController
    with CheckboxStateMixin, GenderStateMixin {
  final nameTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final dobTextController = TextEditingController();
  RxString genderType = "".obs;
  RxString geustDob = ''.obs;
  RxBool isTermAccepted = false.obs;

  Future<void> getGeustHistory() async {
    var data = {"userId": "100000000"};
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: data);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
    } else if (statusCode == 500) {
    } else {}
  }

  Future<void> getGeustDetails() async {
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: null);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
    } else if (statusCode == 500) {
    } else {}
  }

  Future<void> addGuest() async {
    Map<String, dynamic> resposneData = await GeustServices()
        .getGeustHistoryService(data: null);
    int statusCode = resposneData[AppConstents.statusCode];
    if (statusCode == 200) {
    } else if (statusCode == 500) {
    } else {}
  }
}
