import 'dart:io';

extension FileExtensions on File {
  String get name {
    return uri.pathSegments.last;
  }

  String get nameWithoutExtension {
    return uri.pathSegments.last.split('.').first;
  }
}
