import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TImageFile extends StatelessWidget {
  String path;
  String? defaultAssetsPath;
  BoxFit fit;
  double? width;
  double? height;
  double? size;
  double borderRadius;

  TImageFile({
    super.key,
    required this.path,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 5,
    this.size,
  });

  Widget _getImageWidget() {
    if (TWidgets.instance.defaultImageAssetsPath == null) {
      throw Exception('you should called => `await TWidgets.instance.init()`');
    }
    if (TWidgets.instance.defaultImageAssetsPath!.isEmpty) {
      throw Exception('defaultImageAssetsPath is required!');
    }
    defaultAssetsPath = TWidgets.instance.defaultImageAssetsPath;

    final file = File(path);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          TWidgets.showDebugLog('TImageFile: ${error.toString()}');
          return Image.asset(defaultAssetsPath!, fit: fit);
        },
      );
    } else {
      return Image.asset(defaultAssetsPath!, fit: fit);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (size != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(width: size, height: size, child: _getImageWidget()),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _getImageWidget(),
    );
  }
}
