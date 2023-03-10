import 'package:flutter/material.dart';

class RequestPlaceholder extends StatelessWidget {
  const RequestPlaceholder({super.key, required this.placeholder});

  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              placeholder,
            ],
          ),
        ),
      ],
    );
  }
}
