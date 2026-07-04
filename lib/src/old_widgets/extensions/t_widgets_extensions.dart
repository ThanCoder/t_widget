import 'dart:io';

import 'package:flutter/material.dart';

@visibleForTesting
extension TWidgetsDoubleExtension on double {
  @visibleForTesting
  String toFileSizeLabel({int asFixed = 2}) {
    String res = '';
    int pow = 1024;
    final labels = ['byte', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    double size = this;
    while (size > pow) {
      size /= pow;
      i++;
    }

    res = '${size.toStringAsFixed(asFixed)} ${labels[i]}';

    return res;
  }
}

@visibleForTesting
extension TWidgetsIntExtension on int {
  @visibleForTesting
  String getSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }

  @visibleForTesting
  String toFileSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}

@visibleForTesting
extension TWidgetsStringExtension on String {
  @visibleForTesting
  String toCaptalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1, length)}';
  }

  @visibleForTesting
  String getName({bool withExt = true}) {
    final name = split('/').last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  @visibleForTesting
  String get getExt {
    return split('/').last;
  }
}

extension TWidgetsFileExtension on File {
  String getName({bool withExt = true}) {
    final name = path.split('/').last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  @visibleForTesting
  String get getExt {
    return path.split('/').last;
  }

  @visibleForTesting
  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  @visibleForTesting
  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  @visibleForTesting
  int get getSize {
    return statSync().size;
  }

  @visibleForTesting
  DateTime get getDate {
    return statSync().modified;
  }

  @visibleForTesting
  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }

  @visibleForTesting
  String toFileSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}

@visibleForTesting
extension TWidgetsFileSystemEntityExtension on FileSystemEntity {
  String getName({bool withExt = true}) {
    final name = path.split('/').last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  @visibleForTesting
  String get getExt {
    return path.split('/').last;
  }

  @visibleForTesting
  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  @visibleForTesting
  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  @visibleForTesting
  int get getSize {
    return statSync().size;
  }

  @visibleForTesting
  DateTime get getDate {
    return statSync().modified;
  }

  @visibleForTesting
  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }

  @visibleForTesting
  String toFileSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}

@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
@visibleForTesting
extension TWidgetsTPlatform on Platform {
  @visibleForTesting
  static bool get isDesktop {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  @visibleForTesting
  static bool get isMobile {
    return Platform.isAndroid || Platform.isIOS;
  }
}

extension TWidgetsTextEditingControllerExtension on TextEditingController {
  @visibleForTesting
  void selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
