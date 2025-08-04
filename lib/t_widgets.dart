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
  bool isDebugPrint = true;
  Future<void> Function(String url, String savePath)? onDownloadImage;
  late bool Function() getDarkMode;
  List<String> Function({String? initialDirectory})? onOpenFilesChooser;

  Future<void> init({
    required String defaultImageAssetsPath,
    bool isDebugPrint = false,
    Future<void> Function(String url, String savePath)? onDownloadImage,
    bool Function()? getDarkMode,
    List<String> Function({String? initialDirectory})? onOpenFilesChooser,
  }) async {
    this.defaultImageAssetsPath = defaultImageAssetsPath;
    this.isDebugPrint = isDebugPrint;
    this.onDownloadImage = onDownloadImage;
    this.getDarkMode = getDarkMode ?? () => false;
    this.onOpenFilesChooser = onOpenFilesChooser;
  }

  void showDebugLog(String msg) {
    if (isDebugPrint) {
      debugPrint(msg);
    }
  }

  String get getOnDownloadImageErrorText {
    return '''await TWidgets.instance.init(
          onDownloadImage: (url, savePath) async {
          //your logic here
          },
        );''';
  }
}
