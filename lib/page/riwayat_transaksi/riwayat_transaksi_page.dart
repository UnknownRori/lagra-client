import 'package:flutter/material.dart';
import 'package:lagra_client/page/riwayat_transaksi/riwayat_transaksi_mobile.dart';

class RiwayatTransaksiMobile extends StatelessWidget {
  const RiwayatTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const Text("Riwayat Transaksi");
      },
    );
  }
}
