import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? channel;

  Stream? get stream => channel?.stream;

  void connect(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void send(Map<String, dynamic> message) {
    final encoded = jsonEncode(message);
    channel?.sink.add(encoded);
  }

  void disconnect() {
    channel?.sink.close();
  }
}
