import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/storage/indo_shared_preference.dart';
import 'package:ntt_data/core/storage/storage_helper.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';

abstract class BaseApiService {
  final String baseUrl = ApiEndpoints.baseUrl;
  // var accessToken =
  //     "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMDAwMDAwMDAxYWJjQGdtYWlsLmNvbSIsImlhdCI6MTc0NjcwNzc2MiwiZXhwIjoxNzQ2Nzk0MTYyfQ.7KEhC0SSYIgK0AZzOHUqsZesft8m5NuOHdLJOLXI4jU";

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
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
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

  Future<Map<String, dynamic>> loginPostRequest(
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    debugPrint("Access toke $accessToken");
    Uri uri = Uri.http(baseUrl, endpoint);
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

      return _processResponse(response);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> postRequestWithoutBody(String endpoint) async {
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint(uri.toString());
    try {
      var accessToken = "";
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
      debugPrint(response.headers["accessToken"]);
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

  Future<http.Response?> uploadImage(
    String endpoint,
    filepath,
    String userID,
    String imageType,
  ) async {
    var accessToken = await IndoSharedPreference.instance.getAccessToken();
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint('URL  $uri');
    debugPrint('File  $filepath');
    String endP = "$endpoint/$userID";
    var request = http.MultipartRequest('PUT', Uri.http(baseUrl, endP));

    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    request.fields["isSignup"] = imageType;

    request.headers.addAll({
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken",
    });
    debugPrint(request.toString());
    var response = await request.send();
    http.Response responses = await http.Response.fromStream(response);
    print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    return responses;
  }

  // Future<void> sendFormDataWithImage(String endpoint, filepath) async {
  //   Uri uri = Uri.http(baseUrl, endpoint);
  //   debugPrint('URL  $uri');
  //   debugPrint('File  $filepath');
  //   String endP = "$endpoint/${"1000000001"}";
  //   final request = http.MultipartRequest('POST', Uri.http(baseUrl, endP));

  //   // Add regular form fields
  //   request.fields['isSignup'] = 'true';

  //   // Detect MIME type (e.g., image/jpeg)
  //   final mimeType = lookupMimeType(filepath.path);
  //   final mimeSplit = mimeType?.split('/') ?? ['application', 'octet-stream'];

  //   // Add image with proper Content-Type
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'file', // <-- your backend expects this field
  //       filepath.path,
  //       contentType: MediaType(mimeSplit[0], mimeSplit[1]),
  //       // filename: basename(imageFile.path),
  //     ),
  //   );

  //   // // Optional: headers like auth
  //   // request.headers['Authorization'] = 'Bearer your_token';

  //   // Send request
  //   final response = await request.send();

  //   final responseBody = await response.stream.bytesToString();
  //   print('Status code: ${response.statusCode}');
  //   print('Response body: $responseBody');
  // }
}
