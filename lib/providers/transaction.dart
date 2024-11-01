import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/models/keranjang.dart';
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

  Future<List<Keranjang>> ambilKeranjang(HttpClient client) async {
    var response = await client.get("/api/v1/carts");
    List<dynamic> data = response["data"]["carts"];
    var result = data.map((data) => Keranjang.fromJson(data)).toList();

    if (response["status"] != "success") {
      throw "Fail to fetch";
    }
    return result;
  }

  Future<bool> checkout(HttpClient client) async {
    var response = await client.post({
      "payType": "GOPAY",
    }, "/api/v1/transactions");
    if (response["status"] != "success") {
      throw "Fail to checkout";
    }

    return true;
  }
}
