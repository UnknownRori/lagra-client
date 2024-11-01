import 'package:lagra_client/models/item.dart';

class Keranjang {
  String uuid;
  int total;
  Item item;

  Keranjang({required this.uuid, required this.total, required this.item});

  factory Keranjang.fromJson(Map<String, dynamic> json) {
    return Keranjang(
      uuid: json['uuid'],
      total: json['total'],
      item: Item.fromJson(json['item']),
    );
  }
}
