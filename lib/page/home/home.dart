import 'package:flutter/material.dart';
import 'package:lagra_client/page/home/home_mobile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const HomeMobile();
      },
    );
  }
}
