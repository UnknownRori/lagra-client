import 'package:flutter/material.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/item_providers.dart';
import 'package:provider/provider.dart';
import 'package:lagra_client/app.dart';
import 'package:lagra_client/providers/authentication.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (_) => HttpClient()),
      ChangeNotifierProvider(create: (_) => ItemProviders()),
    ],
    child: const App(),
  ));
}
