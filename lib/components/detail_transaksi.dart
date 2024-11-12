import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:lagra_client/models/transaction.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';
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
          ],
        ));
  }
}
