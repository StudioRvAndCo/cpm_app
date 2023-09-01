import 'package:flutter/material.dart';

class RequestPlaceholder extends StatelessWidget {
  const RequestPlaceholder({super.key, required this.placeholder});

  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(child: placeholder);
  }
}
