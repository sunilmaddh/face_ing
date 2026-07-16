import 'package:get/get.dart';
import 'package:ntt_data/modules/phq/controllers/phq_controller.dart';
import 'package:ntt_data/modules/phq/repositories/phq_repository.dart';

class PhqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhqController>(
      () => PhqController(phqRepository: Get.find<PhqRepository>()),
    );
  }
}
