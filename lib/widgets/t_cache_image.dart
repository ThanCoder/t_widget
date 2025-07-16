import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/extensions/index.dart';
import 'package:t_widgets/t_widgets.dart';

class TCacheImage extends StatefulWidget {
  String url;
  String? cachePath;
  double? height;
  double? width;
  double? size;
  BoxFit fit;
  double borderRadius;
  TCacheImage({
    super.key,
    required this.url,
    this.cachePath,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.borderRadius = 5,
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
      if (TWidgets.instance.onDownloadCacheImage == null) {
        throw Exception('''await TWidgets.instance.init(
          onDownloadCacheImage: (url, savePath) async {
          //your logic here
          },
        );''');
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
      // await DioServices.instance.getDio.download(widget.url, file.path);

      await TWidgets.instance.onDownloadCacheImage!(widget.url, file.path);

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
      debugPrint('TCacheImage:error: ${e.toString()}');

    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return TLoader();
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
    );
  }
}
