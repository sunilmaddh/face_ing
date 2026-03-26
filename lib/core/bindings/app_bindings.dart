import 'package:get/get.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/network/encryption_service.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/auth/controllers/splash_controller.dart';
import 'package:ntt_data/modules/auth/repositories/auth_repository.dart';
import 'package:ntt_data/modules/auth/services/auth_service.dart';
import 'package:ntt_data/modules/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/ai_recommendation/controller/ai_advice_controller.dart';
import 'package:ntt_data/modules/ai_recommendation/repositories/ai_advice_repository.dart';
import 'package:ntt_data/modules/ai_recommendation/services/ai_advice_service.dart';
import 'package:ntt_data/modules/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/binah/repositories/mesurement_repository.dart';
import 'package:ntt_data/modules/binah/service/mesurement_service.dart';
import 'package:ntt_data/modules/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/geust/repositoriese/guest_repository.dart';
import 'package:ntt_data/modules/geust/services/guest_service.dart';
import 'package:ntt_data/modules/home/controller/home_controller.dart';
import 'package:ntt_data/modules/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/pulse/repositories/pulse_survey_repository.dart';
import 'package:ntt_data/modules/pulse/service/pulse_survey_service.dart';
import 'package:ntt_data/modules/home/repositories/home_repository.dart';
import 'package:ntt_data/modules/home/service/home_service.dart';
import 'package:ntt_data/modules/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/voice_agent/repositories/voice_agent_repository.dart';
import 'package:ntt_data/modules/voice_agent/services/voice_agent_service.dart';
import 'package:ntt_data/modules/voice_agent/services/web_socket_services.dart';
import 'package:ntt_data/modules/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/phq/controllers/phq_controller.dart';
import 'package:ntt_data/modules/phq/repositories/phq_repository.dart';
import 'package:ntt_data/modules/phq/services/phq_service.dart';
import 'package:ntt_data/modules/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/profile/repositories/profile_repository.dart';
import 'package:ntt_data/modules/profile/services/profile_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EncryptionService>(() => EncryptionService(), fenix: true);
    Get.lazyPut<ApiService>(
      () => ApiService(encryptionService: Get.find<EncryptionService>()),
      fenix: true,
    );
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthService>(
      () => AuthService(apiService: Get.find<ApiService>()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(authService: Get.find<AuthService>()),
      fenix: true,
    );
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<LandingController>(() => LandingController(), fenix: true);
    Get.lazyPut<HomeService>(
      () => HomeService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(homeService: Get.find<HomeService>()),
    );

    Get.lazyPut<AiAdviceService>(
      () => AiAdviceService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<AiAdviceRepository>(
      () => AiAdviceRepository(aiAdviceService: Get.find<AiAdviceService>()),
    );
    Get.lazyPut<ProfileService>(
      () => ProfileService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(profileService: Get.find<ProfileService>()),
    );
    Get.lazyPut<PulseSurveyService>(
      () => PulseSurveyService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<PulseSurveyRepository>(
      () => PulseSurveyRepository(
        pulseSurveyService: Get.find<PulseSurveyService>(),
      ),
    );
    Get.lazyPut<GuestService>(
      () => GuestService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<GuestRepository>(
      () => GuestRepository(guestService: Get.find<GuestService>()),
    );
    Get.lazyPut<PhqService>(
      () => PhqService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<PhqRepository>(
      () => PhqRepository(phqService: Get.find<PhqService>()),
    );
    Get.lazyPut<MesurementService>(
      () => MesurementService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<MesurementRepository>(
      () => MesurementRepository(
        mesurementService: Get.find<MesurementService>(),
      ),
    );
    Get.lazyPut<VoiceAgentService>(
      () => VoiceAgentService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<VoiceAgentRepository>(
      () => VoiceAgentRepository(
        voiceAgentService: Get.find<VoiceAgentService>(),
      ),
    );
    Get.lazyPut<WebSocketService>(() => WebSocketService());

    Get.lazyPut<VoiceCallController>(
      () => VoiceCallController(
        voiceAgentRepository: Get.find<VoiceAgentRepository>(),
      ),
    );

    Get.lazyPut<SocketController>(
      () => SocketController(service: Get.find<WebSocketService>()),
    );
    Get.lazyPut<AssessmentController>(
      () => AssessmentController(phqRepository: Get.find<PhqRepository>()),
    );
    Get.lazyPut<AiSessionController>(
      () => AiSessionController(
        voiceAgentRepository: Get.find<VoiceAgentRepository>(),
        voiceCallController: Get.find<VoiceCallController>(),
        socketController: Get.find<SocketController>(),
        assessmentController: Get.find<AssessmentController>(),
      ),
    );
    Get.lazyPut<MeasurementController>(
      () => MeasurementController(
        mesurementRepository: Get.find<MesurementRepository>(),
      ),
    );
    Get.lazyPut<PhqController>(
      () => PhqController(phqRepository: Get.find<PhqRepository>()),
    );

    Get.lazyPut<GeustController>(
      () => GeustController(guestRepository: Get.find<GuestRepository>()),
      fenix: true,
    );
    Get.lazyPut<PulseSurveyController>(
      () => PulseSurveyController(
        pulseSurveyRepository: Get.find<PulseSurveyRepository>(),
      ),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(profileRepository: Get.find<ProfileRepository>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(homeRepository: Get.find<HomeRepository>()),
    );
    Get.lazyPut<AiAdviceController>(
      () =>
          AiAdviceController(adviceRepository: Get.find<AiAdviceRepository>()),
    );
  }
}
