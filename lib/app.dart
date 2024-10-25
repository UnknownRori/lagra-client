import 'package:flutter/material.dart';
import 'package:lagra_client/page/login/login.dart';
import 'package:lagra_client/utils/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lagra",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColor.bg,
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
