import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lagra_client/app.dart';
import 'package:lagra_client/providers/authentication.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
    ],
    child: const App(),
  ));
}
