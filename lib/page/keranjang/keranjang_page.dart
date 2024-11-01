import 'package:flutter/material.dart';
import 'package:lagra_client/page/keranjang/keranjang_mobile.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const KeranjangMobile();
      },
    );
  }
}
