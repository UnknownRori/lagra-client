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
