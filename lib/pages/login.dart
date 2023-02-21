import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';
import 'test.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Image.asset('assets/logo-camera.png', fit: BoxFit.fitWidth, width: 250),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'Login'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(border: OutlineInputBorder(), isDense: true, labelText: 'Password'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: 300,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context, PageTransition<Home>(type: PageTransitionType.topToBottom, child: const Home()));
                  },
                  child: const Text('Log in'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, PageTransition<Test>(type: PageTransitionType.topToBottom, child: const Test()));
                  },
                  child: const Text('Test page'),
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
