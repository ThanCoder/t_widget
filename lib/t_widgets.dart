library;

import 'dart:io';

import 'package:flutter/widgets.dart';

export 'src/news/partials/material_theme_provider.dart';
export 'src/news/partials/sort_provider.dart';

export 'src/old_widgets/choosers/index.dart';
export 'src/old_widgets/dialogs/index.dart';
export 'src/old_widgets/downloader/index.dart';
export 'src/old_widgets/functions/index.dart';
export 'src/old_widgets/menu/index.dart';
export 'src/old_widgets/pages/index.dart';
export 'src/old_widgets/progress_manager/index.dart';
export 'src/old_widgets/services/index.dart';
export 'src/old_widgets/t_sort/index.dart';
export 'src/old_widgets/theme/index.dart';
export 'src/old_widgets/types/index.dart';
export 'src/old_widgets/views/index.dart';
export 'src/old_widgets/widgets/index.dart';
export 'src/old_widgets/extensions/index.dart';

export 'src/old_widgets/extensions/t_widgets_extensions.dart'
    hide
        TWidgetsDoubleExtension,
        TWidgetsFileExtension,
        TWidgetsFileSystemEntityExtension,
        TWidgetsIntExtension,
        TWidgetsStringExtension,
        TWidgetsTextEditingControllerExtension;

typedef CustomDownloadImageCallback =
    Future<void> Function(
      String url,
      String savePath, {
      void Function(double progress)? onProgress,
      void Function(String error)? onError,
    });
typedef OpenImageFileChooserCallback =
    Future<String?> Function({String? initialDirectory});
typedef OnFileChooserGetCoverPath =
    Future<String> Function(FileSystemEntity file);
typedef ImageCachePathCallback = String Function(String url, String cacheName);

class TWidgets {
  static final TWidgets instance = TWidgets._();
  TWidgets._();
  factory TWidgets() => instance;

  String? defaultImageAssetsPath;
  static bool isDebugPrint = true;
  CustomDownloadImageCallback? onCustomDownloadImage;
  bool Function()? isDarkTheme;
  late Duration Function() getThemeServicesInitDelay;
  OpenImageFileChooserCallback? onOpenImageFileChooser;
  OnFileChooserGetCoverPath? onFileChooserGetCoverPath;
  ImageCachePathCallback? getCachePath;

  Future<void> init({
    required String defaultImageAssetsPath,
    bool isDebugPrint = true,
    CustomDownloadImageCallback? onCustomDownloadImage,
    bool Function()? isDarkTheme,
    OpenImageFileChooserCallback? onOpenImageFileChooser,
    OnFileChooserGetCoverPath? onFileChooserGetCoverPath,
    Duration Function()? getThemeServicesInitDelay,

    ///
    /// all `TImageCache` path
    ///
    ImageCachePathCallback? getCachePath,
    bool initialThemeServices = false,
  }) async {
    isDebugPrint = isDebugPrint;
    this.defaultImageAssetsPath = defaultImageAssetsPath;
    this.onCustomDownloadImage = onCustomDownloadImage;
    this.isDarkTheme = isDarkTheme;
    this.onOpenImageFileChooser = onOpenImageFileChooser;
    this.onFileChooserGetCoverPath = onFileChooserGetCoverPath;
    this.getThemeServicesInitDelay =
        getThemeServicesInitDelay ?? () => Duration(milliseconds: 500);
    this.getCachePath = getCachePath;

    await Future.delayed(Duration.zero);
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
