import 'package:get/get.dart';

mixin CheckboxStateMixin on GetxController {
  final RxBool isChecked = false.obs;
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }
}
