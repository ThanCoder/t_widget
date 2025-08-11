import 'package:flutter/foundation.dart';

export 'dialogs/index.dart';
export 'widgets/index.dart';
export 'functions/index.dart';
export 'views/index.dart';
export 'pages/index.dart';
export 'services/index.dart';
export 'choosers/index.dart';
export 'types/index.dart';

class TWidgets {
  static final TWidgets instance = TWidgets._();
  TWidgets._();
  factory TWidgets() => instance;

  String? defaultImageAssetsPath;
  static bool isDebugPrint = true;
  Future<void> Function(String url, String savePath)? onDownloadImage;
  late bool Function() getDarkMode;
  Future<String?> Function({String? initialDirectory})? onOpenImageFileChooser;

  Future<void> init({
    required String defaultImageAssetsPath,
    bool isDebugPrint = true,
    Future<void> Function(String url, String savePath)? onDownloadImage,
    bool Function()? getDarkMode,
    Future<String?> Function({String? initialDirectory})?
    onOpenImageFileChooser,
  }) async {
    this.defaultImageAssetsPath = defaultImageAssetsPath;
    isDebugPrint = isDebugPrint;
    this.onDownloadImage = onDownloadImage;
    this.getDarkMode = getDarkMode ?? () => false;
    this.onOpenImageFileChooser = onOpenImageFileChooser;
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
