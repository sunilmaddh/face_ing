import 'package:flutter/material.dart';
import 'package:ntt_data/modules/voice_agent/native/call_audio_controler.dart';
import 'package:ntt_data/modules/voice_agent/services/web_socket_services.dart';

CallAudioController? callAudioController;

Future<void> startCall({
  required WebSocketService websocket,
  required String streamId,
}) async {
  callAudioController = CallAudioController(
    ws: websocket.channel!,
    streamId: streamId,
    debug: true,
  );

  await callAudioController!.start();

  debugPrint("✅ Call audio controller started");
}

Future<void> stopCall() async {
  try {
    await callAudioController?.stop();
  } catch (_) {}

  callAudioController = null;
}
