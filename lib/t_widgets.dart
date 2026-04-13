library;

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:t_widgets/theme/index.dart';

export 'dialogs/index.dart';
export 'downloader/index.dart';
export 'functions/index.dart';
export 'menu/index.dart';
export 'pages/index.dart';
export 'services/index.dart';
export 't_sort/index.dart';
export 'types/index.dart';
export 'views/index.dart';
export 'widgets/index.dart';
export 'choosers/index.dart';
export 'theme/index.dart';

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
    if (initialThemeServices) {
      WidgetsFlutterBinding.ensureInitialized();
      PBrightnessServices.instance.init();
    }
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
