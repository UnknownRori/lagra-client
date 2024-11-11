import 'package:flutter/material.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
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

  void tambahKeranjang(HttpClient client, TransactionProvider provider,
      BuildContext context) async {
    var result =
        await provider.tambahKeranjang(client, widget.item.uuid, amount);
    Future.delayed(Duration.zero, () {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColor.primary,
            duration: const Duration(seconds: 1),
            content: const Text("Keranjang berhasil ditambah"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColor.danger,
            duration: Duration(seconds: 1),
            content: Text("Keranjang gagal ditambah"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var client = context.read<HttpClient>();
    var transaction = context.read<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Item"),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                tambahKeranjang(client, transaction, context);
              },
              child: Text(
                "Masukan Keranjang",
                style: mobile.body1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
