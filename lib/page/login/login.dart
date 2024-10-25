import 'package:flutter/material.dart';
import 'package:lagra_client/page/login/login_mobile.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const LoginMobile();
      },
    );
  }
}
