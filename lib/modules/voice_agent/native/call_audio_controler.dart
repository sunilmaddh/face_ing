import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'native_mic_sender.dart';

class CallAudioController {
  final WebSocketChannel ws;
  final String streamId;
  final bool debug;

  NativeMicSender? nativeMicSender;

  bool _micCaptureStarted = false;
  int _agentAudioEndsAtMs = 0;
  int _startupMuteEndsAtMs = 0;

  CallAudioController({
    required this.ws,
    required this.streamId,
    this.debug = true,
  });

  bool get isAgentSpeaking {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now < _startupMuteEndsAtMs || now < _agentAudioEndsAtMs;
  }

  int get remainingAgentAudioMs {
    final now = DateTime.now().millisecondsSinceEpoch;
    final remaining = _agentAudioEndsAtMs - now;
    return remaining > 0 ? remaining : 0;
  }

  Future<void> start() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    _startupMuteEndsAtMs = now + 2000;

    nativeMicSender = NativeMicSender(
      streamId,
      ws: ws,
      debug: debug,
      isAgentSpeaking: () => isAgentSpeaking,
    );

    if (debug) {
      if (kDebugMode) {
        print("✅ Native mic sender created");
      }
    }

    await nativeMicSender!.prepare();

    if (debug) {
      if (kDebugMode) {
        print("✅ Native mic sender prepared (capture not started yet)");
      }
    }
  }

  Future<void> startMicCaptureIfNeeded() async {
    if (_micCaptureStarted) return;
    _micCaptureStarted = true;

    await nativeMicSender?.startCapture();

    if (debug) {
      if (kDebugMode) {
        print("✅ Native mic capture actually started");
      }
    }
  }

  Future<void> stopMicCaptureIfRunning() async {
    if (!_micCaptureStarted) return;
    _micCaptureStarted = false;

    try {
      await stop();
    } catch (_) {}
  }

  Future<void> stop() async {
    _agentAudioEndsAtMs = 0;
    _startupMuteEndsAtMs = 0;
    _micCaptureStarted = false;

    await nativeMicSender?.stop();
  }

  void onAgentAudioQueued({
    required String base64Audio,
    required int sampleRate,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;

    final int bytes = (base64Audio.length * 3) ~/ 4;
    final int frames = bytes ~/ 2;
    final int chunkMs = ((frames * 1000) / sampleRate).round();
    final int base = _agentAudioEndsAtMs > now ? _agentAudioEndsAtMs : now;

    const int safetyTailMs = 1;

    _agentAudioEndsAtMs = base + chunkMs + safetyTailMs;

    if (debug) {
      if (kDebugMode) {
        print(
          "🎧 queued agent chunk bytes=$bytes frames=$frames chunkMs=$chunkMs agentAudioEndsAtMs=$_agentAudioEndsAtMs now=$now",
        );
      }
    }
  }
}
