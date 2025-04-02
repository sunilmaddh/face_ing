import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';

abstract class BaseApiService {
  final String baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> postRequest(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    var accessToken = await StorageHelper.read("access-token");
    debugPrint("Access toke $accessToken");
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint(uri.toString());
    debugPrint("Access token $accessToken");
    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(data),
      );
      debugPrint("Access toke $accessToken");
      debugPrint(response.body.toString());
      debugPrint(response.headers.toString());
      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> postRequestWithoutBody(String endpoint) async {
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint(uri.toString());
    try {
      var accessToken = await StorageHelper.read("access-token");
      debugPrint("Access toke $accessToken");
      Uri uri = Uri.http(baseUrl, endpoint);
      debugPrint(uri.toString());
      debugPrint("Access token $accessToken");
      debugPrint(uri.toString());
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      };
      debugPrint(header.toString());
      final response = await http.post(
        uri,
        headers: header,
        // body: jsonEncode(data),
      );
      debugPrint(response.headers.toString());
      debugPrint(response.body.toString());
      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> putRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    debugPrint(response.statusCode.toString() + response.body.toString());
    switch (response.statusCode) {
      case 200:
      case 201:
        return {
          "statusCode": response.statusCode,
          "responseBody": jsonDecode(response.body),
          "header": response.headers,
        };
      case 400:
        return {
          "statusCode": response.statusCode,
          "responseBody": jsonDecode(
            response.body,
          ), // Ensure it's parsed as JSON
        };
      case 401:
      case 403:
        return {
          "statusCode": response.statusCode,
          "responseBody": jsonDecode(response.body),
          // Ensure it's parsed as JSON
        };
      case 404:
        return {
          "statusCode": response.statusCode,
          "responseBody": jsonDecode(
            response.body,
          ), // Ensure it's parsed as JSON
        };
      case 500:
        return {
          "statusCode": response.statusCode,
          "responseBody": jsonDecode(
            response.body,
          ), // Ensure it's parsed as JSON
        };
      default:
        throw Exception("Unknown Error: ${response.statusCode}");
    }
  }
}
