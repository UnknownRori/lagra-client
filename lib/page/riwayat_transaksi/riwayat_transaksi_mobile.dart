import 'package:flutter/material.dart';
import 'package:lagra_client/models/transaction.dart';
import 'package:provider/provider.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/transaction.dart';

class RiwayatTransaksiMobile extends StatelessWidget {
  const RiwayatTransaksiMobile({super.key});

  Future<List<Transaction>> fetchData(BuildContext context) async {
    print("Yo");
    var client = context.read<HttpClient>();
    var transaction = context.read<TransactionProvider>();
    var result = await transaction.ambilTransaksi(client);
    return result;
  }

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
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(data[index].uuid),
                  );
                },
              );
            }
            return const Text("Transaksi Kosong");
          }),
    );
  }
}
