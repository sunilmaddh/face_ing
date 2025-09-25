import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/core/utils/app_methods.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/network_utils.dart';

abstract class BaseApiService {
  final String baseUrl = ApiEndpoints.baseUrl;
  final String api = "/api";
  final isHttps = false;

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    try {
      Uri uri;
      if (isHttps) {
        uri = Uri.https(baseUrl, api + endpoint);
      } else {
        uri = Uri.http(baseUrl, endpoint);
      }

      final response = await http.get(uri);
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await getRequest(endpoint);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> postRequest(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    debugPrint("Access toke $accessToken");
    Uri uri;
    if (isHttps) {
      uri = Uri.https(baseUrl, api + endpoint);
    } else {
      uri = Uri.http(baseUrl, endpoint);
    }

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
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await postRequest(endpoint, data: data);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> loginPostRequest(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    debugPrint("Access toke $accessToken");
    debugPrint("Access toke $baseUrl$endpoint");
    Uri uri;
    if (isHttps) {
      uri = Uri.https(baseUrl, api + endpoint);
    } else {
      uri = Uri.http(baseUrl, endpoint);
    }
    debugPrint(uri.toString());
    debugPrint("Access token $accessToken");
    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(data),
      );
      debugPrint("Access toke $accessToken");
      debugPrint(response.body.toString());
      debugPrint(response.headers.toString());
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await loginPostRequest(endpoint, data: data);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> postRequestWithoutBody(String endpoint) async {
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint(uri.toString());
    try {
      var accessToken = await IndoSharedPreference.instance.getAccessToken();
      ;
      debugPrint("Access toke $accessToken");
      Uri uri;
      if (isHttps) {
        uri = Uri.https(baseUrl, api + endpoint);
      } else {
        uri = Uri.http(baseUrl, endpoint);
      }
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
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await postRequestWithoutBody(endpoint);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> putRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    try {
      Uri uri;
      if (isHttps) {
        uri = Uri.https(baseUrl, api + endpoint);
      } else {
        uri = Uri.http(baseUrl, endpoint);
      }
      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await putRequest(endpoint, data);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    try {
      Uri uri;
      if (isHttps) {
        uri = Uri.https(baseUrl, api + endpoint);
      } else {
        uri = Uri.http(baseUrl, endpoint);
      }
      final response = await http.delete(uri);
      debugPrint(response.headers["accessToken"]);
      if (response.statusCode == 401) {
        String? isAccessToken = await refreshToken();
        if (isAccessToken != null && isAccessToken.isNotEmpty) {
          return await deleteRequest(endpoint);
        }
      }
      return _processResponse(response);
    } catch (e) {
      NetworkUtil.checkInternet(Get.context!);
      throw Exception("Error: $e");
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final decodedBody = utf8.decode(response.bodyBytes);
    debugPrint("${response.statusCode} $decodedBody");
    NetworkUtil.checkInternet(Get.context!);
    final responseBody = jsonDecode(decodedBody);
    switch (response.statusCode) {
      case 200:
      case 201:
        return {
          "statusCode": response.statusCode,
          "responseBody": responseBody,
          "header": response.headers,
        };
      case 400:
      case 403:
      case 404:
      case 500:
        return {
          "statusCode": response.statusCode,
          "responseBody": responseBody,
        };
      default:
        throw Exception("Unknown Error: ${response.statusCode}");
    }
  }

  Future<http.Response?> uploadImage(
    String endpoint,
    filepath,
    String userID,
    String imageType,
    String guestId,
    String isGuest,
  ) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    debugPrint(isGuest.toString());
    debugPrint(guestId.toString());
    debugPrint(imageType.toString());
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint('URL  $uri');
    debugPrint('File  $filepath');
    String endP = "$endpoint/$userID";
    var request = http.MultipartRequest('PUT', Uri.http(baseUrl, endpoint));

    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    request.fields["isSignup"] = imageType;
    request.fields["isGuest"] = isGuest;
    request.fields["guestId"] = guestId;
    debugPrint(request.toString());
    request.headers.addAll({
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken",
    });
    debugPrint(request.toString());
    var response = await request.send();
    http.Response responses = await http.Response.fromStream(response);
    print(response.statusCode);

    return responses;
  }

  Future<String?> refreshToken() async {
    final refreshToken = await IndoSharedPreference.instance.getRefreshToken();
    Uri uri = Uri.http(baseUrl, ApiEndpoints.refreshToken);
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $refreshToken",
    };
    final response = await http.post(uri, headers: header);
    if (response.statusCode == 200) {
      var newAccessToken = header["accesstoken"] ?? "";
      await IndoSharedPreference.instance.saveAccessToken(newAccessToken);
      return newAccessToken;
    } else {
      AppMethods().logout();
      AppSnackbar.show(title: "Error", message: "Session expired");
      return null;
    }
  }
}
