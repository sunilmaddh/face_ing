import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/network/api_endpoints.dart';
import 'package:ntt_data/modules/phq/controllers/aisession_controller.dart';
import 'package:ntt_data/modules/voice_agent/controller/voice_call_controller.dart';
import 'package:ntt_data/modules/voice_agent/helper/audio_session_helper.dart';
import 'package:ntt_data/modules/voice_agent/helper/pcm_player.dart';
import 'package:ntt_data/modules/voice_agent/native/start_native_call.dart';
import 'package:ntt_data/modules/voice_agent/services/web_socket_services.dart';

class SocketController extends BaseController {
  SocketController({required this.service});

  final WebSocketService service;

  final RxBool isWebSocketConnected = false.obs;
  final RxList<String> messages = <String>[].obs;
  final RxBool isConnected = false.obs;
  final RxBool isLastEndCall = false.obs;
  final RxBool isMicMute = false.obs;
  final RxDouble progress = 0.0.obs;

  final Pcm16StreamPlayer player = Pcm16StreamPlayer();

  final List<String> _pendingAgentChunks = [];
  StreamSubscription? _socketSubscription;
  Timer? _prebufferFlushTimer;

  bool _playerStartedForCall = false;
  bool isSessionEnding = false;
  double maxDuration = 60.0;

  void markSessionEnding() {
    isSessionEnding = true;
  }

  void updateProgress(double speechTime) {
    progress.value = (speechTime / maxDuration).clamp(0.0, 1.0);
  }

  Future<void> _flushPrebufferIfNeeded() async {
    if (_playerStartedForCall || _pendingAgentChunks.isEmpty) return;

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
    await _resetBeforeConnect();

    try {
      await configureAudioSession();
      await player.init();

      await service.connect(
        "${ApiEndpoints.initiateWebsocket}/$tenantId/$botId/$streamId/",
      );

      isConnected.value = true;

      await _socketSubscription?.cancel();
      _socketSubscription = service.stream?.listen(
        (data) async {
          await _handleSocketData(data, streamId);
        },
        onError: (error) {
          isConnected.value = false;
          isSessionEnding = false;
          debugPrint(error.toString());
          setError("WebSocket connection error");
        },
        onDone: () {
          isConnected.value = false;
          isLastEndCall.value = true;
          isSessionEnding = false;
        },
      );
    } catch (e) {
      isConnected.value = false;
      isSessionEnding = false;
      debugPrint(e.toString());
      setError("Failed to connect socket");
    }
  }

  Future<void> _handleSocketData(dynamic data, String streamId) async {
    messages.add(data.toString());

    final Map<String, dynamic> decoded = jsonDecode(data);

    if (decoded['type'] == 'agent_audio') {
      await _handleAgentAudio(decoded, streamId);
    }

    if (decoded['event'] == 'agent_message') {
      final message = decoded['message'];
      final userSpeakDuration = decoded['user_speak_duration'];

      if (message != null) {
        debugPrint("Agent message $message");
        debugPrint("User speak $userSpeakDuration");

        Get.find<VoiceCallController>().messageC.value = message;
        updateProgress((userSpeakDuration ?? 0).toDouble());
      }
    }

    if (decoded['event'] == 'call_ended') {
      debugPrint("Event ${decoded["event"]}");
      await Get.find<AiSessionController>().endSessionGracefully();
    }

    if (decoded['event'] == 'stop') {
      // await player.stop();
    }
  }

  Future<void> _handleAgentAudio(
    Map<String, dynamic> data,
    String streamId,
  ) async {
    if (isSessionEnding) return;

    final payload = data['audio'] as String;
    final sr = (data['sample_rate'] ?? 48000) as int;

    if (!isWebSocketConnected.value) {
      isWebSocketConnected.value = true;
      await startCall(websocket: service, streamId: streamId);
    }

    if (callAudioController == null) return;

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

  Future<void> sendMessage(Map<String, dynamic> message) async {
    await service.send(message);
  }

  Future<void> closeWebsocket() async {
    await _cleanupConnection(resetProgress: false);
  }

  Future<void> disconnect() async {
    await _cleanupConnection(resetProgress: true);
  }

  Future<void> _resetBeforeConnect() async {
    isSessionEnding = false;
    isWebSocketConnected.value = false;
    isConnected.value = false;
    isLastEndCall.value = false;

    _playerStartedForCall = false;
    _pendingAgentChunks.clear();

    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;

    await _socketSubscription?.cancel();
    _socketSubscription = null;
  }

  Future<void> _cleanupConnection({required bool resetProgress}) async {
    isSessionEnding = false;
    isConnected.value = false;
    isWebSocketConnected.value = false;

    await _socketSubscription?.cancel();
    _socketSubscription = null;

    service.disconnect();
    stopCall();

    _prebufferFlushTimer?.cancel();
    _prebufferFlushTimer = null;

    _playerStartedForCall = false;
    _pendingAgentChunks.clear();

    await player.dispose();

    if (resetProgress) {
      progress.value = 0.0;
    }
  }

  @override
  void onClose() {
    _cleanupConnection(resetProgress: true);
    super.onClose();
  }
}
