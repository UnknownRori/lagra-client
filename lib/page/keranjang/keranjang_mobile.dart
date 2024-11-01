import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lagra_client/models/keranjang.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
import 'package:lagra_client/utils/storage.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';

class KeranjangMobile extends StatefulWidget {
  const KeranjangMobile({super.key});

  @override
  _KeranjangMobileState createState() => _KeranjangMobileState();
}

class _KeranjangMobileState extends State<KeranjangMobile> {
  List<Keranjang> _keranjang = [];

  void fetchItem(HttpClient client, TransactionProvider provider) async {
    var item = await provider.ambilKeranjang(client);
    print(item);
    setState(() {
      _keranjang = item;
    });
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!context.mounted) return;

      HttpClient client = context.read<HttpClient>();
      TransactionProvider transaction = context.read<TransactionProvider>();
      fetchItem(client, transaction);
    });
  }

  void checkout(HttpClient client, TransactionProvider transaction) async {
    var result = await transaction.checkout(client);

    if (!context.mounted) return;

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColor.danger.withOpacity(0.8),
          content: Text("Checkout gagal!", style: mobile.body2),
          duration: const Duration(seconds: 1)));
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColor.primary.withOpacity(0.8),
        content: Text("Checkout berhasil!", style: mobile.body2),
        duration: const Duration(seconds: 1)));

    fetchItem(client, transaction);
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: _keranjang
                  .map(
                    (keranjang) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: Storage.resolve(keranjang.item.img),
                              scale: 3,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(keranjang.item.name, style: mobile.body1),
                                const SizedBox(height: 26),
                                Text(keranjang.total.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            () {
              if (_keranjang.isNotEmpty) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        checkout(client, transaction);
                      },
                      child: Text("Checkout", style: mobile.body1)),
                );
              }
              return Center(
                child: Text("Keranjang anda kosong!", style: mobile.body1),
              );
            }(),
          ],
        ),
      ),
    );
  }
}
