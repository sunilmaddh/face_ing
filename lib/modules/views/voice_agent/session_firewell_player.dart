import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

/// ======================================================
/// SESSION FAREWELL PLAYER
/// Plays local WAV after current agent audio completes
/// ======================================================
class SessionFarewellPlayer {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _opened = false;
  bool _playing = false;

  Future<void> init() async {
    if (_opened) return;
    await _player.openPlayer();
    _opened = true;
  }

  Future<void> playAssetAndWait(String assetPath) async {
    await init();

    final data = await rootBundle.load(assetPath);
    final completer = Completer<void>();

    _playing = true;

    await _player.startPlayer(
      fromDataBuffer: data.buffer.asUint8List(),
      codec: Codec.pcm16WAV,
      whenFinished: () {
        _playing = false;
        if (!completer.isCompleted) completer.complete();
      },
    );

    await completer.future;
  }

  Future<void> stop() async {
    try {
      if (_playing) {
        await _player.stopPlayer();
      }
    } catch (_) {}
    _playing = false;
  }

  Future<void> dispose() async {
    try {
      await stop();
    } catch (_) {}
    try {
      if (_opened) {
        await _player.closePlayer();
      }
    } catch (_) {}
    _opened = false;
  }
}
