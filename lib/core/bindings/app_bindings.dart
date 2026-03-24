import 'package:get/get.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/encryption_service.dart';
import 'package:ntt_data/modules/views/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/views/auth/controllers/splash_controller.dart';
import 'package:ntt_data/modules/views/auth/repositories/auth_repository.dart';
import 'package:ntt_data/modules/views/auth/services/auth_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EncryptionService>(() => EncryptionService());
    Get.lazyPut<ApiService>(
      () => ApiService(encryptionService: Get.find<EncryptionService>()),
    );
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthService>(
      () => AuthService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(authService: Get.find<AuthService>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find<AuthRepository>()),
    );
    // Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    // Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    // Get.put(HomeController());
    // Get.put(OnboardController());
    // Get.put(GeustController());
    // Get.put(MeasurementController());
    // Get.put(VitalGraphController());
    // Get.put(PulseSurveyController());
    // Get.put(VoiceController());
    // Get.put(AiSessionController());
    // Get.put(AssessmentController());
  }
}
