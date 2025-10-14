import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets_dev.dart';

class TCacheImage extends StatefulWidget {
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
  State<TCacheImage> createState() => _TCacheImageState();
}

class _TCacheImageState extends State<TCacheImage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant TCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      cacheFile = null;
      init();
    }
    // print('old: ${oldWidget.url} - new: ${widget.url}');
  }

  File? cacheFile;

  void init() async {
    try {
      if (TWidgets.instance.getCachePath == null) return;
      if (TWidgets.instance.onDownloadImage == null) {
        throw Exception(TWidgets.getOnDownloadImageErrorText);
      }
      final cachePath = TWidgets.instance.getCachePath?.call();
      //check file
      final file = File('$cachePath/${widget.url.getName()}.png');
      if (file.existsSync()) {
        setState(() {
          cacheFile = file;
        });
        return;
      }
      await TWidgets.instance.onDownloadImage!(widget.url, file.path);

      if (!mounted) return;
      setState(() {
        cacheFile = file;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {});
      TWidgets.showDebugLog('TCacheImage:error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final source = cacheFile == null ? widget.url : cacheFile!.path;
    return TImage(
      source: source,
      defaultAssetsPath: widget.defaultAssetsPath,
      borderRadius: widget.borderRadius,
      filterQuality: widget.filterQuality,
      fit: widget.fit,
      height: widget.height,
      width: widget.width,
      size: widget.size,
      errorBuilder: widget.errorBuilder,
      frameBuilder: widget.frameBuilder,
      loadingBuilder:
          widget.loadingBuilder ??
          (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: TLoader.random());
          },
    );
  }
}
