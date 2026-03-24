import 'package:get/get.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/modules/views/ai_recommendation/controller/ai_controller.dart';
import 'package:ntt_data/modules/views/ai_recommendation/repositories/ai_advice_repository.dart';
import 'package:ntt_data/modules/views/ai_recommendation/services/ai_advice_service.dart';
import 'package:ntt_data/modules/views/binah/controllers/measurement_controller.dart';
import 'package:ntt_data/modules/views/binah/repositories/mesurement_repository.dart';
import 'package:ntt_data/modules/views/binah/service/mesurement_service.dart';
import 'package:ntt_data/modules/views/geust/controller/geust_controller.dart';
import 'package:ntt_data/modules/views/geust/repositoriese/guest_repository.dart';
import 'package:ntt_data/modules/views/geust/services/guest_service.dart';
import 'package:ntt_data/modules/views/landing/controller/home_controller.dart';
import 'package:ntt_data/modules/views/landing/controller/landing_controller.dart';
import 'package:ntt_data/modules/views/landing/pulse/controller/pulse_survey_controller.dart';
import 'package:ntt_data/modules/views/landing/pulse/repositories/pulse_survey_repository.dart';
import 'package:ntt_data/modules/views/landing/pulse/service/pulse_survey_service.dart';
import 'package:ntt_data/modules/views/landing/repositories/home_repository.dart';
import 'package:ntt_data/modules/views/landing/service/home_service.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/controller/socket_controller.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/repositories/voice_agent_repository.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/services/voice_agent_service.dart';
import 'package:ntt_data/modules/views/landing/voice_agent/services/web_socket_services.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/phq/controllers/assessment_controller.dart';
import 'package:ntt_data/modules/views/phq/controllers/phq_controller.dart';
import 'package:ntt_data/modules/views/phq/repositories/phq_repository.dart';
import 'package:ntt_data/modules/views/phq/services/phq_service.dart';
import 'package:ntt_data/modules/views/profile/controller/profile_controller.dart';
import 'package:ntt_data/modules/views/profile/repositories/profile_repository.dart';
import 'package:ntt_data/modules/views/profile/services/profile_service.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/repositories/vital_graph_repository.dart';
import 'package:ntt_data/modules/views/vital_graph/services/vital_graph_service.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(() => LandingController());
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
    Get.lazyPut<AiSessionController>(
      () => AiSessionController(
        voiceAgentRepository: Get.find<VoiceAgentRepository>(),
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
    Get.lazyPut<AssessmentController>(
      () => AssessmentController(phqRepository: Get.find<PhqRepository>()),
    );
    Get.lazyPut<GeustController>(
      () => GeustController(guestRepository: Get.find<GuestRepository>()),
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
