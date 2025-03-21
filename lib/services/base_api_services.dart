// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ntt_data/core/utils/api_endpoints.dart';

// abstract class BaseApiService {
//   final String baseUrl = ApiEndpoints.baseUrl; // Change to your API URL

//   Future<Map<String, dynamic>> getRequest(String endpoint) async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl$endpoint'));
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   Future<Map<String, dynamic>> postRequest(String endpoint, {required Map<String, dynamic> data}) async {
   
//    Uri uri=  Uri.parse('$baseUrl$endpoint');
//   //  debugPrint(uri.toString());
//     try {
//       debugPrint(uri.toString());
//       final response = await http.post(
//           uri,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(data),
//       );
//       debugPrint(response.body.toString());
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   Future<Map<String, dynamic>> putRequest(String endpoint, Map<String, dynamic> data) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl$endpoint'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(data),
//       );
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   Future<dynamic> deleteRequest(String endpoint) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }

//   Map<String, dynamic> _processResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//     case 201:
//       return {
//         "statusCode": response.statusCode,
//         "responseBody": jsonDecode(response.body) // Ensure it's parsed as JSON
//       };
//     case 400:
//       return {
//         "statusCode": response.statusCode,
//         "responseBody": jsonDecode(response.body) // Ensure it's parsed as JSON
//       };
//     case 401:
//     case 403:
//      return {
//         "statusCode": response.statusCode,
//         "responseBody": jsonDecode(response.body) // Ensure it's parsed as JSON
//       };
//     case 404:
//       return {
//         "statusCode": response.statusCode,
//         "responseBody": jsonDecode(response.body) // Ensure it's parsed as JSON
//       };
//     case 500:
//      return {
//         "statusCode": response.statusCode,
//         "responseBody": jsonDecode(response.body) // Ensure it's parsed as JSON
//       };
//     default:
//       throw Exception("Unknown Error: ${response.statusCode}");
//   }
// }

// }
/*
Main author: Swaroop
This class uses http methods and creates custom methods to be used while fetching api data
This is to be used with every api calling
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntt_data/core/utils/api_endpoints.dart';       

class BaseClient {
  final String baseUrl = ApiEndpoints.baseUrl;

  final Duration timeoutDuration = const Duration(minutes: 1);
  // final Duration paymentTimeoutDuration = const Duration(minutes: 2);
  //final Duration bankTimeoutDuration = const Duration(minutes: 3);

  final _client = http.Client();

  //get data
  Future<http.Response?> getData(String endpoint) async {
    Uri url = Uri.http(baseUrl, endpoint);
    debugPrint('URL: $url');
    try {
      http.Response response = await _client.get(url).timeout(timeoutDuration);
      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  ///Get data with query params
  // ignore: body_might_complete_normally_nullable
  Future<http.Response?> getDataWithQueryParams(String endpoint,
      {required var data}) async {
    Uri url = Uri.http(baseUrl, endpoint, data);
    debugPrint('URL: $url');
    debugPrint('param data: $data');
    try {
      http.Response response = await _client.get(url).timeout(timeoutDuration);
      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  ///Post data
  Future<http.Response?> postData(String endpoint, {required var data}) async {
     debugPrint('URL: $baseUrl'); 
     debugPrint('URL: $endpoint');
    Uri url = Uri.http(baseUrl, endpoint);
    var body = jsonEncode(data);
    debugPrint('URL: $url');
    debugPrint('Post data: $body');

    try {
      http.Response response = await _client.post(
        url,
        body: body,
        // encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
      ).timeout(timeoutDuration);

      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> postDataWithParam(String endpoint) async {
    Uri url = Uri.http(baseUrl, endpoint);
    // var body = jsonEncode(data);
    debugPrint('URL: $url');
    //  debugPrint('Post data: $body');

    try {
      http.Response response = await _client.post(
        url,
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(timeoutDuration);

      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  ///Put data
  Future<http.Response?> putData(String endpoint, {required var data}) async {
    Uri url = Uri.http(baseUrl, endpoint);
    var body = jsonEncode(data);
    debugPrint('URL: $url');
    debugPrint('Post data: $body');
    try {
      http.Response response = await _client.put(
        url,
        body: body,
        encoding: Encoding.getByName("utf-8"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(timeoutDuration);

      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<http.Response?> deleteCropData(
    String endpoint,
  ) async {
    Uri url = Uri.http(baseUrl, endpoint);
    // var body = jsonEncode(data);
    debugPrint('URL: $url');
    // debugPrint('Post data: $body');

    try {
      http.Response response = await _client
          .delete(
            url,
            // body: body, encoding:
            //Encoding.getByName("utf-8"),
            //  <String, String>{
            //   'Content-Type': 'application/json; charset=UTF-8',
            //   'authorization': 'Bearer $token',
            // },
          )
          .timeout(timeoutDuration);

      debugPrint('response (${response.statusCode}): ${response.body}');
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<http.Response?> uploadImage(
    String endpoint,
    filepath,
  ) async {
    Uri uri = Uri.http(baseUrl, endpoint);
    debugPrint('URL  $uri');
    debugPrint('File  $filepath');

    var request = http.MultipartRequest(
      'POST',
      Uri.http(baseUrl, endpoint),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'Crop_Image',
      filepath,
    ));
    debugPrint(request.toString());
    var response = await request.send();
    http.Response responses = await http.Response.fromStream(response);
    print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    return responses;
  }

  // Future<String?> uploadImage(
  //   String endpoint,
  //   filepath,
  // ) async {
  //   Uri uri = Uri.http(baseUrl, endpoint);
  //   debugPrint('URL  $uri');
  //   debugPrint('File  $filepath');
  //   // debugPrint('Id  $customerUuid');
  //   // debugPrint('Uuid  $propertyUuid');

  //   var request = http.MultipartRequest('POST', Uri.http(baseUrl, endpoint));
  //   // request.fields["customer_id"] = customerUuid;
  //   // request.fields["property_uuid"] = propertyUuid;
  //   request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //   debugPrint(request.toString());
  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  //   return response.reasonPhrase;
  // }

  bool _isVaidResponse(http.Response response) {
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}