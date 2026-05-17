library;

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:t_widgets/src/theme/p_brightness_services.dart';

export 'src/choosers/index.dart';
export 'src/dialogs/index.dart';
export 'src/downloader/index.dart';
export 'src/functions/index.dart';
export 'src/menu/index.dart';
export 'src/pages/index.dart';
export 'src/progress_manager/index.dart';
export 'src/services/index.dart';
export 'src/t_sort/index.dart';
export 'src/theme/index.dart';
export 'src/types/index.dart';
export 'src/views/index.dart';
export 'src/widgets/index.dart';
export 'src/extensions/index.dart';

export 'src/extensions/t_widgets_extensions.dart'
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
