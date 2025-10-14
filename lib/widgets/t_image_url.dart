import 'package:flutter/material.dart';

import '../t_widgets.dart';

class TImageUrl extends StatelessWidget {
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

  const TImageUrl({
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
    if (url.isEmpty) {
      return Image.asset(defaultAssetsPath!, fit: fit);
    } else {
      return Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        filterQuality: filterQuality,
        frameBuilder: frameBuilder,
        loadingBuilder:
            loadingBuilder ??
            (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: TLoader.random());
            },
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) {
              TWidgets.showDebugLog('TImageUrl:error $url');
              return Image.asset(
                defaultAssetsPath ?? TWidgets.instance.defaultImageAssetsPath!,
                fit: fit,
              );
            },
      );
    }
  }
}
