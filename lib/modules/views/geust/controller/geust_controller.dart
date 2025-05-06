import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
    Map<String, dynamic> resposneData =
        await GeustServices().getGeustHistoryService();

    int statusCode = resposneData["statusCode"];
    if (statusCode == 200) {}
  }
}
