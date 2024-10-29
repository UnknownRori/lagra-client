import 'package:flutter/material.dart';
import 'package:lagra_client/providers/http_client.dart';

class AuthenticationProvider with ChangeNotifier {
  Future<bool> authenticate(
      HttpClient client, String username, String password) async {
    Map decodedResponse = await client.post(
      {"username": username, "password": password},
      'api/v1/auth/login',
    );
    if (decodedResponse["status"] == "success") {
      client.token = decodedResponse["data"]["token"];
      return true;
    }
    return false;
  }
}
