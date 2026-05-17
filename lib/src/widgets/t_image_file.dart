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
  final int? cacheWidth;
  final int? cacheHeight;
  final double scale;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final bool isAntiAlias;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;

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
    this.cacheHeight,
    this.cacheWidth,
    this.scale = 1.0,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
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
      return Center(
        child: Text(
          'you should called => `await TWidgets.instance.init()`',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
      // throw Exception('you should called => `await TWidgets.instance.init()`');
    }
    if (TWidgets.instance.defaultImageAssetsPath!.isEmpty) {
      return Center(
        child: Text(
          'defaultImageAssetsPath is required!',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
      // throw Exception('defaultImageAssetsPath is required!');
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
        scale: scale,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        color: color,
        opacity: opacity,
        colorBlendMode: colorBlendMode,
        alignment: alignment,
        repeat: repeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
      );
    } else {
      return Image.asset(
        defaultAssetsPath ?? TWidgets.instance.defaultImageAssetsPath!,
        fit: fit,
        width: width,
        height: height,
        frameBuilder: frameBuilder,
        filterQuality: filterQuality,
        scale: scale,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        color: color,
        opacity: opacity,
        colorBlendMode: colorBlendMode,
        alignment: alignment,
        repeat: repeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
      );
    }
  }
}
