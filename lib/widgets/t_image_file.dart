import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TImageFile extends StatelessWidget {
  final String path;
  final String? defaultAssetsPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? size;
  final double borderRadius;
  final FilterQuality filterQuality;
  final FrameBuilderCallback? frameBuilder;
  final ErrorBuilderCallback? errorBuilder;

  const TImageFile({
    super.key,
    required this.path,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 5,
    this.size,
    this.errorBuilder,
    this.frameBuilder,
    this.filterQuality = FilterQuality.medium,
  });

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

  Widget _getImageWidget() {
    if (TWidgets.instance.defaultImageAssetsPath == null) {
      throw Exception('you should called => `await TWidgets.instance.init()`');
    }
    if (TWidgets.instance.defaultImageAssetsPath!.isEmpty) {
      throw Exception('defaultImageAssetsPath is required!');
    }

    final file = File(path);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: fit,
        width: width,
        height: height,
        frameBuilder: frameBuilder,
        filterQuality: filterQuality,
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) {
              TWidgets.showDebugLog('TImageFile: ${error.toString()}');
              file.deleteSync();
              return Image.asset(defaultAssetsPath!, fit: fit);
            },
      );
    } else {
      return Image.asset(
        defaultAssetsPath ?? TWidgets.instance.defaultImageAssetsPath!,
        fit: fit,
      );
    }
  }
}
