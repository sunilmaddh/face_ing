import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';

class Pcm16StreamPlayer {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  static const int sampleRate = 48000;

  // ✅ 40ms @ 48k => 1920 frames => 3840 bytes
  static const int framesPerChunk = 3840;
  static const int chunkBytes = framesPerChunk * 2;

  // ✅ start after ~400ms buffered
  static const int startBufferChunks = 8;

  // ring buffer ~10 seconds
  static const int ringSize = chunkBytes * 250;

  bool _initialized = false;
  bool _started = false;
  bool _pumpStarted = false;
  bool _pumpRunning = false;

  late Uint8List _ring;
  int _w = 0;
  int _r = 0;
  int _count = 0;

  Future<void> init() async {
    if (_initialized) return;
    _ring = Uint8List(ringSize);
    await _player.openPlayer();
    _initialized = true;
  }

  Future<void> start() async {
    if (_started) return;
    await init();

    await _player.startPlayerFromStream(
      codec: Codec.pcm16,
      sampleRate: sampleRate,
      numChannels: 1,
      interleaved: true,
      bufferSize: framesPerChunk,
    );

    // await _player.setVolume(1.0);
    _started = true;
  }

  Future<void> feedBase64Pcm16(String b64) async {
    if (!_started) await start();

    var bytes = base64Decode(b64);
    if (bytes.isEmpty) return;
    if (bytes.length.isOdd) {
      final tmp = Uint8List(bytes.length + 1);
      tmp.setRange(0, bytes.length, bytes);
      tmp[bytes.length] = 0;
      bytes = tmp;
    }

    _writeToRing(bytes);

    if (!_pumpStarted && _count >= chunkBytes * startBufferChunks) {
      _pumpStarted = true;
      _pumpRunning = true;
      _pumpLoop();
    }
  }

  void _writeToRing(Uint8List data) {
    if (data.length > ringSize) {
      data = data.sublist(data.length - ringSize);
    }
    while (_count + data.length > ringSize) {
      _dropBytes(chunkBytes);
    }

    int remaining = data.length;
    int src = 0;

    while (remaining > 0) {
      final spaceToEnd = ringSize - _w;
      final n = remaining < spaceToEnd ? remaining : spaceToEnd;

      _ring.setRange(_w, _w + n, data, src);

      _w = (_w + n) % ringSize;
      _count += n;
      src += n;
      remaining -= n;
    }
  }

  void _dropBytes(int n) {
    final drop = n <= _count ? n : _count;
    _r = (_r + drop) % ringSize;
    _count -= drop;
  }

  Uint8List _readChunkOrSilence() {
    if (_count < chunkBytes) return Uint8List(chunkBytes);

    final out = Uint8List(chunkBytes);
    int remaining = chunkBytes;
    int dst = 0;

    while (remaining > 0) {
      final toEnd = ringSize - _r;
      final n = remaining < toEnd ? remaining : toEnd;

      out.setRange(dst, dst + n, _ring, _r);

      _r = (_r + n) % ringSize;
      _count -= n;
      dst += n;
      remaining -= n;
    }

    return out;
  }

  Future<void> _pumpLoop() async {
    while (_pumpRunning && _started) {
      final out = _readChunkOrSilence();
      await _player.feedUint8FromStream(out);
      await Future.delayed(const Duration(milliseconds: 20));
    }
  }

  Future<void> dispose() async {
    _pumpRunning = false;
    _pumpStarted = false;

    try {
      if (_started) await _player.stopPlayer();
    } catch (_) {}
    try {
      if (_initialized) await _player.closePlayer();
    } catch (_) {}

    _started = false;
    _initialized = false;
    _w = 0;
    _r = 0;
    _count = 0;
  }
}
