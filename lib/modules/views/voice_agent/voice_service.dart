import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BaseVoiceApiService {
  Future<Map<String, dynamic>> postRequest({
    required dynamic data,
    required String userName,
  }) async {
    final uri = Uri.parse(
      "https://dev.sourcebytes.ai/api/v1/voice_agent/web/voice/webhook/909ea670-d488-4601-bc8a-01627516631f/",
    );

    debugPrint("URL: $uri");

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      return {"statusCode": response.statusCode, "responseBody": response.body};
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
