import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/page/home/home_mobile.dart';
import 'package:lagra_client/page/item/item_mobile.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ItemMobile(
          item: item,
        );
      },
    );
  }
}
