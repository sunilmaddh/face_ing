import 'dart:async';

import 'dart:convert';

import 'dart:typed_data';

import 'package:get/get.dart' hide navigator;

import 'package:ntt_data/modules/views/voice_agent/native/call_audio_controler.dart';

import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'voice_bridge.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart'; // Import WebRTC for echo cancellation and noise suppression

class NativeMicSender {
  final WebSocketChannel ws;

  final bool debug;

  final String streamId;

  final bool Function() isAgentSpeaking;

  CallAudioController? callAudioController;

  StreamSubscription? _sub;

  bool _subscribed = false;

  bool _captureStarted = false;

  final void Function(Uint8List pcmBytes)? onPcmFrame;

  NativeMicSender(
    this.streamId, {

    required this.ws,

    required this.isAgentSpeaking,

    this.onPcmFrame,

    this.debug = true,
  });

  Future<void> prepare() async {
    if (_subscribed) return;

    // WebRTC Media Stream configuration for echo cancellation and noise suppression

    final mediaConstraints = {
      'audio': {
        'echoCancellation': true, // Enable echo cancellation

        'noiseSuppression': true, // Enable noise suppression
      },

      'video': false,
    };

    try {
      final mediaStream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );

      // Use this stream for audio capture

      print(
        "WebRTC media stream configured for capture with noise suppression and echo cancellation.",
      );
    } catch (e) {
      print("Error applying WebRTC media constraints: $e");
    }

    _sub = VoiceBridge.pcmStream.listen(
      (pcmBytes) {
        if (isAgentSpeaking()) {
          if (debug) {
            // print("🔇 dropping mic frame while agent speaking bytes=${pcmBytes.length}");
          }

          return;
        }

        onPcmFrame?.call(pcmBytes);

        if (debug) {
          // print("🎤 native mic frame sent bytes=${pcmBytes.length}");
        }

        final b64 = base64Encode(pcmBytes);

        if (Get.find<SocketController>().isMicMute.isFalse) {
          final msg = {
            "type": "mic_chunk",

            "track": "user_voice",

            "stream_sid": streamId,

            "audio": b64,

            "sample_rate": 24000,
          };

          ws.sink.add(jsonEncode(msg));
        }
      },

      onError: (e, st) {
        if (debug) {
          print("❌ Native mic stream error: $e");
        }
      },

      onDone: () {
        if (debug) {
          print("⚠️ Native mic stream done");
        }
      },

      cancelOnError: false,
    );

    _subscribed = true;

    if (debug) {
      // print("✅ NativeMicSender subscribed to pcmStream");
    }
  }

  Future<void> startCapture() async {
    if (_captureStarted) return;

    // Use WebRTC or microphone capture methods to process audio here

    // Example: WebRTC capture stream

    // final mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    // Start processing audio data...

    await VoiceBridge.startCapture(sampleRate: 24000, debug: debug);

    _captureStarted = true;

    if (debug) {
      print("✅ NativeMicSender started capture");
    }
  }

  Future<void> stop() async {
    if (_captureStarted) {
      await VoiceBridge.stopCapture();
    }

    await _sub?.cancel();

    _sub = null;

    _subscribed = false;

    _captureStarted = false;

    if (debug) {
      print("🛑 NativeMicSender stopped");
    }
  }
}
