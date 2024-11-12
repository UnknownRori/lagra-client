import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lagra_client/components/detail_transaksi.dart';
import 'package:provider/provider.dart';

import 'package:lagra_client/models/transaction.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
import 'package:lagra_client/utils/theme.dart';

class RiwayatTransaksiMobile extends StatelessWidget {
  const RiwayatTransaksiMobile({super.key});

  Future<List<Transaction>> fetchData(BuildContext context) async {
    var client = context.read<HttpClient>();
    var transaction = context.read<TransactionProvider>();
    var result = await transaction.ambilTransaksi(client);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Riwayat Transaksi"),
      ),
      body: FutureBuilder(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return Padding(
                padding: mobile.pagePadding,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var pay = formatter.format(data[index].pay);
                    var uuid = data[index].uuid.substring(0, 8);
                    return Card(
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return DetailTransaksi(uuid: uuid);
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("# Transaksi - $uuid",
                                  style: mobile.subtitle2),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(pay, style: mobile.body2),
                                  Text("22/11/2024", style: mobile.smallsub2)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Text("Transaksi Kosong");
          }),
    );
  }
}
