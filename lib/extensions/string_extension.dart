import 'dart:io';

extension StringExtension on String {
  String toCaptalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1, length)}';
  }

  String getName({bool withExt = true}) {
    final file = File(this);
    if (!withExt) {
      // ext မပါဘူး
      final name = file.uri.pathSegments.last;
      return name.split('.').first;
    }
    return file.uri.pathSegments.last;
  }

  String get getExt {
    final file = File(this);
    return file.uri.pathSegments.last.split('.').last;
  }
}
