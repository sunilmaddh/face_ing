import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/voice_agent/native/call_audio_controler.dart';
import 'package:ntt_data/modules/views/voice_agent/socket_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'voice_bridge.dart';

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

        onPcmFrame?.call(pcmBytes);
        // callAudioController?.onUserAudioStream(pcmBytes);
        if (debug) {
          print("🎤 native mic frame sent bytes=${pcmBytes.length}");
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
