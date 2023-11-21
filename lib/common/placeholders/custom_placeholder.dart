// ignore_for_file: must_be_immutable

import 'package:cpm/common/placeholders/empty_placeholder.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomPlaceholder extends StatelessWidget {
  CustomPlaceholder.empty(EmptyPlaceholder emptyPlaceholder, {super.key}) {
    final color = Theme.of(navigatorKey.currentContext!).colorScheme.surfaceVariant;
    placeholder = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          emptyPlaceholder.icon,
          size: Sizes.size64.size,
          color: color,
        ),
        Padding(padding: Paddings.padding8.vertical),
        Text(
          emptyPlaceholder.label,
          style: Theme.of(navigatorKey.currentContext!).textTheme.titleMedium?.copyWith(color: color),
        ),
      ],
    );
  }

  CustomPlaceholder.loading({super.key}) {
    placeholder = const CircularProgressIndicator();
  }

  CustomPlaceholder.error({super.key}) {
    placeholder = Text(localizations.error_error);
  }

  late Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: placeholder,
    );
  }
}
