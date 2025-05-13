import 'package:flutter/foundation.dart';

export 'dialogs/index.dart';
export 'widgets/index.dart';

class TWidgets {
  static final TWidgets instance = TWidgets._();
  TWidgets._();
  factory TWidgets() => instance;

  String? defaultImageAssetsPath;
  bool isDebugPrint = true;
  Future<void> Function(String url, String savePath)? onDownloadCacheImage;
  bool Function()? getDarkMode;

  Future<void> init({
    required String defaultImageAssetsPath,
    bool isDebugPrint = false,
    Future<void> Function(String url, String savePath)? onDownloadCacheImage,
    bool Function()? getDarkMode,
  }) async {
    this.defaultImageAssetsPath = defaultImageAssetsPath;
    if (kDebugMode) {
      this.isDebugPrint = isDebugPrint;
    }
    this.onDownloadCacheImage = onDownloadCacheImage;
    this.getDarkMode = getDarkMode;
  }
}
