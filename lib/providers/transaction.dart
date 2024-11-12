import 'package:flutter/material.dart';
import 'package:lagra_client/models/keranjang.dart';
import 'package:lagra_client/models/transaction.dart';
import 'package:lagra_client/providers/http_client.dart';

enum PaymentType { paypal, creditCard, bank }

String paymentTypeToString(PaymentType type) {
  switch (type) {
    case PaymentType.paypal:
      return "PAYPAL";
    case PaymentType.creditCard:
      return "CREDIT";
    case PaymentType.bank:
      return "GOPAY";
    default:
      return "PAYPAL";
  }
}

PaymentType stringToPaymentType(String type) {
  switch (type) {
    case "PAYPAL":
      return PaymentType.paypal;
    case "CREDIT":
      return PaymentType.creditCard;
    case "GOPAY":
      return PaymentType.bank;
    default:
      return PaymentType.paypal;
  }
}

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

  Future<bool> checkout(HttpClient client, PaymentType payType) async {
    var response = await client.post({
      "payType": paymentTypeToString(payType),
    }, "/api/v1/transactions");
    if (response["status"] != "success") {
      throw "Fail to checkout";
    }

    return true;
  }

  Future<List<Transaction>> ambilTransaksi(HttpClient client) async {
    var response = await client.get("/api/v1/transactions");
    List<dynamic> data = response["data"]["transactions"];
    var result = data.map((data) => Transaction.fromJson(data)).toList();

    if (response["status"] != "success") {
      throw "Fail to fetch";
    }
    return result;
  }

  Future<DetailTransaction> ambilDetailTransaksi(
      HttpClient client, String uuid) async {
    var response = await client.get("/api/v1/transactions/$uuid");
    var data = response["data"]["transaction"];
    var result = DetailTransaction.fromJson(data);

    if (response["status"] != "success") {
      throw "Fail to fetch";
    }
    return result;
  }
}
