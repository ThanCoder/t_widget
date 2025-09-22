import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets_dev.dart';

class TCacheImage extends StatefulWidget {
  String url;
  String? cachePath;
  double? height;
  double? width;
  double? size;
  BoxFit fit;
  double borderRadius;
  Widget? loadingProgressWidget;
  TCacheImage({
    super.key,
    required this.url,
    this.cachePath,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.borderRadius = 5,
    this.loadingProgressWidget,
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

  bool isLoading = false;
  bool isExists = false;

  void init() async {
    try {
      if (widget.cachePath == null) return;
      if (TWidgets.instance.onDownloadImage == null) {
        throw Exception(TWidgets.getOnDownloadImageErrorText);
      }
      //check file
      final file = File('${widget.cachePath}/${widget.url.getName()}');
      if (await file.exists()) {
        setState(() {
          isExists = true;
        });
        return;
      }
      //မရှိရင်
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      await TWidgets.instance.onDownloadImage!(widget.url, file.path);

      if (!mounted) return;
      setState(() {
        isLoading = false;
        isExists = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      TWidgets.showDebugLog('TCacheImage:error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      if (widget.loadingProgressWidget != null) {
        return widget.loadingProgressWidget!;
      }
      return Center(child: TLoaderRandom());
    }
    if (isExists) {
      return TImageFile(
        path: '${widget.cachePath}/${widget.url.getName()}',
        width: widget.height,
        height: widget.height,
        size: widget.size,
        fit: widget.fit,
        borderRadius: widget.borderRadius,
      );
    }
    return TImageUrl(
      url: widget.url,
      width: widget.height,
      height: widget.height,
      size: widget.size,
      fit: widget.fit,
      borderRadius: widget.borderRadius,
      loadingProgressWidget: widget.loadingProgressWidget,
    );
  }
}
