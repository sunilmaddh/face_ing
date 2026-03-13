import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? channel;

  Stream? get stream => channel?.stream;

  Future<void> connect(String url) async {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  Future<void> send(Map<String, dynamic> message) async {
    final encoded = jsonEncode(message);
    channel?.sink.add(encoded);
  }

  void disconnect() {
    channel?.sink.close();
  }
}
