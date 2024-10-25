import 'package:flutter/material.dart';
import 'package:lagra_client/components/text_field.dart';
import 'package:lagra_client/providers/authentication.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;

  Future<bool> login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _usernameController.text;

    bool result = await context
        .read<AuthenticationProvider>()
        .Authenticate(username, password);

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColor.danger.withOpacity(0.8),
          content: Text("Invalid password or username!", style: mobile.body2),
          duration: const Duration(seconds: 1)));
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColor.primary.withOpacity(0.8),
        content: Text("Login successfully!", style: mobile.body2),
        duration: const Duration(seconds: 1)));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: mobile.pagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Lagra",
                  style: mobile.title.copyWith(color: AppColor.primary),
                ),
                const SizedBox(
                  height: 26,
                ),
                Text("Login", style: mobile.subtitle2),
                BorderTextField(controller: _usernameController),
                const SizedBox(
                  height: 16,
                ),
                BorderTextField(
                  controller: _passwordController,
                  obscureText: !showPassword,
                  inputDecoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: showPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => login(context),
                      child: Text("Login", style: mobile.body1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
