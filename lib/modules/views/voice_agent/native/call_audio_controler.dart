import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

  // Track active speech duration (in milliseconds)
  int _activeSpeechDuration = 0;
  Timer? _speechDurationTimer;

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
      print("✅ Native mic sender created");
    }

    await nativeMicSender!.prepare();

    if (debug) {
      print("✅ Native mic sender prepared (capture not started yet)");
    }

    // Start tracking active speech duration
    _startSpeechDurationTimer();
  }

  void _startSpeechDurationTimer() async {
    // Start a timer that checks every second if the user is speaking
    _speechDurationTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_micCaptureStarted) {
        debugPrint("Before $_activeSpeechDuration");

        // Here, we check if the user is speaking by verifying if the mic capture is running
        _activeSpeechDuration += 1000; // Increment by 1 second

        debugPrint("After $_activeSpeechDuration");

        if (_activeSpeechDuration >= 60000) {
          // End the call if speech duration exceeds 60 seconds
          debugPrint("Ending call after 60 seconds of active speech.");
          await stop();
        }
      }
    });
  }

  Future<void> startMicCaptureIfNeeded() async {
    if (_micCaptureStarted) return;
    _micCaptureStarted = true;

    await nativeMicSender?.startCapture();

    if (debug) {
      print("✅ Native mic capture actually started");
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
    _speechDurationTimer?.cancel(); // Stop the timer when call ends

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
      print(
        "🎧 queued agent chunk bytes=$bytes frames=$frames chunkMs=$chunkMs agentAudioEndsAtMs=$_agentAudioEndsAtMs now=$now",
      );
    }
  }
}
