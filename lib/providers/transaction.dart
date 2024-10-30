import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> tambahKeranjang(
      HttpClient client, String itemId, int amount) async {
    var response =
        await client.post({"itemId": itemId, "total": amount}, "/api/v1/carts");
    if (response["status"] != "success") {
      throw "Fail to add";
    }

    return true;
  }
}
