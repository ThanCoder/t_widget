import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TCacheImage extends StatelessWidget {
  final String url;
  final String? defaultAssetsPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? size;
  final double borderRadius;
  final FilterQuality filterQuality;
  final LoadingBuilderCallback? loadingBuilder;
  final FrameBuilderCallback? frameBuilder;
  final ErrorBuilderCallback? errorBuilder;

  const TCacheImage({
    super.key,
    required this.url,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.size,
    this.borderRadius = 5,
    this.filterQuality = FilterQuality.medium,
    this.errorBuilder,
    this.frameBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final cacheFile = File(TWidgets.instance.getCachePath?.call(url) ?? '');
    if (cacheFile.existsSync()) {
      return TImageFile(
        key: key,
        path: cacheFile.path,
        errorBuilder: _errorBuilder,
        frameBuilder: frameBuilder,
        borderRadius: borderRadius,
        defaultAssetsPath: defaultAssetsPath,
        filterQuality: filterQuality,
        fit: fit,
        height: height,
        width: width,
        size: size,
      );
    }
    return FutureBuilder(
      future: TWidgets.instance.onDownloadImage?.call(url, cacheFile.path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TLoader.random();
        }
        return TImageFile(
          key: key,
          path: cacheFile.path,
          errorBuilder: _errorBuilder,
          frameBuilder: frameBuilder,
          borderRadius: borderRadius,
          defaultAssetsPath: defaultAssetsPath,
          filterQuality: filterQuality,
          fit: fit,
          height: height,
          width: width,
          size: size,
        );
      },
    );
  }

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return TImage(
      key: key,
      source: url,
      borderRadius: borderRadius,
      defaultAssetsPath: defaultAssetsPath,
      filterQuality: filterQuality,
      fit: fit,
      height: height,
      width: width,
      size: size,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
    );
  }
}
