import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class RequestPlaceholder extends StatelessWidget {
  const RequestPlaceholder({super.key, required this.placeholder});

  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(child: placeholder);
  }
}

final RequestPlaceholder requestPlaceholderError = RequestPlaceholder(placeholder: Text(localizations.error_error));
const RequestPlaceholder requestPlaceholderLoading = RequestPlaceholder(placeholder: CircularProgressIndicator());
