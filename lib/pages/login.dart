import 'package:flutter/material.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.onLogin});

  final void Function(String, String) onLogin;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: Image.asset('assets/logo-camera.png', fit: BoxFit.fitWidth, width: 250),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: usernameController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'Username'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'Password'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: 300,
                    child: FilledButton(
                      onPressed: () {
                        widget.onLogin(usernameController.text, passwordController.text);
                      },
                      child: const Text('Log in'),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ));
  }
}
