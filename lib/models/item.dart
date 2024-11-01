import 'package:lagra_client/models/category.dart';

class Item {
  String uuid;
  String name;
  int price;
  String img;
  Category category;

  Item({
    required this.uuid,
    required this.name,
    required this.price,
    required this.img,
    required this.category,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      uuid: json['uuid'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      category: Category.fromJson(json['category']),
    );
  }
}
