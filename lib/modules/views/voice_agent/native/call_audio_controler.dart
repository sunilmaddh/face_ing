import 'dart:convert';
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

  Future<void> start() async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // startup mute window
    _startupMuteEndsAtMs = now + 2000;

    nativeMicSender = NativeMicSender(
      streamId,
      ws: ws,
      debug: debug,
      isAgentSpeaking: () => isAgentSpeaking,
    );

    if (debug) {
      print("✅ Native mic sender created");
    }

    // subscribe now, but don't start capture yet
    await nativeMicSender!.prepare();

    if (debug) {
      print("✅ Native mic sender prepared (capture not started yet)");
    }
  }

  Future<void> startMicCaptureIfNeeded() async {
    if (_micCaptureStarted) return;
    _micCaptureStarted = true;

    await nativeMicSender?.startCapture();

    if (debug) {
      print("✅ Native mic capture actually started");
    }
  }

  Future<void> stop() async {
    _agentAudioEndsAtMs = 0;
    _startupMuteEndsAtMs = 0;
    _micCaptureStarted = false;

    await nativeMicSender?.stop();
  }

  /// Call this whenever an agent audio chunk is queued for playback.
  /// sampleRate should be the playback sample rate from backend.
  void onAgentAudioQueued({
    required String base64Audio,
    required int sampleRate,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Approx base64 -> bytes
    final int bytes = (base64Audio.length * 3) ~/ 4;

    // PCM16 mono => 2 bytes per sample
    final int frames = bytes ~/ 2;

    // chunk duration
    final int chunkMs = ((frames * 1000) / sampleRate).round();

    // Queue-based extension:
    // if audio already buffered, extend from existing end; otherwise extend from now
    final int base = _agentAudioEndsAtMs > now ? _agentAudioEndsAtMs : now;

    // safety tail: keep mic closed a bit after queued playback finishes
    const int safetyTailMs = 1;

    _agentAudioEndsAtMs = base + chunkMs + safetyTailMs;

    if (debug) {
      print(
        "🎧 queued agent chunk bytes=$bytes frames=$frames chunkMs=$chunkMs agentAudioEndsAtMs=$_agentAudioEndsAtMs now=$now",
      );
    }
  }
}
