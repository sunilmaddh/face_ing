import 'package:get/get.dart';
import 'package:ntt_data/core/constants/validation_strings.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/modules/voice_agent/repositories/voice_agent_repository.dart';

class VoiceController extends GetxController {
  VoiceController({required this.voiceAgentRepository});
  final VoiceAgentRepository voiceAgentRepository;
  RxBool isStarted = false.obs;
  RxBool isInitiating = false.obs;
  Future<String> initiateKintisugi() async {
    var responseData = await voiceAgentRepository.initiateKintsugiApi();
    if (responseData.statusCode == 200) {
      var result = responseData.data;
      return result!.sessionId!;
    } else {
      AppSnackbar.show(
        title: "Error",
        message: ValidationStrings.commonErrorMessage,
        isError: true,
      );
      return "";
    }
  }
}
