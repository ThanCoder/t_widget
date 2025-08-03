import 'package:flutter/material.dart';

import '../t_widgets.dart';

class TImageUrl extends StatelessWidget {
  String url;
  String? defaultAssetsPath;
  BoxFit fit;
  double? width;
  double? height;
  double? size;
  double borderRadius;
  Widget? loadingProgressWidget;
  FilterQuality filterQuality;

  TImageUrl({
    super.key,
    required this.url,
    this.defaultAssetsPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.size,
    this.borderRadius = 5,
    this.filterQuality = FilterQuality.medium,
    this.loadingProgressWidget,
  });

  Widget _getImageWidget() {
    if (TWidgets.instance.defaultImageAssetsPath == null) {
      throw Exception('you should called => `await TWidgets.instance.init()`');
    }
    if (TWidgets.instance.defaultImageAssetsPath!.isEmpty) {
      throw Exception('defaultImageAssetsPath is required!');
    }
    defaultAssetsPath = TWidgets.instance.defaultImageAssetsPath;
    if (url.isEmpty) {
      return Image.asset(defaultAssetsPath!, fit: fit);
    } else {
      return Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        filterQuality: filterQuality,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          if (loadingProgressWidget != null) {
            return loadingProgressWidget!;
          }
          return Center(child: TLoaderRandom());
        },
        errorBuilder: (context, error, stackTrace) {
          TWidgets.instance.showDebugLog('TImageUrl:error $url');
          return Image.asset(defaultAssetsPath!, fit: fit);
        },
      );
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
