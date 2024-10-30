import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lagra_client/components/text_field.dart';
import 'package:lagra_client/env.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/item_providers.dart';
import 'package:lagra_client/utils/storage.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemMobile extends StatefulWidget {
  final Item item;
  const ItemMobile({super.key, required this.item});

  @override
  _ItemMobileState createState() => _ItemMobileState();
}

class _ItemMobileState extends State<ItemMobile> {
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: Storage.resolve(widget.item.img),
              scale: 0.8,
            ),
          ),
          Container(
            color: AppColor.accent.withOpacity(0.65),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.item.name,
                      style: mobile.subtitle2.copyWith(color: Colors.white)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: AppColor.danger,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: mobile.pagePadding,
            child: Column(
              children: [
                Container(
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (amount > 0) {
                              setState(() {
                                amount--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove)),
                      Text(amount.toString()),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              amount++;
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
