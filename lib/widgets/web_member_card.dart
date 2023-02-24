import 'package:flutter/material.dart';

class WebMemberCard extends StatelessWidget {
  const WebMemberCard(
      {super.key,
      required this.name,
      required this.phone,
      required this.picture});

  final String name;
  final String phone;
  final Image picture;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
                width: 120,
                height: 120,
                child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: picture)),
            const SizedBox(width: 16),
            Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleLarge),
                    Text(phone, style: Theme.of(context).textTheme.labelLarge)
                  ],
                ))
          ],
        ));
  }
}
