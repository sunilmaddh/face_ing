import 'package:flutter/services.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'package:ntt_data/routes/app_routes.dart';

final FlutterSoundPlayer player = FlutterSoundPlayer();

Future<void> initPlayer() async {
  await player.openPlayer();
}

Future<void> disposePlayer() async {
  if (player.isPlaying) {
    await player.stopPlayer();
  }

  await player.closePlayer();
}

Future<void> playBeep() async {
  final data = await rootBundle.load('assets/audio/phone_hangup.mp3');

  await player.startPlayer(
    fromDataBuffer: data.buffer.asUint8List(),
    codec: Codec.mp3,
    whenFinished: () {
      disposePlayer();
      AppMethods().toggleWakelock(true);
      AppNavigation.off(AppRoutes.phqTwoQuestion);
    },
  );
}

Future<void> playVoiceAgent() async {
  final data = await rootBundle.load('assets/audio/voice_agent_fixed.wav');
  await player.startPlayer(
    fromDataBuffer: data.buffer.asUint8List(),
    codec: Codec.pcm16WAV,
    whenFinished: () async {
      await playBeep();
    },
  );
}

Future<void> playDuringCalling() async {
  final data = await rootBundle.load('assets/audio/calling.mp3');
  await player.startPlayer(
    fromDataBuffer: data.buffer.asUint8List(),
    codec: Codec.mp3,
    // whenFinished: () {
    //   playBeep();
    // },
  );
}
