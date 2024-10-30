import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lagra_client/env.dart';

class HttpClient with ChangeNotifier {
  http.Client client = http.Client();
  String token = "";

  Future<Map<String, dynamic>> get(String uri) async {
    var url = Uri.https(Environment.API_URL, uri);
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
      "content-type": "application/json",
    });
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return decodedResponse;
  }

  Future<Map<String, dynamic>> post(Object? value, String uri) async {
    var body = json.encode(value);
    var url = Uri.https(Environment.API_URL, uri);
    final response = await client.post(url, body: body, headers: {
      "Authorization": "Bearer $token",
      "content-type": "application/json",
    });
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return decodedResponse;
  }
}
