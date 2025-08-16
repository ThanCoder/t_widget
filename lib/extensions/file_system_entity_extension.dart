import 'dart:io';

import 'package:t_widgets/extensions/double_extension.dart';

extension FileSystemEntityExtension on FileSystemEntity {
  String getName({bool withExt = true}) {
    if (!withExt) {
      // ext မပါဘူး
      final name = uri.pathSegments.last;
      return name.split('.').first;
    }
    return uri.pathSegments.last;
  }

  String get getExt {
    return uri.pathSegments.last.split('.').last;
  }

  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
