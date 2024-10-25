import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lagra_client/env.dart';

class AuthenticationProvider with ChangeNotifier {
  http.Client client = http.Client();
  String token = "";

  Future<bool> Authenticate(String username, String password) async {
    var body = json.encode({"username": username, "password": password});
    var url = Uri.https(Environment.API_URL, 'api/v1/auth/login');
    final response = await client.post(url, body: body, headers: {
      "content-type": "application/json",
    });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if (decodedResponse["status"] == "success") {
      token = decodedResponse["data"]["token"];
      return true;
    }
    return false;
  }
}
