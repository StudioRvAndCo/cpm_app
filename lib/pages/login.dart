import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema Project Manager'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FittedBox(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 15,
            children: [
              Image.asset('assets/logo-camera.png', fit: BoxFit.fitWidth),
              const SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Login'),
                ),
              ),
              const SizedBox(
                width: 200,
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Password'),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 20,
                children: [
                  TextButton(
                      onPressed: () {}, child: const Text('Forgot password?')),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return const DesktopHomePage();
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                            transitionDuration:
                                const Duration(milliseconds: 100)));
                      },
                      child: const Text('Log in'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
