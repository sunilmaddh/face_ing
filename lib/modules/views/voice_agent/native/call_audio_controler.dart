import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide navigator;
import 'package:ntt_data/modules/views/phq/screens/ai_session_call_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'native_mic_sender.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart'; // Import WebRTC for echo cancellation and noise suppression

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

  // VAD flag for detecting speech
  bool _isUserSpeaking = false;

  // Threshold for detecting speech based on signal strength (you may want to fine-tune this)
  final int _speechThreshold =
      100050; // Adjusted threshold for speech detection

  // Time to keep speech activity above threshold before marking it as active (in milliseconds)
  final int _speechDetectionDuration =
      3000; // 3 seconds threshold for continuous speech

  // Last time we detected speech
  int _lastSpeechDetectionTime = 0;

  // Time to consider silence as "inactive"
  final int _silenceThreshold = 3000; // 3 seconds of silence before resetting

  // Flag to track if agent is speaking (use this to skip agent's voice)
  bool _isAgentSpeaking = false;

  CallAudioController({
    required this.ws,
    required this.streamId,
    this.debug = true,
  });

  bool get isAgentSpeaking {
    // Implement the logic to detect if the agent is speaking (this can be done via timestamps or other methods)
    return _isAgentSpeaking;
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
      onPcmFrame: (pcm) {
        onUserAudioStream(pcm);
      },
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

    // Apply WebRTC Audio Settings for Echo Cancellation and Noise Suppression
    await _applyWebRTCConstraints();
  }

  // Apply WebRTC Audio Constraints for echo cancellation and noise suppression
  Future<void> _applyWebRTCConstraints() async {
    try {
      final mediaConstraints = {
        'audio': {
          'echoCancellation': true, // Enable echo cancellation
          'noiseSuppression': true, // Enable noise suppression
        },
        'video': false,
      };

      final mediaStream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );
      // Successfully applied WebRTC audio constraints for Echo Cancellation and Noise Suppression
      print("WebRTC media constraints applied successfully.");
    } catch (e) {
      print("Error applying WebRTC constraints: $e");
    }
  }

  void _startSpeechDurationTimer() {
    debugPrint("Before 1 $_activeSpeechDuration");
    // Start a timer that checks every second if the user is speaking
    _speechDurationTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      debugPrint("Before 2 $_activeSpeechDuration");
      if (_micCaptureStarted && _isUserSpeaking) {
        debugPrint("Before $_activeSpeechDuration");

        // Increment the active speech duration if the user is speaking
        _activeSpeechDuration += 1000; // Increment by 1 second

        debugPrint("After $_activeSpeechDuration");

        if (_activeSpeechDuration >= 60000) {
          // End the call if speech duration exceeds 60 seconds
          debugPrint("Ending call after 60 seconds of active speech.");
          Get.find<AiSessionController>().endSessionGracefully();
          await stop();
        }
      }
    });
  }

  // Detect speech activity and update the _isUserSpeaking flag
  // void _detectSpeechActivity(Uint8List pcmData) {
  //   // Calculate the volume (energy level) of the audio data
  //   int energy = pcmData.fold(0, (prev, elem) => prev + elem.abs());

  //   debugPrint("Energy: $energy");

  //   // If the energy exceeds the threshold and is sustained for a duration, consider it speech
  //   if (energy > _speechThreshold) {
  //     final timeDiff =
  //         DateTime.now().millisecondsSinceEpoch - _lastSpeechDetectionTime;

  //     debugPrint("Last speech detection time: $_lastSpeechDetectionTime");
  //     debugPrint("Time difference: $timeDiff");

  //     // Only mark as speaking if we've been detecting speech for a certain duration
  //     if (_lastSpeechDetectionTime == 0 ||
  //         timeDiff > _speechDetectionDuration) {
  //       _isUserSpeaking = true; // User is speaking
  //       _lastSpeechDetectionTime =
  //           DateTime.now().millisecondsSinceEpoch; // Reset the time
  //       debugPrint(
  //         "Speech detected, updating _lastSpeechDetectionTime: $_lastSpeechDetectionTime",
  //       );
  //     }
  //   } else {
  //     // If we are silent for a long period, reset the state
  //     if (DateTime.now().millisecondsSinceEpoch - _lastSpeechDetectionTime >
  //         _silenceThreshold) {
  //       _isUserSpeaking = false; // User is silent
  //       _activeSpeechDuration = 0; // Reset active speech time
  //       debugPrint("No speech detected for a while, resetting to silent.");
  //     }
  //   }

  //   // Ignore agent's voice if detected as active speech
  //   if (_isAgentSpeaking) {
  //     _isUserSpeaking = false;
  //   }

  //   debugPrint("Is User Speaking: $_isUserSpeaking");
  // }
  void _detectSpeechActivity(Uint8List pcmData) {
    // Calculate the volume (energy level) of the audio data
    int energy = pcmData.fold(0, (prev, elem) => prev + elem.abs());

    debugPrint("Energy: $energy");

    // If the energy exceeds the threshold and is sustained for a duration, consider it speech
    if (energy > _speechThreshold) {
      final timeDiff =
          DateTime.now().millisecondsSinceEpoch - _lastSpeechDetectionTime;

      debugPrint("Last speech detection time: $_lastSpeechDetectionTime");
      debugPrint("Time difference: $timeDiff");

      // Only mark as speaking if we've been detecting speech for a certain duration
      if (_lastSpeechDetectionTime == 0 ||
          timeDiff > _speechDetectionDuration) {
        _isUserSpeaking = true; // User is speaking
        _lastSpeechDetectionTime =
            DateTime.now().millisecondsSinceEpoch; // Reset the time
        debugPrint(
          "Speech detected, updating _lastSpeechDetectionTime: $_lastSpeechDetectionTime",
        );
      }
    } else {
      // If we are silent for a long period, reset the state
      if (DateTime.now().millisecondsSinceEpoch - _lastSpeechDetectionTime >
          _silenceThreshold) {
        _isUserSpeaking = false; // User is silent
        _activeSpeechDuration = 0; // Reset active speech time
        debugPrint("No speech detected for a while, resetting to silent.");
      }
    }

    // Ignore agent's voice if detected as active speech
    if (_isAgentSpeaking) {
      _isUserSpeaking = false;
    }

    debugPrint("Is User Speaking: $_isUserSpeaking");
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

  // Handle PCM audio stream and detect speech
  void onUserAudioStream(Uint8List pcmData) {
    debugPrint("Is User Speaking: $_isUserSpeaking");
    // Detect if the user is speaking
    _detectSpeechActivity(pcmData);
  }
}
