import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TImage extends StatelessWidget {
  final String source;
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
  const TImage({
    super.key,
    required this.source,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 5,
    this.size,
    this.errorBuilder,
    this.frameBuilder,
    this.loadingBuilder,
    this.filterQuality = FilterQuality.medium,
  });

  @override
  Widget build(BuildContext context) {
    if (source.startsWith('http')) {
      return TImageUrl(
        url: source,
        borderRadius: borderRadius,
        defaultAssetsPath: defaultAssetsPath,
        fit: fit,
        height: height,
        size: size,
        width: width,
        filterQuality: filterQuality,
        errorBuilder: errorBuilder,
        frameBuilder: frameBuilder,
        loadingBuilder: loadingBuilder,
      );
    }
    return TImageFile(
      path: source,
      borderRadius: borderRadius,
      defaultAssetsPath: defaultAssetsPath,
      fit: fit,
      height: height,
      size: size,
      width: width,
      filterQuality: filterQuality,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
    );
  }
}
