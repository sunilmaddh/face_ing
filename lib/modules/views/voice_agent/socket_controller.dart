import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_two_questions_screen.dart';
import 'package:ntt_data/modules/views/voice_agent/audio_session_helper.dart';
import 'package:ntt_data/modules/views/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/views/voice_agent/pcm_player.dart';
import 'package:ntt_data/modules/views/voice_agent/voice_controller.dart';
import 'package:ntt_data/modules/views/voice_agent/web_socket_services.dart';
import 'package:permission_handler/permission_handler.dart';

class SocketController extends GetxController {
  final WebSocketService _service = WebSocketService();

  bool isWebSocketConnected = false;

  var messages = <String>[].obs;
  var isConnected = false.obs;

  final Pcm16StreamPlayer player = Pcm16StreamPlayer();

  // ✅ prebuffer state
  final List<String> _pendingAgentChunks = [];
  bool _playerStartedForCall = false;
  Timer? _prebufferFlushTimer;

  @override
  void onInit() {
    requestMicPermission();
    super.onInit();
  }

  Future<bool> requestMicPermission() async {
    var status = await Permission.microphone.status;

    if (status.isGranted) return true;

    status = await Permission.microphone.request();

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  Future<void> _flushPrebufferIfNeeded() async {
    if (_playerStartedForCall) return;
    if (_pendingAgentChunks.isEmpty) return;

    await player.start();
    _playerStartedForCall = true;

    for (final chunk in _pendingAgentChunks) {
      await player.feedBase64Pcm16(chunk);
    }
    _pendingAgentChunks.clear();

    debugPrint("✅ Player started after prebuffer flush");
  }

  void connectSocket({
    required String tenantId,
    required String botId,
    required String streamId,
  }) async {
    print("🎧 starting call audio session");
    await configureAudioSession();
    print("✅ call audio session active");

    await player.init();

    _playerStartedForCall = false;
    _pendingAgentChunks.clear();
    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;

    isWebSocketConnected = false;

    _service.connect(
      "wss://dev.sourcebytes.ai/ws/v1/web/voice_agent/$tenantId/$botId/",
    );
    isConnected.value = true;

    _service.stream?.listen(
      (data) async {
        messages.add(data.toString());

        final datas = jsonDecode(data);

        if (datas['type'] == 'agent_audio') {
          final payload = datas['audio'] as String;
          final sr = (datas['sample_rate'] ?? 48000) as int;

          if (isWebSocketConnected == false) {
            isWebSocketConnected = true;
            await startCall(websocket: _service, streamId: streamId);
          }

          // ✅ tell gate about actual queued playback duration
          callAudioController.onAgentAudioQueued(
            base64Audio: payload,
            sampleRate: sr,
          );

          // ✅ prebuffer first response before starting player
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

          // ✅ after first bot utterance is queued, start mic capture once
          await callAudioController.startMicCaptureIfNeeded();
        }
        if (datas["event"] == "agent_message") {
          if (datas['message'] != null) {
            Get.find<VoiceCallController>().messageC.value = datas['message'];
          }
        }
        if (datas["event"] == "call_ended") {
          disconnect();
          Get.to(() => const PhqTwoQuestionsScreen());
        }

        if (datas['event'] == 'stop') {
          // await player.stop();
        }
      },
      onError: (error) {
        isConnected.value = false;
        debugPrint(error.toString());
      },
      onDone: () {
        isConnected.value = false;
      },
    );
  }

  void sendMessage(Map<String, dynamic> message) {
    _service.send(message);
  }

  void disconnect() {
    _service.disconnect();
    isConnected.value = false;
    stopCall();
    player.dispose();
    _playerStartedForCall = false;
    _pendingAgentChunks.clear();
    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;
    Get.find<VoiceCallController>().messageC.value = "";
  }

  @override
  void onClose() {
    disconnect();
    stopCall();
    super.onClose();
  }
}
