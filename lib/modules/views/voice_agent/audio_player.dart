import 'package:flutter/services.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:ntt_data/modules/views/phq/screens/phq_two_questions_screen.dart';

final FlutterSoundPlayer player = FlutterSoundPlayer();

Future<void> initPlayer() async {
  await player.openPlayer();
}

Future<void> disposePlayer() async {
  await player.closePlayer();
}

Future<void> playBeep() async {
  final data = await rootBundle.load('assets/images/phone_hangup.mp3');

  await player.startPlayer(
    fromDataBuffer: data.buffer.asUint8List(),
    codec: Codec.mp3,
    whenFinished: () {
      Get.off(() => PhqTwoQuestionsScreen());
    },
  );
}

Future<void> playVoiceAgent() async {
  final data = await rootBundle.load('assets/images/voice_agent_fixed.wav');
  await player.startPlayer(
    fromDataBuffer: data.buffer.asUint8List(),
    codec: Codec.pcm16WAV,
    whenFinished: () {
      playBeep();
    },
  );
}
