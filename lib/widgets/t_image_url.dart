import 'package:flutter/material.dart';

import '../t_widgets.dart';

class TImageUrl extends StatelessWidget {
  final String url;
  final String? defaultAssetsPath;
  final LoadingBuilderCallback? loadingBuilder;
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

  const TImageUrl({
    super.key,
    required this.url,
    this.defaultAssetsPath,
    this.loadingBuilder,
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
    if (url.isEmpty) {
      return Image.asset(defaultAssetsPath!, fit: fit);
    } else {
      return Image.network(
        url,

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
        loadingBuilder:
            loadingBuilder ??
            (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: TLoader.random());
            },
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
      );
    }
  }
}
