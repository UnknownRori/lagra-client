import 'dart:convert';

import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/transaction.dart';

class Transaction {
  String uuid;
  int pay;
  PaymentType payType;

  Transaction({required this.uuid, required this.pay, required this.payType});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      uuid: json['uuid'],
      pay: int.parse(json['pay']),
      payType: stringToPaymentType(json['payType']),
    );
  }
}

class TransactionItem {
  String uuid;
  int total;
  Item item;

  TransactionItem(
      {required this.uuid, required this.total, required this.item});
  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      uuid: json['uuid'],
      total: int.parse(json['total']),
      item: Item.fromJson(json['item']),
    );
  }
}

class DetailTransaction {
  String uuid;
  int pay;
  PaymentType payType;
  List<TransactionItem> item;

  DetailTransaction(
      {required this.uuid,
      required this.pay,
      required this.payType,
      required this.item});

  factory DetailTransaction.fromJson(Map<String, dynamic> json) {
    List<dynamic> transItem = json["transactionItem"];
    var item = transItem.map((data) => TransactionItem.fromJson(data)).toList();

    return DetailTransaction(
      uuid: json['uuid'],
      pay: int.parse(json['pay']),
      payType: stringToPaymentType(json['payType']),
      item: item,
    );
  }
}
