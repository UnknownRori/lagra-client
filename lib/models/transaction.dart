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

class DetailTransaction {
  String uuid;
  int pay;
  PaymentType payType;
  List<Item> item;

  DetailTransaction(
      {required this.uuid,
      required this.pay,
      required this.payType,
      required this.item});

  factory DetailTransaction.fromJson(Map<String, dynamic> json) {
    var item =
        json["transactionItem"].map((data) => Item.fromJson(data)).toList();

    return DetailTransaction(
      uuid: json['uuid'],
      pay: int.parse(json['pay']),
      payType: stringToPaymentType(json['payType']),
      item: item,
    );
  }
}
