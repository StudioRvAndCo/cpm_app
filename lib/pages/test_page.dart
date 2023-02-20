import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cinema Project Manager"),
          centerTitle: true,
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Back")),
        ));
  }
}
