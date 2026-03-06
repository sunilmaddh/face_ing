import 'package:get/get.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/home/controllers/home_controller.dart';
import 'package:ntt_data/modules/views/landing/landing_controller.dart';
import 'package:ntt_data/modules/views/onboard/controllers/onboard_controller.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/voice/controller/voice_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ApiServices>(() => ApiServices(), fenix: true);
    Get.put(LandingController());
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.put(HomeController());
    Get.put(OnboardController());
    Get.put(GeustController());
    Get.put(MeasurementController());
    Get.put(VitalGraphController());
    Get.put(PulseSurveyController());
    Get.put(VoiceController());
  }
}
