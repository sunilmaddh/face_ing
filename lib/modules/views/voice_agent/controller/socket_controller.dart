import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_session_helper.dart';
import 'package:ntt_data/modules/views/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/views/voice_agent/pcm_player.dart';
import 'package:ntt_data/modules/views/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/services/web_socket_services.dart';

class SocketController extends GetxController {
  final WebSocketService _service = WebSocketService();

  bool isWebSocketConnected = false;

  var messages = <String>[].obs;
  var isConnected = false.obs;
  var isLastEndCall = false.obs;
  var isMicMute = false.obs;

  final Pcm16StreamPlayer player = Pcm16StreamPlayer();

  final List<String> _pendingAgentChunks = [];
  bool _playerStartedForCall = false;
  Timer? _prebufferFlushTimer;
  bool isSessionEnding = false;

  void markSessionEnding() {
    isSessionEnding = true;
  }

  Future<void> _flushPrebufferIfNeeded() async {
    if (_playerStartedForCall) return;
    if (_pendingAgentChunks.isEmpty) return;

    await player.start();
    _playerStartedForCall = true;
    Get.find<AiSessionController>().start();
    for (final chunk in _pendingAgentChunks) {
      await player.feedBase64Pcm16(chunk);
    }
    _pendingAgentChunks.clear();

    debugPrint("✅ Player started after prebuffer flush");
  }

  Future<void> connectSocket({
    required String tenantId,
    required String botId,
    required String streamId,
  }) async {
    isSessionEnding = false;
    isWebSocketConnected = false;

    print("🎧 starting call audio session");
    await configureAudioSession();
    print("✅ call audio session active");

    await player.init();
    _playerStartedForCall = false;
    _pendingAgentChunks.clear();
    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;

    await _service.connect(
      //"wss://0945-2406-7400-111-b2f7-344f-b2ae-737e-7b40.ngrok-free.app/ws/v1/web/voice_agent/$tenantId/$botId/$streamId",
      "wss://dev.sourcebytes.ai/ws/v1/web/voice_agent/$tenantId/$botId/$streamId/",
    );
    isConnected.value = true;

    _service.stream?.listen(
      (data) async {
        messages.add(data.toString());

        final datas = jsonDecode(data);

        if (datas['type'] == 'agent_audio') {
          if (isSessionEnding) return;

          final payload = datas['audio'] as String;
          final sr = (datas['sample_rate'] ?? 48000) as int;

          if (isWebSocketConnected == false) {
            isWebSocketConnected = true;
            await startCall(websocket: _service, streamId: streamId);
          }

          if (callAudioController == null) {
            return;
          }

          callAudioController!.onAgentAudioQueued(
            base64Audio: payload,
            sampleRate: sr,
          );

          if (!_playerStartedForCall) {
            _pendingAgentChunks.add(payload);

            _prebufferFlushTimer ??= Timer(
              const Duration(milliseconds: 250),
              () async {
                _prebufferFlushTimer = null;
                await _flushPrebufferIfNeeded();
              },
            );

            if (_pendingAgentChunks.length >= 4) {
              _prebufferFlushTimer?.cancel();
              _prebufferFlushTimer = null;
              await _flushPrebufferIfNeeded();
            }
          } else {
            await player.feedBase64Pcm16(payload);
          }

          await callAudioController!.startMicCaptureIfNeeded();
        }

        if (datas["event"] == "agent_message") {
          if (datas['message'] != null) {
            debugPrint("Agent message ${datas['message']}");
            Get.find<VoiceCallController>().messageC.value = datas['message'];
          }
        }

        if (datas["event"] == "call_ended") {
          // disconnect();
          // Get.to(() => PhqTwoQuestionsScreen());
          await Get.find<AiSessionController>().endSessionGracefully();
        }

        if (datas['event'] == 'stop') {
          // await player.stop();
        }
      },
      onError: (error) {
        isConnected.value = false;
        isSessionEnding = false;
        debugPrint(error.toString());
      },
      onDone: () {
        isConnected.value = false;
        isLastEndCall.value = true;
        isSessionEnding = false;
      },
    );
  }

  Future<void> sendMessage(Map<String, dynamic> message) async {
    await _service.send(message);
  }

  Future<void> closeWebsocket() async {
    isSessionEnding = false;
    isConnected.value = false;
    _service.disconnect();
    stopCall();
    player.dispose();
    _playerStartedForCall = false;
    _pendingAgentChunks.clear();
    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;
  }

  Future<void> disconnect() async {
    isSessionEnding = false;
    isConnected.value = false;
    _service.disconnect();
    stopCall();
    player.dispose();
    _playerStartedForCall = false;
    _pendingAgentChunks.clear();
    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;
    // Get.find<VoiceCallController>().messageC.value = "";
  }

  @override
  void onClose() {
    disconnect();
    stopCall();
    super.onClose();
  }
}
