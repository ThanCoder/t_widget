import 'dart:io';

import 'package:flutter/foundation.dart';

export 'dialogs/index.dart';
export 'widgets/index.dart';
export 'functions/index.dart';
export 'views/index.dart';
export 'pages/index.dart';
export 'services/index.dart';
export 'choosers/index.dart';
export 'types/index.dart';
export 't_sort/index.dart';
export 'menu/index.dart';

typedef DownloadImageCallback =
    Future<void> Function(String url, String savePath);
typedef OpenImageFileChooserCallback =
    Future<String?> Function({String? initialDirectory});
typedef OnFileChooserGetCoverPath =
    Future<String> Function(FileSystemEntity file);

class TWidgets {
  static final TWidgets instance = TWidgets._();
  TWidgets._();
  factory TWidgets() => instance;

  String? defaultImageAssetsPath;
  static bool isDebugPrint = true;
  DownloadImageCallback? onDownloadImage;
  late bool Function() getDarkMode;
  OpenImageFileChooserCallback? onOpenImageFileChooser;
  OnFileChooserGetCoverPath? onFileChooserGetCoverPath;

  Future<void> init({
    required String defaultImageAssetsPath,
    bool isDebugPrint = true,
    DownloadImageCallback? onDownloadImage,
    bool Function()? getDarkMode,
    OpenImageFileChooserCallback? onOpenImageFileChooser,
    OnFileChooserGetCoverPath? onFileChooserGetCoverPath,
  }) async {
    isDebugPrint = isDebugPrint;
    this.defaultImageAssetsPath = defaultImageAssetsPath;
    this.onDownloadImage = onDownloadImage;
    this.getDarkMode = getDarkMode ?? () => false;
    this.onOpenImageFileChooser = onOpenImageFileChooser;
    this.onFileChooserGetCoverPath = onFileChooserGetCoverPath;
  }

  static void showDebugLog(String msg, {String? tag}) {
    if (isDebugPrint) {
      if (tag != null) {
        debugPrint('[$tag]: $msg');
        return;
      }
      debugPrint(msg);
    }
  }

  static String get getOnDownloadImageErrorText {
    return '''await TWidgets.instance.init''';
  }
}
