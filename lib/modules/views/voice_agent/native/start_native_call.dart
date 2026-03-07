import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/voice_agent/native/call_audio_controler.dart';
import 'package:ntt_data/modules/views/voice_agent/web_socket_services.dart';

late CallAudioController callAudioController;

Future<void> startCall({
  required WebSocketService websocket,
  required String streamId,
}) async {
  callAudioController = CallAudioController(
    ws: websocket.channel!,
    streamId: streamId,
    debug: true,
  );

  await callAudioController.start();

  debugPrint("✅ Call audio controller started");
}

Future<void> stopCall() async {
  await callAudioController.stop();
  await callAudioController.ws.sink.close();
}
