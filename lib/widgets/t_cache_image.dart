import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:crypto/crypto.dart';

class TCacheImage extends StatefulWidget {
  final String url;
  final String? defaultAssetsPath;
  final Widget Function(double progress)? onProgressLoader;
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

  const TCacheImage({
    super.key,
    required this.url,
    this.defaultAssetsPath,
    this.loadingBuilder,
    this.onProgressLoader,
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
  State<TCacheImage> createState() => _TCacheImageState();
}

class _TCacheImageState extends State<TCacheImage> {
  @override
  void didUpdateWidget(covariant TCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // URL အသစ်ဖြစ်မှသာ အရင် download ကို ရပ်ပြီး အသစ်ပြန်စမယ်
    if (oldWidget.url != widget.url) {
      _cancelCurrentDownload(); // အရင် download ကို ရပ်တဲ့ logic
      init();
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  StreamSubscription<List<int>>? subscription;
  HttpClientRequest? request;

  void _cancelCurrentDownload() {
    request?.abort();
    subscription?.cancel();
    request = null;
    subscription = null;
  }

  @override
  void dispose() {
    _cancelCurrentDownload();

    super.dispose();
  }

  bool isLoading = false;
  String errorMessage = '';
  double progress = 0;
  final client = HttpClient();

  void init() async {
    try {
      _cancelCurrentDownload(); // စတာနဲ့ အရင်ဟာကို ရပ်မယ်

      if (!mounted) return;
      setState(() {
        progress = 0;
        errorMessage = '';
        isLoading = false; // အရင်စစ်ဆေးမှုတွေ မလုပ်ခင် reset အရင်ချပါ
      });
      // check cache path
      if (TWidgets.instance.getCachePath == null) {
        errorMessage =
            'You Should Call -> `getCachePath: (url) => \${cacheDir.path}/\${url.getName()}.png`';
        setState(() {});
        return;
      }
      if (saveFile().existsSync()) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      if (TWidgets.instance.onCustomDownloadImage != null) {
        await TWidgets.instance.onCustomDownloadImage!(
          widget.url,
          saveFile().path,
          onProgress: (progress) {
            if (!mounted) return;
            setState(() {
              this.progress = progress;
            });
          },
          onError: (error) {
            if (!mounted) return;
            setState(() {
              errorMessage = error;
            });
          },
        );
      } else {
        // default
        await downloadImageDefaultFun(
          widget.url,
          saveFile().path,
          client: client,
          onDownloadStart: (subscription, request) {
            this.subscription = subscription;
            this.request = request;
          },
          onProgress: (progress) {
            if (!mounted) return;
            setState(() {
              this.progress = progress;
            });
          },
          onDownloaded: () {
            if (!mounted) return;
            setState(() {
              progress = 0;
              errorMessage = '';
            });
          },
          onError: (error) {
            if (!mounted) return;
            setState(() {
              errorMessage = error;
            });
          },
        );
      }

      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = '';
      });
    } catch (e) {
      errorMessage = e.toString();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  File saveFile() {
    final savePath = TWidgets.instance.getCachePath!(
      widget.url,
      '${_getName()}.png',
    );
    return File(savePath);
  }

  String _getName() {
    return md5.convert(utf8.encode(widget.url)).toString();
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox(width: 100, height: 100, child: _getWidget());
    return _getWidget();
  }

  Widget _getWidget() {
    if (isLoading) {
      return Center(
        child: widget.onProgressLoader != null
            ? widget.onProgressLoader!(progress)
            : progress == 0
            ? TLoaderRandom()
            : CircularProgressIndicator(value: progress),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 11, color: Colors.red),
        ),
      );
    }
    return TImageFile(
      key: widget.key,
      path: saveFile().path,
      defaultAssetsPath: widget.defaultAssetsPath,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      frameBuilder: widget.frameBuilder,
      filterQuality: widget.filterQuality,
      scale: widget.scale,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      color: widget.color,
      opacity: widget.opacity,
      colorBlendMode: widget.colorBlendMode,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      isAntiAlias: widget.isAntiAlias,
      cacheWidth: widget.cacheWidth,
      cacheHeight: widget.cacheHeight,
      errorBuilder:
          widget.errorBuilder ??
          (context, error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
    );
  }
}

Future<void> downloadImageDefaultFun(
  String url,
  String savePath, {
  required HttpClient client,
  void Function(String error)? onError,
  required void Function(double progress) onProgress,
  required void Function(
    StreamSubscription<List<int>> subscription,
    HttpClientRequest request,
  )
  onDownloadStart,
  void Function()? onDownloaded,
}) async {
  final temFile = File('$savePath.tmp');
  final completer = Completer<void>();

  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      // စုစုပေါင်း ပုံရဲ့ Size (Header ကနေ ယူတာပါ)
      final total = response.contentLength;
      int received = 0;

      final sink = temFile.openWrite();
      // Response ကို stream အဖြစ် နားထောင်ပြီး Progress တွက်မယ်
      final sub = response.listen(
        (List<int> chunk) async {
          // await Future.delayed(Duration(milliseconds: 900));

          received += chunk.length;
          sink.add(chunk); // File ထဲ ထည့်မယ်

          if (total != -1) {
            // final progress = (received / total * 100).toStringAsFixed(0);
            // print('Download Progress: $progress%');
            onProgress(received / total);
          }
        },
        onDone: () async {
          await sink.close();
          await temFile.rename(savePath);
          // print('Download complete and saved to $savePath');
          onDownloaded?.call();
          completer.complete();
        },
        onError: (e) {
          // print('Error during download: $e');
          sink.close();
          onError?.call('Error during download: $e');
          completer.completeError(e);
        },
        cancelOnError: true,
      );
      onDownloadStart(sub, request);
    } else {
      // print('Server Error: ${response.statusCode}');
      onError?.call('Server Error: ${response.statusCode}');
      completer.completeError('Server Error');
    }
  } catch (e) {
    onError?.call('Connection Error: $e');
    completer.completeError(e);
  }
  return completer.future;

  // try {
  //   // ၁။ Request ပို့ပါ
  //   final request = await client.getUrl(Uri.parse(url));

  //   // ၂။ Response ကို စောင့်ပါ
  //   final response = await request.close();

  //   // ၃။ Status Code ကို စစ်ပါ (၂၀၀ ဆိုရင် အိုကေ)
  //   if (response.statusCode == HttpStatus.ok) {
  //     // Response stream ကို file ထဲကို တိုက်ရိုက် pipe လုပ်ပါ (Memory အစားသက်သာဆုံးနည်း)
  //     await response.pipe(file.openWrite());

  //     // print('Download complete: $savePath');
  //     onDownloaded?.call();
  //   } else {
  //     if (file.existsSync()) {
  //       file.delete();
  //     }
  //     onError?.call('Download failed: ${response.statusCode}');
  //     // print('Download failed: ${response.statusCode}');
  //   }
  // } catch (e) {
  //   if (file.existsSync()) {
  //     file.delete();
  //   }
  //   onError?.call('Error: $e');
  //   // print('Error: $e');
  // } finally {
  //   // ၄။ Client ကို အမြဲတမ်း ပြန်ပိတ်ပေးဖို့ လိုပါတယ်
  //   client.close();
  // }
}

// void main() async {
//   const url = 'https://example.com/image.jpg';
//   const path = 'cached_image.jpg';
  
//   await downloadImageDefaultFun(url, path);
// }