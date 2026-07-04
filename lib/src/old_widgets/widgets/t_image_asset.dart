import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TImageAsset extends StatelessWidget {
  final String assetPath;
  final String? defaultAssetsPath;
  final double? size;
  final double borderRadius;
  final AssetBundle? bundle;
  final Widget Function(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  )?
  frameBuilder;
  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  )?
  errorBuilder;
  final double? scale;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final AlignmentGeometry alignment = Alignment.center;
  final ImageRepeat repeat = ImageRepeat.noRepeat;
  final FilterQuality filterQuality = FilterQuality.medium;
  final int? cacheWidth;
  final int? cacheHeight;
  const TImageAsset({
    super.key,
    required this.assetPath,
    this.size,
    this.borderRadius = 5,
    this.defaultAssetsPath,
    this.bundle,
    this.frameBuilder,
    this.errorBuilder,
    this.scale,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.cacheWidth,
    this.cacheHeight,
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
    return Image.asset(
      assetPath,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: (context, error, stackTrace) {
        TWidgets.showDebugLog('[TImageAsset]: ${error.toString()}');
        return Image.asset(
          defaultAssetsPath ?? TWidgets.instance.defaultImageAssetsPath!,
          fit: fit,
          scale: scale,
          width: width,
          height: height,
          color: color,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
        );
      },
      scale: scale,
      width: width,
      height: height,
      color: color,
      fit: fit,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
    );
  }
}
