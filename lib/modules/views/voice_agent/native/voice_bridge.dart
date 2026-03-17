import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class VoiceBridge {
  static const MethodChannel _method = MethodChannel('voice_bridge/methods');
  static const EventChannel _pcmEvents = EventChannel('voice_bridge/pcm');

  static Stream<Uint8List> get pcmStream {
    return _pcmEvents.receiveBroadcastStream().map((event) {
      if (event is Uint8List) return event;
      if (event is List<int>) return Uint8List.fromList(event);
      throw StateError('Unexpected PCM event type: ${event.runtimeType}');
    });
  }

  static Future<void> startCapture({
    int sampleRate = 24000,
    bool debug = true,
  }) async {
    debugPrint("Called ios native");
    await _method.invokeMethod('startCapture', {
      'sampleRate': sampleRate,
      'debug': debug,
    });
    debugPrint("Called ios native : 3");
  }

  static Future<void> stopCapture() async {
    await _method.invokeMethod('stopCapture');
  }
}
