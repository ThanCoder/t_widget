import 'dart:io';

import 'package:t_widgets/extensions/double_extension.dart';


extension FileExtension on File {
  String getName({bool withExt = true}) {
    final name = path.split('/').last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  String get getExt {
    return path.split('/').last;
  }

  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  int get getSize {
    return statSync().size;
  }



  DateTime get getDate {
    return statSync().modified;
  }

  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
