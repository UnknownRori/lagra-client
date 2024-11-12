import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:lagra_client/models/transaction.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
import 'package:lagra_client/utils/storage.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';

class DetailTransaksi extends StatelessWidget {
  String uuid;
  DetailTransaksi({super.key, required this.uuid});

  Future<DetailTransaction> fetchData(BuildContext context) async {
    var client = context.read<HttpClient>();
    var transaction = context.read<TransactionProvider>();
    var result = await transaction.ambilDetailTransaksi(client, uuid);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: mobile.pagePadding,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                Text("Detail Transaksi", style: mobile.body1)
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FutureBuilder(
                  future: fetchData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.item.length,
                        itemBuilder: (context, index) {
                          var item = data.item[index];

                          return Card(
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: Storage.resolve(item.item.img),
                                  scale: 3,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(item.item.name, style: mobile.body1),
                                    const SizedBox(height: 26),
                                    Text(item.total.toString()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text("Kosong!");
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
