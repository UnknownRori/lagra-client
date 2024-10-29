import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';

class ItemProviders with ChangeNotifier {
  Future<List<Item>> fetch(HttpClient client) async {
    var response = await client.get("/api/v1/items");

    print(response);
    if (response["status"] != "success") {
      throw "Failed to fetch";
    }

    return response["data"];
  }
}
