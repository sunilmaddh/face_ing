import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/modules/views/phq/screens/ai_session_screen.dart';
import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_service.dart';
import 'package:ntt_data/modules/views/voice_agent/webhook_response.dart';

class VoiceCallController extends GetxController {
  RxString messageC = "".obs;

  Future<void> getCredentials() async {
    var userName = await IndoSharedPreference.instance.getUserName();
    var data = {
      "agent_id": "2f0817e4-6585-4ebe-8a0a-29f09652ef00",
      "user_name": userName,
    };
    debugPrint(data.toString());
    Map<String, dynamic> resposneData = await BaseVoiceApiService().postRequest(
      data: data,
      userName: userName,
    );
    int statusCode = resposneData["statusCode"];
    if (statusCode == 200) {
      var result = webhookResponseFromJson(resposneData["responseBody"]);
      messageC.value = result.message!;
      Get.find<SocketController>().connectSocket(
        tenantId: result.tenant!,
        botId: result.agent!,
        streamId: result.streamSid!,
      );
      await Future.delayed(Duration(milliseconds: 300));
      final message = {
        "type": "start",
        "stream_sid": result.streamSid,
        "transport": "webrtc_mobile",
      };
      debugPrint("Message $message");
      Get.find<SocketController>().sendMessage(message);
      Get.find<AiSessionController>().start();
    } else if (statusCode == 500) {
    } else {}
  }

  @override
  void onClose() {
    super.onClose();
  }
}
