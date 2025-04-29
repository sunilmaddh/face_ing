import 'package:get/get.dart';
import 'package:ntt_data/binah/measurement_controller.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';
import 'package:ntt_data/modules/views/onboard/onboard_controller.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ApiServices>(() => ApiServices(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<OnboardController>(() => OnboardController(), fenix: true);
    Get.lazyPut<MeasurementController>(
      () => MeasurementController(),
      fenix: true,
    );
    Get.put(MeasurementController());
  }
}
