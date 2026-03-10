import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/data/models/kintsugi_initiate_response.dart';
import 'package:ntt_data/data/repository/services/voice_service.dart';

class VoiceController extends GetxController {
  final _voiceService = VoiceService();
  RxBool isStarted = false.obs;
  RxBool isInitiating = false.obs;

  Future<String> initiateKintisugi() async {
    Map<String, dynamic> responseData =
        await _voiceService.initiateKintsugiApi();
    int statusCode = responseData["statusCode"];
    if (statusCode == 200) {
      var result = KintsigiInitiateResponse.fromJson(
        responseData['responseBody'],
      );
      return result.sessionId!;
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
      return "";
    }
  }

  Future<void> questionaryKintisugi() async {
    Map<String, dynamic> responseData =
        await _voiceService.questionaryKintsugiApi();
    int statusCode = responseData["statusCode"];
    if (statusCode == 200) {
    } else {
      AppSnackbar.show(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    }
  }
}
