import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'voice_bridge.dart';

class NativeMicSender {
  final WebSocketChannel ws;
  final bool debug;
  final String streamId;
  final bool Function() isAgentSpeaking;

  StreamSubscription? _sub;
  bool _subscribed = false;
  bool _captureStarted = false;

  NativeMicSender(
    this.streamId, {
    required this.ws,
    required this.isAgentSpeaking,
    this.debug = true,
  });

  Future<void> prepare() async {
    if (_subscribed) return;

    _sub = VoiceBridge.pcmStream.listen(
      (pcmBytes) {
        if (isAgentSpeaking()) {
          if (debug) {
            print(
              "🔇 dropping mic frame while agent speaking bytes=${pcmBytes.length}",
            );
          }
          return;
        }

        final b64 = base64Encode(pcmBytes);

        final msg = {
          "type": "mic_chunk",
          "track": "user_voice",
          "stream_sid": streamId,
          "audio": b64,
          "sample_rate": 24000,
        };

        ws.sink.add(jsonEncode(msg));

        if (debug) {
          print("🎤 native mic frame sent bytes=${pcmBytes.length}");
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
      print("✅ NativeMicSender subscribed to pcmStream");
    }
  }

  Future<void> startCapture() async {
    if (_captureStarted) return;

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
