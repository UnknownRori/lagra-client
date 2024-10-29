import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';

class ItemProviders with ChangeNotifier {
  Future<List<Item>> fetch(HttpClient client) async {
    Map<String, dynamic> response = await client.get("/api/v1/items");
    List<dynamic> data = response["data"]["items"];
    var result = data.map((data) => Item.fromJson(data)).toList();

    if (response["status"] != "success") {
      throw "Failed to fetch";
    }

    return result;
  }
}
