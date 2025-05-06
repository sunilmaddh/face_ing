import 'package:get/get.dart';

mixin GenderStateMixin on GetxController {
  RxBool isGenderType = false.obs;
  RxString selectionType = "".obs;
}
