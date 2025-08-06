import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TImage extends StatelessWidget {
  String source;
  String? defaultAssetsPath;
  BoxFit fit;
  double? width;
  double? height;
  double? size;
  double borderRadius;
  Widget? loadingProgressWidget;
  TImage({
    super.key,
    required this.source,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 5,
    this.size,
    this.loadingProgressWidget,
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
        loadingProgressWidget: loadingProgressWidget,
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
    );
  }
}
